-module(game_state_interactor).
-export([update/2]).
-export([update_player_type/3]).
-export([take_turn/2, retrieve_player_turn_space/3]).
-include("../game_record/game_record.hrl").

update(IODevice, GameState) ->
  XPlayerType = game_record:get_player_type(GameState, x),
  OPlayerType = game_record:get_player_type(GameState, o),
  if
    XPlayerType == undefined ->
      update_player_type(IODevice, GameState, x);
    OPlayerType == undefined ->
      update_player_type(IODevice, GameState, o);
    true ->
      update_in_progress(IODevice, GameState)
  end.

update_player_type(IODevice, OldGameState, PlayerCharacter) ->
  PlayerType = player_type_interactor:player_type(IODevice, PlayerCharacter),
  NewGameState = game_record:set_player_type(OldGameState, {PlayerCharacter, PlayerType}),
  NewGameState.

update_in_progress(IODevice, GameState) ->
  EndState = game_rules:end_game(game_record:get_board(GameState)),
  case EndState of
    {true, End} ->
      ui_interactor:print_board(IODevice, game_record:get_board(GameState)),
      {end_game, End};
    false -> take_turn(IODevice, GameState)
  end.

take_turn(IODevice, GameState) ->
  ui_interactor:print_board(IODevice, game_record:get_board(GameState)),
  PlayerTurn = game_record:get_player_turn(GameState),
  TurnSpace = retrieve_player_turn_space(IODevice, GameState, PlayerTurn),
  ValidMove = board:is_open_space(game_record:get_board(GameState), TurnSpace),
  case ValidMove of
    true ->
      game_record:switch_player_turn(game_record:take_space(GameState, TurnSpace, PlayerTurn));
    false ->
      ui_interactor:inform_move_invalid(IODevice),
      take_turn(IODevice, GameState)
  end.

retrieve_player_turn_space(IODevice, GameState, PlayerTurn) ->
  PlayerType = game_record:get_player_type(GameState, PlayerTurn),
  case PlayerType of
    human ->
      human:take_space(IODevice, PlayerTurn);
    ai ->
      Board = game_record:get_board(GameState),
      AI = PlayerTurn,
      Opponent = game_record:get_player_turn(game_record:switch_player_turn(GameState)),
      ai:take_space(Board, AI, Opponent)
  end.
