module Cheque.View
    exposing
        ( form
        , amountInput
        , payableToInput
          -- , payableToInput
          -- , addressInput
          -- , cityInput
          -- , stateInput
          -- , zipCodeInput
          -- , dateInput
        , chequeView
        )

{-| View related functions

# Form View
@docs form

# Cheque View
@docs chequeView

# Individual Fields View
@docs amountInput, payableToInput, payableToInput
-}

import Cheque.Model exposing (Model, Options, Field)
import Html exposing (Html, Attribute, div, text, input, button, label, ul, li, p)
import Html.Attributes exposing (class, type', id, value, placeholder, for)
import Html.App as App
import Cheque.Update exposing (Msg(..))
import Cheque.Components.Cheque as Cheque
import Helpers.Misc as Helper
import Input.Text as Text
import Input.Number as Number
import Date exposing (Date)


{-| A view function that will render the whole form fields including the card.

To use this view, just include this function as part of your view function.

Example:

    form []
        [ Html.App.map CreditCardMsg (CreditCard.View.form model.creditCardModel)
        , button [] [ text "Checkout "]
        ]

-}
form : Model -> Html Msg
form model =
    div [ class "elm-card" ]
        [ chequeView model
        , amountInput "ChequeAmount" [] model
        , payableToInput "ChequePayableTo" [] model
        , dateInput "ChequeDate" [] model
        , nameInput "ChequeName" [] model
        , addressInput "ChequeAddress" [] model
        , cityInput "ChequeCity" [] model
        , stateInput "ChequeState" [] model
        , zipCodeInput "ChequeZipCode" [] model
        , memoInput "ChequeMemo" [] model
        ]


{-| A view function that will render the input field for credit card number.

To use this view, just include this function as part of your view function.

Example:

    form []
        [ Html.App.map CreditCardMsg (CreditCard.View.amountInput "NumberInput" model.creditCardModel)
        , button [] [ text "Checkout "]
        ]

-}
amountInput : String -> List (Attribute Number.Msg) -> Model -> Html Msg
amountInput id attributes model =
    App.map UpdateAmount
        (viewIntField model.options
            { id = id
            , maxLength = Just 10
            , maxValue = Nothing
            , minValue = Nothing
            }
            attributes
            model.amount
        )


{-| A view function that will render the input field for full name.

To use this view, just include this function as part of your view function.

Example:

    form []
        [ Html.App.map CreditCardMsg (CreditCard.View.payableToInput "NameInput" model.creditCardModel)
        , button [] [ text "Checkout "]
        ]

-}
payableToInput : String -> List (Attribute Text.Msg) -> Model -> Html Msg
payableToInput id attributes model =
    App.map UpdatePayableTo
        (viewStringField model.options
            (Text.defaultOptions id)
            attributes
            model.payableTo
        )


dateInput : String -> List (Attribute Text.Msg) -> Model -> Html Msg
dateInput id attributes model =
    App.map UpdateDate
        (viewStringField model.options
            (Text.defaultOptions id)
            attributes
            model.date
        )


nameInput : String -> List (Attribute Text.Msg) -> Model -> Html Msg
nameInput id attributes model =
    App.map UpdateName
        (viewStringField model.options
            (Text.defaultOptions id)
            attributes
            model.name
        )


addressInput : String -> List (Attribute Text.Msg) -> Model -> Html Msg
addressInput id attributes model =
    App.map UpdateAddress
        (viewStringField model.options
            (Text.defaultOptions id)
            attributes
            model.address
        )


cityInput : String -> List (Attribute Text.Msg) -> Model -> Html Msg
cityInput id attributes model =
    App.map UpdateCity
        (viewStringField model.options
            (Text.defaultOptions id)
            attributes
            model.city
        )


stateInput : String -> List (Attribute Text.Msg) -> Model -> Html Msg
stateInput id attributes model =
    App.map UpdateState
        (viewStringField model.options
            (Text.defaultOptions id)
            attributes
            model.state
        )


zipCodeInput : String -> List (Attribute Text.Msg) -> Model -> Html Msg
zipCodeInput id attributes model =
    App.map UpdateZipCode
        (viewStringField model.options
            (Text.defaultOptions id)
            attributes
            model.zipCode
        )


memoInput : String -> List (Attribute Text.Msg) -> Model -> Html Msg
memoInput id attributes model =
    App.map UpdateMemo
        (viewStringField model.options
            { id = id
            , maxLength = Just 39
            }
            attributes
            model.memo
        )


{-| A view function that will render the credit card.

This view will renders the credit card information such as the number, full name, expiration month/year, ccv, and the card logo.

This component also provide a card flipping animation for flipping back and forth between the front and back side of the card when displaying CCV number.
Some type of card has CCV printed on the front side of the card, in this case, the flipping animation will not be performed.

To use this view, just include this function as part of your view function. This will render the card as svg element.

Example:

    form []
        [ Html.App.map CreditCardMsg (CreditCard.Components.Card.cardView model.creditCardModel)
        , button [] [ text "Checkout "]
        ]

-}
chequeView : Model -> Html Msg
chequeView =
    Cheque.chequeView


viewStringField : Options -> Text.Options -> List (Attribute Text.Msg) -> Field String -> Html Text.Msg
viewStringField options textOptions attributes field =
    let
        stringInput =
            Text.input textOptions
                (List.append attributes [ placeholder options field ])
                (Helper.toStringInputModel field)
    in
        if options.showLabel then
            p []
                [ viewLabel textOptions.id options field
                , stringInput
                ]
        else
            stringInput


viewDateField : Options -> Text.Options -> List (Attribute Text.Msg) -> Field Date -> Html Text.Msg
viewDateField options textOptions attributes field =
    let
        stringInput =
            Text.input textOptions
                (List.append attributes [ placeholder options field ])
                (Helper.toDateInputModel field)
    in
        if options.showLabel then
            p []
                [ viewLabel textOptions.id options field
                , stringInput
                ]
        else
            stringInput


viewIntField : Options -> Number.Options -> List (Attribute Number.Msg) -> Field String -> Html Number.Msg
viewIntField options numberInputOptions attributes field =
    let
        input =
            Number.input numberInputOptions
                (List.append attributes [ placeholder options field ])
                (Helper.toNumberInputModel field)
    in
        if options.showLabel then
            p []
                [ viewLabel numberInputOptions.id options field
                , input
                ]
        else
            input


viewLabel : String -> Options -> Field a -> Html msg
viewLabel id options field =
    if options.showLabel then
        field.label
            |> Maybe.map (\labelText -> label [ for id ] [ text labelText ])
            |> Maybe.withDefault (text "")
    else
        text ""


placeholder : Options -> Field a -> Attribute msg
placeholder options field =
    if options.showLabel then
        Html.Attributes.placeholder ""
    else
        field.label
            |> Maybe.map Html.Attributes.placeholder
            |> Maybe.withDefault (Html.Attributes.placeholder "")
