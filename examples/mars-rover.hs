data Direction = N | E | S | W
    deriving (Show)

data Command = L | R | M
    deriving (Show)

type Point = (Int, Int)
data MarsRover = MarsRover Point Direction
    deriving (Show)

execute :: MarsRover -> Command -> MarsRover
execute rover command =
    case command of
        L -> turnLeft rover
        R -> turnRight rover
        M -> move rover

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

main :: IO()
main = do
    putStrLn $ show $ move.turnLeft.move.turnRight.move $ MarsRover (0, 0) S