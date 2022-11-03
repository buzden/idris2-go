module Basics13

import Control.Monad.Either
import Go.AST.Printer as Go
import Go.AST.Combinators as Go
import System.File

main : IO ()
main = do
  let src = file "type-conversions.go"
              (package "main")
              [ import' "fmt"
              , import' "math"
              ]
              [ func (id' "main") [] void
                [ decl $ vars [ var [id' "x", id' "y"] (Just $ id' "int") [int 3, int 4] ]
                , decl $ vars [ var [id' "f"] (Just $ id' "float64") [
                    call (id' "math" /./ "Sqrt") [
                      call (id' "float64") [ id' "x" /*/ id' "x" /+/ id' "y" /*/ id' "y" ]
                    ]
                  ] ]
                , decl $ vars [ var [id' "z"] (Just $ id' "uint") [
                    call (id' "uint") [id' "f"]
                  ] ]
                , expr $ call (id' "fmt" /./ "Println") [id' "x", id' "y", id' "z"]
                ]
              ]
  putStrLn "printing source:\n"
  Right () <- runEitherT $ Go.print stdout src
    | Left e => putStrLn $ show e
  pure ()

