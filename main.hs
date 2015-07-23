splitLines [] = []
splitLines cs =
    let (pre, suf) = break isLineTerminate cs
    in pre : case suf of
        ('\r':'\n':rest) -> splitLines rest
        ('\r':rest) -> splitLines rest
        ('\n':rest) -> []

isLineTerminate c = c =='\r' || c == '\n'

