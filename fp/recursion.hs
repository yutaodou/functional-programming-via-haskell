-- find max value from a list
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum of empty list"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

-- find max value from a list 
maximum2' :: (Ord a) => [a] -> a
maximum2' input = case input of
        [] -> error "no max for empty list"
        [x] -> x
        (x:xs) -> max x (maximum2' xs)

-- replicate a value 
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0 = []
    | otherwise = x:replicate' (n-1) x

--- take n values from a list
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' i (x:xs)
    | i <= 0  = []
    | otherwise = x:take' (i-1) xs

reverse' :: [a] -> [a]
reverse' list = case list of
    [] -> []
    (x:xs) -> reverse' xs ++ [x]
    

main = do
    print $ maximum' [1,2,3,45,9]
    print $ maximum2' [1,2,3,45,9]
    print $ replicate' 2 55
    print $ take' 4 [1,2,3,4,5,6]
    print $ reverse' [1,2,3,4,5]