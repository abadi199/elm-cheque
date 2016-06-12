module Cheque.Components.Cheque exposing (chequeView)

import Html exposing (Html, div)
import Html.Attributes exposing (style)
import Cheque.Model exposing (Model)
import Cheque.Update exposing (Msg)
import Svg exposing (Svg, svg, rect, text', text, foreignObject, defs, g, line)
import Svg.Attributes as Attributes exposing (id, fill, height, width, x, y, viewBox, fontFamily, strokeWidth, fontSize, stroke, x1, y1, x2, y2, fontWeight, strokeOpacity)
import Styles.Background as Background


chequeView : Model -> Html Msg
chequeView model =
    div
        [ Html.Attributes.class "elm-cheque-svg"
        ]
        [ svg
            [ width "700"
            , height "280"
            , viewBox "0 0 700 280"
            , fontSize "12px"
            , fontFamily "arial"
            ]
            [ background model
            , chequeNumber model
            , date model
            , payableTo model
            , amount model
            , amountWords model
            , memo model
            , signature model
            , name model
            , address model
            ]
        ]


chequeNumber : Model -> Svg msg
chequeNumber model =
    g [ id "chequeNumber" ]
        [ text' [ fontFamily "serif", x "630", y "40", fontSize "16px", fontWeight "bold" ] [ text "0000" ] ]


date : Model -> Svg msg
date model =
    g [ id "date" ]
        [ text' [ x "450", y "90" ] [ text "DATE" ]
        , line [ x1 "490", y1 "90", x2 "620", y2 "90", stroke "black", strokeWidth "1px" ] []
        ]


background : Model -> Svg msg
background model =
    g [ id "background" ]
        [ defs [] [ Background.pattern ]
        , rect [ x "0", y "0", width "100%", height "100%", strokeWidth "0", fill "url(#chequePattern)" ] []
        , rect [ x "10", y "10", width "680", height "260", strokeWidth "4", stroke "#d3dbd4", fill "none" ] []
        ]


payableTo : Model -> Svg msg
payableTo model =
    g [ id "payableTo" ]
        [ text' [ x "35", y "120" ] [ text "PAY TO THE" ]
        , text' [ x "35", y "135" ] [ text "ORDER OF" ]
        , line [ x1 "105", y1 "135", x2 "540", y2 "135", strokeWidth "1px", stroke "black" ] []
        ]


amount : Model -> Svg msg
amount model =
    g [ id "amount" ]
        [ text' [ x "550", y "131", fontSize "18px" ] [ text "$" ]
        , rect [ x "565", y "115", width "100", height "20", strokeWidth "1px", stroke "black", fill "white", strokeOpacity "0.5" ] []
        , text' [ x "605", y "170" ] [ text "DOLLARS" ]
        ]


amountWords : Model -> Svg msg
amountWords model =
    g [ id "amountWords" ]
        [ line [ x1 "35", y1 "170", x2 "600", y2 "170", strokeWidth "1px", stroke "black" ] []
        ]


memo : Model -> Svg msg
memo model =
    g [ id "memo" ]
        [ text' [ x "30", y "245" ] [ text "MEMO" ]
        , line [ x1 "75", y1 "245", x2 "370", y2 "245", stroke "black", strokeWidth "1px" ] []
        ]


signature : Model -> Svg msg
signature model =
    g [ id "signature" ]
        [ line [ x1 "420", y1 "245", x2 "665", y2 "245", stroke "black", strokeWidth "1px" ] []
        ]


name : Model -> Svg msg
name model =
    g [ id "name" ]
        [ text' [ x "30", y "35", fontSize "14px", fontWeight "bold" ] [ text "Abadi Kurniawan" ] ]


address : Model -> Svg msg
address model =
    g [ id "address" ]
        [ text' [ x "30", y "50" ] [ text "886 Wood Ave" ]
        , text' [ x "30", y "65" ] [ text "Kirkwood, MO 63122" ]
        ]
