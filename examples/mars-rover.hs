data Direction = N | E | S | W
    deriving (Show)

data Command = L | R | M
    deriving (Show)

type Point = (Int, Int)
data MarsRover = MarsRover Point Direction
    deriving (Show)

run :: Maybe Command -> MarsRover -> MarsRover
run command rover =
    case command of
        Just L -> turnLeft rover
        Just R -> turnRight rover
        Just M -> move rover
        Nothing -> rover

turnLeft :: MarsRover -> MarsRover
turnLeft rover = case rover of
        MarsRover p N -> MarsRover p W
        MarsRover p W -> MarsRover p S
        MarsRover p S -> MarsRover p E
        MarsRover p E -> MarsRover p N

turnRight :: MarsRover -> MarsRover
turnRight rover =
    case rover of
        MarsRover p N -> MarsRover p E
        MarsRover p W -> MarsRover p N
        MarsRover p S -> MarsRover p W
        MarsRover p E -> MarsRover p S

move :: MarsRover -> MarsRover
move rover =
    case rover of
        MarsRover (x, y) N -> MarsRover (x, y+1) N
        MarsRover (x, y) E -> MarsRover (x+1, y) E
        MarsRover (x, y) W -> MarsRover (x-1, y) W
        MarsRover (x, y) S -> MarsRover (x, y-1) S

parse :: Char -> Maybe  Command
parse c = case c of
    'L' -> Just L
    'R' -> Just R
    'M' -> Just M
    _ -> Nothing

(>) :: (a -> b) -> (b -> c) -> a -> c
(>) f g = g.f

main :: IO()
main = do
    let execute = foldr (Main.>) id $ map run $ map parse "MLMRMLMRM"
    putStrLn $ show $ execute $ MarsRover (0, 0) S
