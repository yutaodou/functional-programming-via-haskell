main =
    putStrLn "Hello world, what's your name?" >>
    getLine >>=
    (\inputStr -> putStrLn $ "Welcome to Haskell, " ++ inputStr ++"!")
