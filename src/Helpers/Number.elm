module Helpers.Number exposing (toWords)

import Helpers.Misc exposing (get, getString)


toWords : Int -> String
toWords number =
    if number == 0 then
        "zero"
    else if number < 100 then
        convertNN number
    else
        convertNNN number


to19 : List String
to19 =
    [ "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" ]


tens : List String
tens =
    [ "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" ]


denom : List String
denom =
    [ "hundred", "thousand", "million", "billion" ]


convertNN : Int -> String
convertNN number =
    if number < 20 then
        getString number to19
    else if number < 100 then
        let
            tensDigit =
                floor (number / 10) - 2

            singleDigit =
                number % 10

            tensWord =
                getString tensDigit tens
        in
            if singleDigit == 0 then
                tensWord
            else
                tensWord ++ " " ++ getString singleDigit to19
    else
        ""


convertNNN : Int -> String
convertNNN number =
    let
        hundredsDigit =
            number // 100

        denomLength =
            List.length denom

        denomNumber =
            [0..denomLength]
                |> List.map ((^) 1000)

        denomIndex =
            denomNumber
                |> List.filter (flip (<=) number)
                |> List.length
                |> flip (-) 1

        denomDigit =
            number // get 0 denomIndex denomNumber

        denomRemainder =
            number % get 0 denomIndex denomNumber
    in
        if number < 1000 then
            getString hundredsDigit to19
                ++ space
                ++ getString 0 denom
                ++ space
                ++ convertNN (number - (100 * hundredsDigit))
        else
            getString denomIndex denom
                |> (++) space
                |> (++) (toWords denomDigit)
                |> flip (++) space
                |> flip (++)
                    (if denomRemainder == 0 then
                        ""
                     else
                        toWords denomRemainder
                    )


space : String
space =
    " "
