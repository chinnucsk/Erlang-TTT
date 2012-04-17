-module(game_record).
-export([new_game/1, set_player_type/2]).
-include("game_record.hrl").

new_game(BoardSize) when BoardSize>0 ->
  #game{turn = x, board = create_board(BoardSize), _ = undefined}.

create_board(BoardSize) ->
  lists:duplicate(BoardSize, board_row(BoardSize)).

board_row(BoardSize) ->
  lists:duplicate(BoardSize, empty).

set_player_type(GameState, {x, XType}) ->
  GameState#game{player_x_type = XType};
set_player_type(GameState, {o, OType}) ->
  GameState#game{player_o_type = OType}.
