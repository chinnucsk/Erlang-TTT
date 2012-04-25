-module(runner).
-export([run/1]).

run(std_io) ->
  run(io_device, std_io).

run(io_device, IODevice) ->
  GameServerPid = game_server:start(IODevice),
  game_client:start(GameServerPid, IODevice).
