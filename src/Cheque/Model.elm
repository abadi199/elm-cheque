module Cheque.Model
    exposing
        ( Model
        , Options
        , Field
        , init
        , defaultOptions
        )

{-| Model types and all related helper functions

# Model
@docs Model, Field

# Styling and Formatting
@docs Options

# Helper Functions
@docs init, defaultOptions
-}

import Svg exposing (Svg, Attribute)
import Date exposing (Date)


{-| A type representing the Credit Cheque model.
-}
type alias Model =
    { options : Options
    , amount : Field String
    , payableTo : Field String
    , name : Field String
    , address : Field String
    , city : Field String
    , state : Field String
    , country : Field String
    , zipCode : Field String
    , date : Maybe Date
    }


{-| A type representing the configurable options for the form.
-}
type alias Options =
    { showLabel : Bool
    , blankChar : Char
    }


{-| A type representing an input field with specific type.
-}
type alias Field a =
    { id : String
    , label : Maybe String
    , value : Maybe a
    , hasFocus : Bool
    }


{-| A type representing the Cheque style.
-}
type alias ChequeStyle msg =
    { background : { attributes : List (Attribute msg), svg : List (Svg msg), defs : List (Svg msg) }
    , textColor : String
    , lightTextColor : String
    , darkTextColor : String
    }


{-| Initalize the model by passing in the `Options`
-}
init : Options -> Model
init options =
    { options = options
    , amount = { id = "", label = Just "Amount", value = Nothing, hasFocus = False }
    , payableTo = { id = "", label = Just "Payable To", value = Nothing, hasFocus = False }
    , name = { id = "", label = Just "Name", value = Nothing, hasFocus = False }
    , address = { id = "", label = Just "Address", value = Nothing, hasFocus = False }
    , city = { id = "", label = Just "City", value = Nothing, hasFocus = False }
    , state = { id = "", label = Just "State", value = Nothing, hasFocus = False }
    , country = { id = "", label = Just "Country", value = Nothing, hasFocus = False }
    , zipCode = { id = "", label = Just "Zip Code", value = Nothing, hasFocus = False }
    , date = Nothing
    }


{-| The default `Options` value
-}
defaultOptions : Options
defaultOptions =
    { showLabel = False
    , blankChar = '•'
    }
