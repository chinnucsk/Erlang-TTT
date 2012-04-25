-module(game_server).
-export([start/1]).
-include("../game_record/game_record.hrl").

start(IODevice) ->
  ui_interactor:greet(IODevice),
  spawn(fun() -> event() end).

event() ->
  receive
    {continue, Pid, IODevice, undefined} ->
      GameRecord = game_record:new_game(3),
      continue_game(Pid, GameRecord);
    {continue, Pid, IODevice, GameRecord} ->
      GameState = game_state_interactor:update(IODevice, GameRecord),
      case GameState of
        {end_game, EndState} ->
          ui_interactor:end_game(EndState),
          end_game(Pid);
        _ -> continue_game(Pid, GameState)
      end
  end,
  event().

continue_game(Pid, GameRecord) ->
  Pid ! {continue, GameRecord}.

end_game(Pid) ->
  Pid ! game_over,
  exit(self(), kill).
