-module(runner).
-export([run/1]).

run(io_device) ->
  ui_interactor:greet(io_device),
  PlayerXType = ui_interactor:get_player_type(io_device, x),
  PlayerOType = ui_interactor:get_player_type(io_device, o).

