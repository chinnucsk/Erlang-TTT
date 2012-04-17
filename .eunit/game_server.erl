-module(game_server).
-export([start/0]).
-include("../game_record/game_record.hrl").

start() ->
  spawn(fun() -> event() end).

event() ->
  receive
    {continue, Pid, IODevice, undefined} ->
      ui_interactor:greet(IODevice),
      GameRecord = game_record:new_game(3),
      continue_game(Pid, GameRecord);
    {continue, Pid, IODevice, GameRecord} ->
      if
        GameRecord#game.player_x_type == undefined ->
          PlayerType = ui_interactor:get_player_type(IODevice, x),
          NewGameRecord = game_record:set_player_type(GameRecord, {x, PlayerType}),
          continue_game(Pid, NewGameRecord);
        GameRecord#game.player_o_type == undefined ->
          PlayerType = ui_interactor:get_player_type(IODevice, o),
          NewGameRecord = game_record:set_player_type(GameRecord, {o, PlayerType}),
          continue_game(Pid, NewGameRecord)
      end;
    {kill_server} -> exit(self(), kill)
  end,
  event().

continue_game(Pid, GameRecord) ->
  Pid ! {continue, GameRecord}.

finish_game(Pid, EndState) ->
  Pid ! {game_over, EndState}.
