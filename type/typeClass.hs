-- Like generic class, provide behavios for all types

class BasicEq a where
    isEqual :: a -> a -> Bool

instance BasicEq Bool where
    isEqual True True = True
    isEqual False False = True
    isEqual _ _ = False

main =
    putStrLn $ show(True == False)
    putStrLn $ show(Red == Red)
