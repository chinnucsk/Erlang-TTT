-module(ui).
-export([start/1, input/1, output/2]).

start({io_device, IODevice}) ->
  spawn(fun() -> ui_message_interactor(IODevice) end).

ui_message_interactor(IODevice) ->
  receive
    greet ->
      output(IODevice, 'Welcome to Erlang TTT\n');
    {setup_player, Pid, XorO} ->
      output(IODevice, string:concat('What type of Player is? ', XorO);
    game_over ->
      ok
  end.

input(IODevice) ->
  apply(IODevice, read, []).

output(IODevice, Message) ->
  apply(IODevice, write, [Message]).


