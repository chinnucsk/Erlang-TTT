-module(game_record).
-export([new_game/1]).
-export([get_board/1, untaken_space/0, take_space/3]).
-export([set_player_type/2, get_player_type/2]).
-export([get_player_turn/1, switch_player_turn/1]).

-include("game_record.hrl").

untaken_space() ->
  empty.

new_game(BoardSize) when BoardSize>0 ->
  #game{turn = x, board = board:create(BoardSize), _ = undefined}.

get_board(GameState) ->
  GameState#game.board.

take_space(GameState, Space, PlayerCharacter) ->
  Board = GameState#game.board,
  NewGameState = GameState#game{board = board:take_space(Board, Space, PlayerCharacter)},
  NewGameState.

set_player_type(GameState, {x, XType}) ->
  GameState#game{player_x_type = XType};
set_player_type(GameState, {o, OType}) ->
  GameState#game{player_o_type = OType}.

get_player_type(GameState, PlayerCharacter) ->
  case PlayerCharacter of
    x -> GameState#game.player_x_type;
    o -> GameState#game.player_o_type
  end.

get_player_turn(GameState) ->
  GameState#game.turn.

switch_player_turn(GameState) ->
  Turn = get_player_turn(GameState),
  case Turn of
    x -> GameState#game{turn = o};
    o -> GameState#game{turn = x}
  end.
