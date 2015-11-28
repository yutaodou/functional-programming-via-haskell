-- BookInfo is a type constructor, often used in signature
-- Book is a value constructor, used expression
-- A type's type constructor and value construcotr can be the same
data BookInfo = Book Int String [String]
    deriving (Show)

-- Type Synonyms
-- used to make code more readable
type CustomerId = Int
type ReviewBody = String

data BookReview = BookReview BookInfo CustomerId ReviewBody

type BookRecord = (BookInfo, BookReview)

-- Algebraic data types
-- have multiple value constructors, which are usually referred as alternatives
-- or cases
data Bool = True | False

type CardHolder = String
type CardNumber = String
type Address = [String]

data BillingInfo = CreditCard CardNumber CardHolder Address
    | CashOnDelivery
    | Invoice CustomerId
    deriving (Show)
