-- file: tempfile.hs

import System.IO
import System.Directory(getTemporaryDirectory, removeFile)
-- import System.IO.Error(catch)
import Control.Exception(catch, finally)

-- main entry point
main :: IO ()
main = withTempFile "mytemp.txt" myAction

myAction :: FilePath -> Handle -> IO ()
myAction tempname temph =
    do
        putStrLn "Welcome to temfile.hs"
        putStrLn $ "I have a temporary file at "++ tempname

        pos <- hTell temph
        putStrLn $ "My initial position is " ++ show pos

        let tempdata = show [1..10]
        putStrLn $ "Write one line containing " ++ show (length tempdata) ++
                    " bytes " ++ tempdata
        hPutStrLn temph tempdata

        pos <- hTell temph
        putStrLn $ "After writing, my new position is " ++ show pos

        putStrLn $" The file count is : "
        hSeek temph AbsoluteSeek 0
        c <- hGetContents temph

        putStrLn c

        putStrLn $ "Which could be expressed as this Haskell literal: "
        print c
withTempFile :: String -> (FilePath -> Handle -> IO () ) -> IO ()
withTempFile pattern func =
    do
        -- tempdir <- catch (getTemporaryDirectory) (\_ -> return ".")
        tempdir <- getTemporaryDirectory
        (tempfile, temph) <- openTempFile tempdir pattern

        finally (func tempfile temph)
                (do hClose temph
                    removeFile tempfile)
