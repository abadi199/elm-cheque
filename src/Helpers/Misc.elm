module Helpers.Misc
    exposing
        ( onKeyDown
        , toNumberInputModel
        , toStringInputModel
        )

import Html.Events exposing (on, keyCode)
import Html exposing (Attribute, Html, input)
import Json.Decode as Json
import Cheque.Model exposing (Model, Field)
import Input.Number as Number
import Input.Text as Text


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)


toNumberInputModel : Field String -> Number.Model
toNumberInputModel =
    toStringInputModel


toStringInputModel : Field String -> Text.Model
toStringInputModel field =
    { value = field.value |> Maybe.withDefault "", hasFocus = field.hasFocus }
