lucky :: (Integral a) => a -> String
lucky 7 = "Lucky number 7!"
lucky x = "Sorry, man!"

bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
    | bmi <= skinny = "Great"
    | bmi <= normal = "Normal!"
    | bmi <= fat = "Fat"
    | otherwise = "Kiding me?"
    where bmi = weight / height ^2
          skinny = 18.5
          normal = 25.0
          fat = 30.0

main = do 
    print $ lucky 7
    print $ lucky 8
    print $ bmiTell 55 160

