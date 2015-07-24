module Main ( main ) where

import SimpleJSON
import PutJSON
main = putJValue(JObject [("foo",JNumber 1.0),("bar", JBool False)])
