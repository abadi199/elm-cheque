module Helpers.Number exposing (toWords)

import Helpers.Misc exposing (get)


toWords : Int -> String
toWords number =
    if number < 100 then
        convertNN number
    else if number < 1000 then
        convertNNN number
    else
        ""


to19 : List String
to19 =
    [ "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" ]


tens : List String
tens =
    [ "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" ]


denom : List String
denom =
    [ "hundred", "thousand", "million", "billion", "trillion", "quadrillion", "quintillion", "sextillion", "septillion", "octillion", "nonillion", "decillion", "undecillion", "duodecillion", "tredecillion", "quattuordecillion", "sexdecillion", "septendecillion", "octodecillion", "novemdecillion", "vigintillion" ]


convertNN : Int -> String
convertNN number =
    if number < 20 then
        get number to19
    else
        let
            tensDigit =
                floor (number / 10) - 2

            singleDigit =
                number % 10

            tensWord =
                get tensDigit tens
        in
            if singleDigit == 0 then
                tensWord
            else
                tensWord ++ " " ++ get singleDigit to19


convertNNN : Int -> String
convertNNN number =
    let
        hundredsDigit =
            number // 100
    in
        if number < 1000 then
            get hundredsDigit to19
                ++ " "
                ++ get 0 denom
                ++ " "
                ++ convertNN (number - (100 * hundredsDigit))
        else
            ""
