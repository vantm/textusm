module Data.ItemSettings exposing
    ( ItemSettings
    , decoder
    , encoder
    , getBackgroundColor
    , getFontSize
    , getForegroundColor
    , getOffset
    , new
    , toString
    , withBackgroundColor
    , withFontSize
    , withForegroundColor
    , withOffset
    )

import Data.Color as Color exposing (Color)
import Data.FontSize as FontSize exposing (FontSize)
import Data.Position as Position exposing (Position)
import Json.Decode as D
import Json.Decode.Pipeline exposing (optional, required)
import Json.Encode as E
import Json.Encode.Extra exposing (maybe)


type ItemSettings
    = ItemSettings Settings


type alias Settings =
    { backgroundColor : Maybe Color
    , foregroundColor : Maybe Color
    , offset : Position
    , fontSize : FontSize
    }


new : ItemSettings
new =
    ItemSettings
        { backgroundColor = Nothing
        , foregroundColor = Nothing
        , offset = Position.zero
        , fontSize = FontSize.default
        }


getBackgroundColor : ItemSettings -> Maybe Color
getBackgroundColor (ItemSettings settings) =
    settings.backgroundColor


getForegroundColor : ItemSettings -> Maybe Color
getForegroundColor (ItemSettings settings) =
    settings.foregroundColor


getOffset : ItemSettings -> Position
getOffset (ItemSettings settings) =
    settings.offset


getFontSize : ItemSettings -> FontSize
getFontSize (ItemSettings settings) =
    settings.fontSize


withBackgroundColor : Maybe Color -> ItemSettings -> ItemSettings
withBackgroundColor bg (ItemSettings settings) =
    ItemSettings { settings | backgroundColor = bg }


withForegroundColor : Maybe Color -> ItemSettings -> ItemSettings
withForegroundColor fg (ItemSettings settings) =
    ItemSettings { settings | foregroundColor = fg }


withOffset : Position -> ItemSettings -> ItemSettings
withOffset position (ItemSettings settings) =
    ItemSettings { settings | offset = position }


withFontSize : FontSize -> ItemSettings -> ItemSettings
withFontSize fontSize (ItemSettings settings) =
    ItemSettings { settings | fontSize = fontSize }


encoder : ItemSettings -> E.Value
encoder (ItemSettings settings) =
    E.object
        [ ( "b", maybe E.string (Maybe.andThen (\c -> Just <| Color.toString c) settings.backgroundColor) )
        , ( "f", maybe E.string (Maybe.andThen (\c -> Just <| Color.toString c) settings.foregroundColor) )
        , ( "o", E.list E.int [ Position.getX settings.offset, Position.getY settings.offset ] )
        , ( "s", E.int <| FontSize.unwrap settings.fontSize )
        ]


decoder : D.Decoder ItemSettings
decoder =
    D.map ItemSettings
        (D.succeed
            Settings
            |> optional "b" (D.map Just Color.decoder) Nothing
            |> optional "f" (D.map Just Color.decoder) Nothing
            |> required "o" Position.decoder
            |> required "s" FontSize.decoder
        )


toString : ItemSettings -> String
toString settings =
    E.encode 0 (encoder settings)
