-- Infix functions or value constructor
a `plus` b = a + b

data a `Pair` b = a `Pair` b
    deriving (Show)
main  = do
    putStrLn "Hello"
