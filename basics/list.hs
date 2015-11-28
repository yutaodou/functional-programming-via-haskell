boombangs xs = [ if x `mod` 3 == 0 then "BOOM!" else "BANG!" | x <-xs, odd x]

removeNonUppercase xs = [x | x <-xs, x `elem` ['A'..'Z']]

main = do 
    mapM_ print (boombangs [ x | x <-[1..100]])    
    mapM_ print $ removeNonUppercase "I Love Haskell Very Much"
