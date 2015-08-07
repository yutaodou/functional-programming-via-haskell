import Data.Char(toUpper)

-- interact
main = interact (map toUpper . (++) "Your data, in uppercase, is \n\n")
