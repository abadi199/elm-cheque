module Cheque.Update exposing (Msg(..), update)

{-| Update functions and Msg.

# Message
@docs Msg

# Update functions
@docs update
-}

import Input.Number as Number
import Input.Text as Text
import Cheque.Model exposing (Model, Field)
import Helpers.Misc as Helper
import Date exposing (Date)


{-| A union type representing The Elm Architect's `Msg`
-}
type Msg
    = NoOp
    | UpdateAmount Number.Msg
    | UpdatePayableTo Text.Msg
    | UpdateName Text.Msg
    | UpdateAddress Text.Msg
    | UpdateCity Text.Msg
    | UpdateState Text.Msg
    | UpdateCountry Text.Msg
    | UpdateZipCode Text.Msg
    | UpdateDate Text.Msg
    | UpdateMemo Text.Msg


{-| The Elm Architect's update function.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateAmount numberMsg ->
            ( { model | amount = updateNumberInput numberMsg model.amount }
            , Cmd.none
            )

        UpdatePayableTo textMsg ->
            ( { model | payableTo = updateStringInput textMsg model.payableTo }
            , Cmd.none
            )

        UpdateName textMsg ->
            ( { model | name = updateStringInput textMsg model.name }
            , Cmd.none
            )

        UpdateAddress textMsg ->
            ( { model | address = updateStringInput textMsg model.address }
            , Cmd.none
            )

        UpdateCity textMsg ->
            ( { model | city = updateStringInput textMsg model.city }
            , Cmd.none
            )

        UpdateState textMsg ->
            ( { model | state = updateStringInput textMsg model.state }
            , Cmd.none
            )

        UpdateCountry textMsg ->
            ( { model | country = updateStringInput textMsg model.country }
            , Cmd.none
            )

        UpdateZipCode textMsg ->
            ( { model | zipCode = updateStringInput textMsg model.zipCode }
            , Cmd.none
            )

        UpdateDate textMsg ->
            ( { model | date = updateStringInput textMsg model.date }
            , Cmd.none
            )

        UpdateMemo textMsg ->
            ( { model | memo = updateStringInput textMsg model.memo }
            , Cmd.none
            )


updateFieldValue : Maybe a -> Field a -> Field a
updateFieldValue newValue field =
    { field | value = newValue }


updateStringInput : Text.Msg -> Field String -> Field String
updateStringInput textMsg field =
    let
        toField stringInputModel =
            { field
                | value = Just stringInputModel.value
                , hasFocus = stringInputModel.hasFocus
            }
    in
        field
            |> Helper.toStringInputModel
            |> Text.update textMsg
            |> toField


updateDateInput : Text.Msg -> Field Date -> Field Date
updateDateInput textMsg field =
    let
        toField numberInputModel =
            { field
                | value = numberInputModel.value |> Date.fromString |> Result.toMaybe
                , hasFocus = numberInputModel.hasFocus
            }
    in
        field
            |> Helper.toDateInputModel
            |> Text.update textMsg
            |> toField


updateNumberInput : Number.Msg -> Field String -> Field String
updateNumberInput numberMsg field =
    let
        toField numberInputModel =
            { field
                | value = Just numberInputModel.value
                , hasFocus = numberInputModel.hasFocus
            }
    in
        field
            |> Helper.toNumberInputModel
            |> Number.update numberMsg
            |> toField
