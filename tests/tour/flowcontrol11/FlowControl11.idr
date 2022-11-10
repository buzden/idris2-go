module FlowControl11

import Control.Monad.Either
import Go.AST.Printer as Go
import Go.AST.Combinators as Go
import System.File

main : IO ()
main = do
  let src = file "switch-with-no-condition.go"
              (package "main")
              [ import' "fmt"
              , import' "time"
              ]
              [ func (id' "main") [] void
                [ [ id' "t" ] /:=/ [ call (id' "time" /./ "Now") [] ]
                , switch'
                  [ case' [call (id' "t" /./ "Hour") [] /</ int 12]
                    [ expr $ call (id' "fmt" /./ "Println") [string "Good morning!"] ]
                  , case' [call (id' "t" /./ "Hour") [] /</ int 17]
                    [ expr $ call (id' "fmt" /./ "Println") [string "Good afternoon."] ]
                  , default'
                    [ expr (call (id' "fmt" /./ "Println") [string "Good evening."]) ]
                  ]
                ]
              ]
  putStrLn "printing source:\n"
  Right () <- runEitherT $ Go.print stdout src
    | Left e => putStrLn $ show e
  pure ()

