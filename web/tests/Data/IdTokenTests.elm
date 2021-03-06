module Data.IdTokenTests exposing (..)

import Data.IdToken as IdToken
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "IdToken test"
        [ describe "fromString test"
            [ test "bearer test" <|
                \() ->
                    Expect.equal (IdToken.fromString "test" |> IdToken.unwrap) "Bearer test"
            ]
        ]
