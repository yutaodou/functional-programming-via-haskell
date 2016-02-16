
(|>>) x f = map f x
(|>) x f = f x
total xs = foldl (+) 0 xs

-- Define data types
data Category = Book | Food | Medical | Other
    deriving (Show, Eq)

data Product = Product String Float Bool Category
    deriving (Show)

type Qty = Int
data CartItem = CartItem Product Qty
    deriving (Show)

data Cart = Cart {getCartItems :: [CartItem]}
    deriving (Show)

data Tax = BasicTax | ImportTax

getTax :: Product -> Tax -> Float
getTax product tax = case tax of
    BasicTax -> getBasicTax product
    ImportTax -> getImportTax product
    where getBasicTax product = case (product) of
            (Product _ price _ Other) -> 0.1 * price
            _ -> 0.0
          getImportTax product = case (product) of
            (Product _ price True _) -> 0.05 * price
            _ -> 0.0

getProductTax :: Product -> Float
getProductTax product = [BasicTax, ImportTax] |>> getTax product |> total

getProductTotal :: Product -> Float
getProductTotal product = getPrice product + getProductTax product
    where getPrice (Product _ price _ _) = price

getItemTotal :: CartItem -> Float
getItemTotal (CartItem product qty) = (fromIntegral qty) * (getProductTotal product)

getCartTotal :: Cart -> Float
getCartTotal cart = getCartItems cart |>> getItemTotal |> total

perform :: [IO ()] -> IO ()
perform = foldr (>>) (return ())

main :: IO ()
main = do
    let input = [ "1 imported bottle of perfume at 27.99\n", 
                  "1 bottle of perfume at 18.99\n", 
                  "1 packet of headache pills at 9.75\n", 
                  "1 box of imported chocolates at 11.25\n"]

    let cart = [ (CartItem (Product "imported bottle of perfume" 27.99 True Other) 1),
                 (CartItem (Product "bottle of perfume" 18.99 False Other) 1),
                 (CartItem (Product "packate of headache pills" 9.75 False Medical) 1),
                 (CartItem (Product "box of imported chocolates" 11.25 False Medical) 1) ]

    putStr $ show (cart |>> getItemTotal |> total)

