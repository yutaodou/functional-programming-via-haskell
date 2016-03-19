data Direction = N | E | S | W
    deriving (Show)

data Command = L | R | M
    deriving (Show)

type Point = (Int, Int) 

data MarsRover = MarsRover Point Direction
    deriving (Show)

getPosition :: MarsRover -> Point
getPosition (MarsRover point _) = point

type Log = [Point]

newtype Logger a =  Logger (a, Log)
    deriving (Show)

instance Monad Logger where
    return a = Logger (a, [])
    m >>= k = let (a, x) = execLogger m
                  n     = k a
                  (b, y) = execLogger n
              in Logger (b, x ++ y)

execLogger :: Logger a -> (a, Log)
execLogger (Logger (a, log)) = (a, log)

record :: MarsRover -> Logger MarsRover
record marsRover = Logger (marsRover, [point])
    where point = getPosition marsRover
    
run :: Maybe Command -> MarsRover -> Logger MarsRover
run command rover =
    case command of
        Just L -> return $ turnLeft rover
        Just R -> return $ turnRight rover
        Just M -> (move' rover) >>= record
        Nothing -> return rover
    where move' rover = return (move rover)

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

apply :: Logger MarsRover -> [MarsRover -> Logger MarsRover] -> Logger MarsRover
apply rover actions = case actions of
    [] ->  rover
    (x:xs) -> apply (rover >>= x) xs

main :: IO()
main = do
    let rover = MarsRover (0, 0) S
    let actions = map run $ map parse "MLMRMLMRM"
    let result = apply (record rover) actions
    putStrLn $ show result