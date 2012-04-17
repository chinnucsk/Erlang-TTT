-module(game_record).
-export([new_game/1]).
-include("game_record.hrl").

new_game(BoardSize) when BoardSize>0 ->
  #game{turn = x, board = create_board(BoardSize), _ = '_'}.

create_board(BoardSize) ->
  lists:duplicate(BoardSize, board_row(BoardSize)).

board_row(BoardSize) ->
  lists:duplicate(BoardSize, empty).

