module Views.Diagram.StartStopContinue exposing (view)

import Constants exposing (..)
import Html exposing (div)
import Html.Attributes as Attr
import List.Extra exposing (getAt)
import Models.Diagram as Diagram exposing (Model, Msg(..), Settings)
import Models.Item as Item exposing (Children(..), Item, ItemType(..))
import String
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


view : Model -> Svg Msg
view model =
    let
        itemHeight =
            Basics.max Constants.largeItemHeight (14 * (List.maximum model.countByTasks |> Maybe.withDefault 0))
    in
    g
        [ transform
            ("translate("
                ++ String.fromInt
                    (if isInfinite <| toFloat <| model.x then
                        0

                     else
                        model.x
                    )
                ++ ","
                ++ String.fromInt
                    (if isInfinite <| toFloat <| model.y then
                        0

                     else
                        model.y
                    )
                ++ ")"
            )
        , fill model.settings.backgroundColor
        ]
        [ -- Start
          canvasView model.settings
            Constants.itemWidth
            itemHeight
            "0"
            "0"
            (model.items
                |> getAt 0
                |> Maybe.withDefault
                    { lineNo = 0
                    , text = ""
                    , itemType = Activities
                    , children = Item.empty
                    }
            )

        -- Stop
        , canvasView model.settings
            Constants.itemWidth
            itemHeight
            (String.fromInt (Constants.itemWidth - 5))
            "0"
            (model.items
                |> getAt 1
                |> Maybe.withDefault
                    { lineNo = 0
                    , text = ""
                    , itemType = Activities
                    , children = Item.empty
                    }
            )

        -- Continue
        , canvasView model.settings
            Constants.itemWidth
            itemHeight
            (String.fromInt (Constants.itemWidth * 2 - 10))
            "0"
            (model.items
                |> getAt 2
                |> Maybe.withDefault
                    { lineNo = 0
                    , text = ""
                    , itemType = Activities
                    , children = Item.empty
                    }
            )
        ]


canvasView : Settings -> Int -> Int -> String -> String -> Item -> Svg Msg
canvasView settings svgWidth svgHeight posX posY item =
    let
        lines =
            Item.unwrapChildren item.children
                |> List.map (\i -> i.text)
    in
    svg
        [ width (String.fromInt svgWidth)
        , height (String.fromInt svgHeight)
        , x posX
        , y posY
        , fill settings.backgroundColor
        ]
        [ g []
            [ rectView (String.fromInt svgWidth) (String.fromInt svgHeight) settings.color.line
            , titleView settings 10 10 item.text
            , textView settings (Constants.itemWidth - 13) svgHeight 10 35 lines
            ]
        ]


rectView : String -> String -> String -> Svg Msg
rectView w h color =
    rect
        [ width w
        , height h
        , stroke color
        , strokeWidth "10"
        ]
        []


titleView : Settings -> Int -> Int -> String -> Svg Msg
titleView settings posX posY title =
    text_
        [ x (String.fromInt posX)
        , y (String.fromInt (posY + 14))
        , fontFamily settings.font
        , fill settings.color.label
        , fontSize "16"
        , fontWeight "bold"
        , class "svg-text"
        ]
        [ text title ]


textView : Settings -> Int -> Int -> Int -> Int -> List String -> Svg Msg
textView settings w h posX posY lines =
    g []
        [ foreignObject
            [ x (String.fromInt posX)
            , y (String.fromInt posY)
            , width (String.fromInt w)
            , height (String.fromInt h)
            , color settings.color.label
            , fontSize "14"
            , fontFamily settings.font
            , class "svg-text"
            ]
            (lines
                |> List.map
                    (\line ->
                        div
                            [ Attr.style "font-family" ("'" ++ settings.font ++ "', sans-serif")
                            , Attr.style "word-wrap" "break-word"
                            , Attr.style "padding" "0 8px 8px 0"
                            , Attr.style "color" <| Diagram.getTextColor settings.color
                            ]
                            [ Html.text line ]
                    )
            )
        ]