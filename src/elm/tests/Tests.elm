module Tests exposing (..)

import Test exposing (..)
import Expect
import FluxPortal

import WebSocket


all : Test
all =
    describe "Fluxportal Test Suite"
        [ describe "Unit test examples"
          [ test "do nothing on blank input" <|
              \() ->
                Expect.equal Cmd.none (FluxPortal.submitMessage "")
          , test "send text message over WebSocket" <|
            \() ->
              let
                msg = "wamp town racers"
              in
                Expect.equal
                  (WebSocket.send FluxPortal.websocketUrl msg)
                  (FluxPortal.submitMessage msg)
          ]
        ]
