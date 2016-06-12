module Main
    exposing
        ( main
        )

import Html.App as App
import Cheque.Model as Model exposing (defaultOptions)
import Cheque.Update as Update exposing (Msg)
import Cheque.View as View


subscriptions : Model.Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    App.program
        { init = ( Model.init { defaultOptions | showLabel = True }, Cmd.none )
        , view = View.form
        , update = Update.update
        , subscriptions = subscriptions
        }
