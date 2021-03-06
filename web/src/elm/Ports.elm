port module Ports exposing (changeText, closeFullscreen, copyClipboard, downloadCompleted, downloadHtml, downloadPdf, downloadPng, downloadSvg, focusEditor, getDiagram, gotLocalDiagramJson, gotLocalDiagramsJson, onAuthStateChanged, onCloseFullscreen, onErrorNotification, onNotification, onWarnNotification, openFullscreen, progress, refreshToken, reload, removeRemoteDiagram, saveDiagram, saveSettings, saveToLocalCompleted, saveToRemote, shortcuts, signIn, signOut, startDownload, updateIdToken)

import Data.Session exposing (User)
import Json.Decode as D
import Json.Encode as E


type alias DownloadInfo =
    { width : Int
    , height : Int
    , id : String
    , title : String
    , text : String
    , x : Float
    , y : Float
    , diagramType : String
    }


port changeText : (String -> msg) -> Sub msg


port progress : (Bool -> msg) -> Sub msg


port onAuthStateChanged : (Maybe User -> msg) -> Sub msg


port startDownload : ({ extension : String, mimeType : String, content : String } -> msg) -> Sub msg


port onNotification : (String -> msg) -> Sub msg


port onErrorNotification : (String -> msg) -> Sub msg


port onWarnNotification : (String -> msg) -> Sub msg


port shortcuts : (String -> msg) -> Sub msg


port removeRemoteDiagram : (D.Value -> msg) -> Sub msg


port downloadPng : DownloadInfo -> Cmd msg


port downloadSvg : DownloadInfo -> Cmd msg


port downloadPdf : DownloadInfo -> Cmd msg


port downloadHtml : DownloadInfo -> Cmd msg


port signIn : String -> Cmd msg


port signOut : () -> Cmd msg


port focusEditor : () -> Cmd msg


port saveSettings : E.Value -> Cmd msg


port copyClipboard : String -> Cmd msg


port downloadCompleted : (( Int, Int ) -> msg) -> Sub msg


port openFullscreen : () -> Cmd msg


port closeFullscreen : () -> Cmd msg


port saveDiagram : E.Value -> Cmd msg


port getDiagram : String -> Cmd msg


port gotLocalDiagramJson : (D.Value -> msg) -> Sub msg


port gotLocalDiagramsJson : (D.Value -> msg) -> Sub msg


port reload : (String -> msg) -> Sub msg


port saveToRemote : (D.Value -> msg) -> Sub msg


port saveToLocalCompleted : (D.Value -> msg) -> Sub msg


port onCloseFullscreen : (D.Value -> msg) -> Sub msg


port refreshToken : () -> Cmd msg


port updateIdToken : (String -> msg) -> Sub msg
