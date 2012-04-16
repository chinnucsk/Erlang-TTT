-module(ui).
-export([start/1, input/1, output/2]).

start({io_device, IODevice}) ->
  spawn(fun() -> ui_message_interactor(IODevice) end).

ui_message_interactor(IODevice) ->
  receive
    greet ->
      output(IODevice, 'Welcome to Erlang TTT');
    game_over ->
      ok
  end.

input(IODevice) ->
  apply(IODevice, read, []).

output(IODevice, Message) ->
  apply(IODevice, write, [Message]).


