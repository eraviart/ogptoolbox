module Urls exposing (..)

import Configuration
import Erl
import List.Extra


fullApiUrl : String -> String
fullApiUrl url =
    let
        parsedApiUrl =
            Erl.parse Configuration.apiUrl

        parsedUrl =
            Erl.parse <| String.trim url
    in
        if List.isEmpty <| List.filter (not << String.isEmpty) parsedUrl.host then
            Erl.toString <|
                { parsedUrl
                    | host = parsedApiUrl.host
                    , port_ = parsedApiUrl.port_
                    , protocol = parsedApiUrl.protocol
                }
        else
            url


fullUrl : String -> String
fullUrl url =
    let
        parsedAppUrl =
            Erl.parse Configuration.appUrl

        parsedUrl =
            Erl.parse <| String.trim url
    in
        if List.isEmpty <| List.filter (not << String.isEmpty) parsedUrl.host then
            Erl.toString <|
                { parsedUrl
                    | host = parsedAppUrl.host
                    , port_ = parsedAppUrl.port_
                    , protocol = parsedAppUrl.protocol
                }
        else
            url


parentUrl : String -> String
parentUrl url =
    let
        parsedUrl =
            Erl.parse url
    in
        if List.isEmpty <| List.filter (not << String.isEmpty) parsedUrl.path then
            url
        else
            Erl.toString <| { parsedUrl | path = List.Extra.init parsedUrl.path |> Maybe.withDefault [] }
