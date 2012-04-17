-module(game_client).
-export([start/3]).
-include("../game_record/game_record.hrl").

start(GameServerPid, MasterPid, IODevice) ->
  Pid = spawn(fun() -> event_loop(GameServerPid, MasterPid, IODevice) end),
  send_update(GameServerPid, Pid, IODevice, undefined),
  Pid.

event_loop(GameServerPid, MasterPid, IODevice) ->
  receive
    {continue, UpdatedGameRecord} ->
      send_update(GameServerPid, self(), IODevice, UpdatedGameRecord);
    {game_over, _} ->
      send_game_over(MasterPid),
      exit(self(), kill)
  end,
  event_loop(GameServerPid, MasterPid, IODevice).

send_update(GameServerPid, ReceiverPid, IODevice, GameRecord) ->
  GameServerPid ! {continue, ReceiverPid, IODevice, GameRecord}.

send_game_over(MasterPid) ->
  MasterPid ! {game_over, self()}.
