import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Keyboard
import WebSocket


websocketUrl : (String)
websocketUrl = "ws://localhost:4050"


main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { input : String
  , messages : List String
  }


init : (Model, Cmd Msg)
init =
  (Model "" [], Cmd.none)



-- UPDATE

type Msg
  = Input String
  | Send
  | NewMessage String
  | KeyMsg Keyboard.KeyCode


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Input newInput ->
      (Model newInput model.messages, Cmd.none)

    Send ->
      (Model "" model.messages, submitMessage model.input)

    NewMessage str ->
      (Model model.input (str :: model.messages), Cmd.none)

    KeyMsg code ->
      if code == 13 then
        (Model "" model.messages, submitMessage model.input)
      else
        (model, Cmd.none)


submitMessage : String -> Cmd msg
submitMessage message =
  if String.isEmpty message then
    Cmd.none
  else
    WebSocket.send websocketUrl message



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ WebSocket.listen websocketUrl NewMessage
    , Keyboard.downs KeyMsg 
    ]



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ div [ class "header" ] [ h1 [] [ text "fluxportal" ] ]
    , div [ class "buffer" ] (List.map viewMessage model.messages |> List.reverse)
    , div [ class "inputContainer" ]
      [ input [ onInput Input, value model.input, class "mainInput", placeholder ">" ] []
      , button [ onClick Send, class "sendButton", tabindex -1 ] [ text "Send" ]
      ]
    ]


viewMessage : String -> Html msg
viewMessage msg =
  div [ class "bufferMessage" ] [ text msg ]
