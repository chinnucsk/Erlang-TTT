-module(game_client).
-export([start/2]).
-include("../game_record/game_record.hrl").

start(GameServerPid, IODevice) ->
  Pid = spawn(fun() -> event_loop(GameServerPid, IODevice) end),
  send_update(GameServerPid, Pid, IODevice, undefined),
  Pid.

event_loop(GameServerPid, IODevice) ->
  receive
    {continue, UpdatedGameRecord} ->
      send_update(GameServerPid, self(), IODevice, UpdatedGameRecord);
    game_over ->
      exit(self(), kill)
  end,
  event_loop(GameServerPid, IODevice).

send_update(GameServerPid, ReceiverPid, IODevice, GameRecord) ->
  GameServerPid ! {continue, ReceiverPid, IODevice, GameRecord}.
