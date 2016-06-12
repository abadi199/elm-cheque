module Styles.Background exposing (pattern, background)

import Svg exposing (Svg, rect, path, g)
import Svg.Attributes exposing (d, x, y, width, height, fill, strokeWidth, strokeOpacity, id, fillOpacity, stroke, patternUnits, style)


pattern : Svg msg
pattern =
    Svg.pattern
        [ id "chequePattern"
        , x "0"
        , y "0"
        , width "10"
        , height "5"
        , patternUnits "userSpaceOnUse"
        ]
        [ g [ style "background: red" ]
            [ path
                [ d "M 10,0 5.0000001,5 -1.5e-7,0 m 6.00000025,-1 -1,1 -1,-1 M 11.000002,4 5.0000001,10 -1,4"
                , fillOpacity "0"
                , stroke "#DFE9E1"
                , strokeOpacity "1"
                , strokeWidth "2px"
                ]
                []
            ]
        ]


background : Svg msg
background =
    rect [ x "0", y "0", width "100%", height "100%", fill "url(#chequePattern)", strokeWidth "0" ] []
