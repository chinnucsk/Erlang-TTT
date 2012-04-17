-module(runner).
-export([run/1]).

run(std_io) ->
  run(io_device, std_io).

run(io_device, IODevice) ->
  ui_interactor:greet(IODevice),
  PlayerXType = player_type_interactor:player_type(IODevice, x),
  PlayerOType = player_type_interactor:player_type(IODevice, o).

