-module(game_loop).
-export([start/1]).

start(IODevice) ->
  GameRecord = game_record:new_game(3),
  loop(IODevice, GameRecord).

loop(IODevice, GameRecord) ->
  GameState = game_state_interactor:update(IODevice, GameRecord),
  case GameState of
    {end_game, EndState} -> ui_interactor:end_game(IODevice, EndState);
    _ -> loop(IODevice, GameState)
  end.
