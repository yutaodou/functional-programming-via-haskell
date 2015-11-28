zipWith' :: (a ->b->c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

lagestDivisible :: (Integral a ) => a
lagestDivisible = head (filter p [100000, 99999..])
    where p x = x `mod` 3892 == 0

sumOfOddSquare = sum (takeWhile (<1000) (filter odd (map (^2) [1..1000])))

--Collatz sequence
chain :: (Integral a, Eq a)=> a -> [a]
chain n
    | n == 1 = [1]
    | odd n = n : chain (n*3+1)
    | even n = n : chain (n `div` 2)

numLongChains :: Int  
numLongChains = length (filter isLong (map chain [1..100]))  
    where isLong xs = length xs > 15  

tryFoldl = foldl (\a b -> a+b) 0 [1..10]
tryFoldr = foldr (\a b -> a+b) 0 [1..10]


main = do
    print $ zipWith' (+) [1,2,3] [3,2,1]
    print $ zipWith' max [1,2,3] [3,2,1]
    print $ lagestDivisible
    print $ sumOfOddSquare
    print $ chain 13

    print $ length (filter (>15) (map length (map chain [1..100])))
    print $ numLongChains

    print $ filter (\x -> x > 15 && x `mod` 5 == 0) [1..100]
    print $ tryFoldl
    print $ tryFoldr
