module Helpers.Misc
    exposing
        ( onKeyDown
        , toNumberInputModel
        , toStringInputModel
        , moneyFormat
        )

import Html.Events exposing (on, keyCode)
import Html exposing (Attribute, Html, input)
import Json.Decode as Json
import Cheque.Model exposing (Model, Field)
import Input.Number as Number
import Input.Text as Text
import String


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)


toNumberInputModel : Field String -> Number.Model
toNumberInputModel =
    toStringInputModel


toStringInputModel : Field String -> Text.Model
toStringInputModel field =
    { value = field.value |> Maybe.withDefault "", hasFocus = field.hasFocus }


moneyFormat : String -> String
moneyFormat value =
    value
        |> String.reverse
        |> String.toList
        |> partition 3
        |> List.filter (List.isEmpty >> not)
        |> List.map String.fromList
        |> String.join ","
        |> String.reverse


partition : Int -> List a -> List (List a)
partition groupSize xs =
    partitionStep groupSize groupSize xs


partitionStep : Int -> Int -> List a -> List (List a)
partitionStep groupSize step xs =
    let
        group =
            List.take groupSize xs

        xs' =
            List.drop step xs

        okayArgs =
            groupSize > 0 && step > 0

        okayLength =
            groupSize == List.length group
    in
        if okayArgs && okayLength then
            group :: partitionStep groupSize step xs'
        else
            [ group ]
