module Basics9

import Control.Monad.Either
import Go.AST.Printer as Go
import Go.AST.Combinators as Go
import System.File

main : IO ()
main = do
  let src = file "variables-with-initializers.go"
              (package "main")
              [ import' "fmt" ]
              [ vars
                [ var (map id' ["i", "j"]) (Just $ id' "int") [int 1, int 2]
                ]
              , func (id' "main") [] void
                [ decl $ vars
                  [ var (map id' ["c", "python", "java"]) (Maybe Identifier `the` Nothing) [bool True, bool False, string "no!"]
                    ]
                , expr $ call (id' "fmt" /./ "Println") [id' "i", id' "j", id' "c", id' "python", id' "java"]
                ]
              ]
  putStrLn "printing source:\n"
  Right () <- runEitherT $ Go.print stdout src
    | Left e => putStrLn $ show e
  pure ()

