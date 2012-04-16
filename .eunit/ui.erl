-module(ui).
-export([start/2]).

start(io_device, return_pid) ->
  spawn(fun() -> ui_loop(io_device, return_pid) end).

ui_loop(io_device, return_pid) ->
  receive
    greet ->
      greet(io_device);
    game_over ->
      ok
  end.

greet(io_device) ->
  io:write(io_device, 'Erlang Tic-Tac-Toe: New Game').
