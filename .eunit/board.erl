-module(board).
-export([create/1, is_open_space/2, take_space/3]).

create(BoardSize) ->
  lists:duplicate(BoardSize, row(BoardSize)).

row(BoardSize) ->
  lists:duplicate(BoardSize, game_record:untaken_space()).

is_open_space(Board, Space) ->
  {Row, Column} = Space,
  InBounds = in_bounds(Row, Column, length(Board)),
  case InBounds of
    true -> game_record:untaken_space() == lists:nth(Column, lists:nth(Row, Board));
    false -> false
  end.

in_bounds(Row, Column, BoardDimension) ->
  Positive = (Row > 0) and (Column > 0),
  OnBoard = (Row =< BoardDimension) and (Column =< BoardDimension),
  Positive and OnBoard.

take_space(Board, Space, PlayerCharacter) ->
  {Row, Column} = Space,
  NewRow = change_nth(Column, lists:nth(Column, Board), PlayerCharacter),
  NewBoard = change_nth(Row, Board, NewRow),
  NewBoard.

change_nth(Column, OldList, NewValue) ->
  Tail = lists:nthtail(Column, OldList),
  Reverse = lists:reverse(OldList),
  Length = length(OldList),
  Head = lists:nthtail(Length-Column+1, Reverse),
  Head ++ [NewValue] ++ Tail.
