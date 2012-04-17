-module(runner).
-export([run/1]).

run(std_io) ->
  run(io_device, std_io).

run(io_device, IODevice) ->
  GameServerPid = game_server:start(),
  game_client:start(GameServerPid, self(), IODevice).

