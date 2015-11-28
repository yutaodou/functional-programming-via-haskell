sequencelyDo_ :: [IO ()] -> IO ()
sequencelyDo_ [] = return ()
sequencelyDo_ (x:xs) = do x
                          sequencelyDo_ xs

putStr2 :: String -> IO ()
putStr2 s = sequencelyDo_ (map putChar s)

map2 :: String -> [IO ()]
map2 s = map putChar s

main :: IO ()
main = putStr2 "hello" >> putStr2 "hello"