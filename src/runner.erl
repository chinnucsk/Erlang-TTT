-module(runner).
-export([run/1]).

run(std_io) ->
  run(io_device, std_io).

run(io_device, IODevice) ->
  ui_interactor:greet(IODevice),
  game_loop:start(IODevice).
