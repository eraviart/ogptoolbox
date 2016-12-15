module Authenticator.SignIn.Types exposing (..)

import Authenticator.Routes exposing (Route)
import Dict exposing (Dict)
import Http
import Types exposing (UserBody)


type alias Errors =
    Dict String String


type ExternalMsg
    = ChangeRoute (Maybe Route)


type alias Fields =
    { password : String
    , username : String
    }


type InternalMsg
    = SignedIn (Result Http.Error UserBody)
    | Submit
    | UsernameInput String
    | PasswordInput String


type alias Model =
    { httpError : Maybe Http.Error
    , errors : Errors
    , password : String
    , username : String
    }


type Msg
    = ForParent ExternalMsg
    | ForSelf InternalMsg


type alias MsgTranslation parentMsg =
    { onChangeRoute : Maybe Route -> parentMsg
    , onInternalMsg : InternalMsg -> parentMsg
    }


type alias MsgTranslator parentMsg =
    Msg -> parentMsg


translateMsg : MsgTranslation parentMsg -> MsgTranslator parentMsg
translateMsg { onChangeRoute, onInternalMsg } msg =
    case msg of
        ForParent (ChangeRoute route) ->
            onChangeRoute route

        ForSelf internalMsg ->
            onInternalMsg internalMsg
