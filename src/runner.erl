-module(runner).
-export([run/1]).

run(IODevice) ->
  ui_interactor:greet(IODevice),
  PlayerXType = player_type_interactor:player_type(IODevice, x),
  PlayerOType = player_type_interactor:player_type(IODevice, o).

