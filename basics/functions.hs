-- Infix functions or value constructor
a `plus` b = a + b

data a `Pair` b = a `Pair` b
    deriving (Show)

asInt :: String -> Int

asInt xs = loop 0 xs
loop acc (x:xs) = let acc' = acc * 10 + digitToInt x
                  in loop acc' xs 


main  = do
    putStrLn ("Hello")
    putStrLn ("123 is" ++ (asInt "123"))