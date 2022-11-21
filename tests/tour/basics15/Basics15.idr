module Basics15

import Go.AST.Printer as Go
import Go.AST.Combinators as Go

main : IO ()
main = do
  let src = file "constants.go"
              (package "main")
              [ import' "fmt" ]
              [ consts [ const' [id' "Pi"] (Maybe Identifier `the` Nothing) [float 3.14] ]
              , func (id' "main") [] void
                [ decl $ consts [ const' [id' "World"] (Maybe Identifier `the` Nothing) [string "世界"] ]
                , expr $ call (id' "fmt" /./ "Println") [string "Hello", id' "World"]
                , expr $ call (id' "fmt" /./ "Println") [string "Happy", id' "Pi", string "Day"]
                , decl $ consts [ const' [id' "Truth"] (Maybe Identifier `the` Nothing) [bool True] ]
                , expr $ call (id' "fmt" /./ "Println") [string "Go rules?", id' "Truth"]
                ]
              ]

  Right () <- printFile "build/go" src
    | Left e => putStrLn $ show e
  pure ()

