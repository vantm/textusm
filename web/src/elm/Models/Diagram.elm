module Models.Diagram exposing (Color, ColorSettings, Model, Msg(..), Point, Settings, Size, UsmSvg, getTextColor)

import Browser.Dom exposing (Viewport)
import Models.DiagramType exposing (DiagramType)
import Models.Item exposing (Item, ItemType(..))


type alias Model =
    { items : List Item
    , hierarchy : Int
    , width : Int
    , height : Int
    , countByHierarchy : List Int
    , countByTasks : List Int
    , svg : UsmSvg
    , moveStart : Bool
    , x : Int
    , y : Int
    , moveX : Int
    , moveY : Int
    , fullscreen : Bool
    , settings : Settings
    , error : Maybe String
    , showZoomControl : Bool
    , touchDistance : Maybe Float
    , diagramType : DiagramType
    , labels : List String
    , text : Maybe String
    , matchParent : Bool
    , showMiniMap : Bool
    }


type alias UsmSvg =
    { width : Int
    , height : Int
    , scale : Float
    }


type alias Settings =
    { font : String
    , size : Size
    , color : ColorSettings
    , backgroundColor : String
    }


type alias ColorSettings =
    { activity : Color
    , task : Color
    , story : Color
    , line : String
    , label : String
    , text : Maybe String
    }


type alias Color =
    { color : String
    , backgroundColor : String
    }


type alias Size =
    { width : Int
    , height : Int
    }


type alias Point =
    { x : Int
    , y : Int
    }


type Msg
    = NoOp
    | Init Settings Viewport String
    | OnChangeText String
    | ZoomIn
    | ZoomOut
    | PinchIn Float
    | PinchOut Float
    | Stop
    | Start Int Int
    | Move Int Int
    | MoveTo Int Int
    | ToggleFullscreen
    | OnResize Int Int
    | StartPinch Float
    | ItemClick Item
    | ItemDblClick Item


getTextColor : ColorSettings -> String
getTextColor settings =
    settings.text |> Maybe.withDefault "#111111"