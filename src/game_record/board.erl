-module(board).
-export([create/1]).
-export([is_open_space/2, take_space/3]).
-export([to_string/1]).

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
  NewRow = change_nth(Column, lists:nth(Row, Board), PlayerCharacter),
  NewBoard = change_nth(Row, Board, NewRow),
  NewBoard.

change_nth(Location, OldList, NewValue) ->
  Head = lists:sublist(OldList, Location-1),
  Tail = lists:nthtail(Location, OldList),
  Head ++ [NewValue] ++ Tail.

to_string(Board) ->
  Length = length(Board),
  Header = header_string(Length),
  Body = body_string(Length, Board),
  Header ++ Body.

header_string(Length) ->
  FirstRow = string:concat("  ", first_row(Length)),
  SecondRowLength = Length * 2 + 2,
  SecondRow = string:concat(string:copies("-", SecondRowLength), "\n"),
  string:concat(FirstRow, SecondRow).

first_row(Length) ->
  first_row(Length, "", 1).
first_row(Length, Accumulation, Position) ->
  PositionString = integer_to_list(Position),
  NewAccumulation = string:concat(Accumulation, string:concat(PositionString, "|")),
  if
    Length == Position -> string:concat(NewAccumulation, "\n");
    true -> first_row(Length, NewAccumulation, Position+1)
  end.

body_string(Length, Board) ->
  body_string(Length, Board, "", 1).
body_string(Length, Board, Accumulation, RowPosition) ->
  Row = lists:nth(RowPosition, Board),
  NewAccumulation = string:concat(Accumulation, row_string(Row, RowPosition)),
  if
    Length == RowPosition -> string:concat(NewAccumulation, "\n");
    true -> body_string(Length, Board, NewAccumulation, RowPosition+1)
  end.

row_string(Row, RowNumber) ->
  RowNumberString = integer_to_list(RowNumber),
  string:concat(string:concat(RowNumberString, "|"), row_list_string(Row)).

row_list_string(Row) ->
  row_list_string(Row, "").
row_list_string([], Accumulation) ->
  string:concat(Accumulation, "\n");
row_list_string(Row, Accumulation) ->
  [Head|Tail] = Row,
  PlayerCharacterString = player_character_string(Head),
  NewAccumulation = string:concat(Accumulation, string:concat(PlayerCharacterString, "|")),
  row_list_string(Tail, NewAccumulation).

player_character_string(PlayerCharacter) ->
  UntakenSpace = game_record:untaken_space(),
  case PlayerCharacter of
    UntakenSpace -> "_";
    Other -> atom_to_list(Other)
  end.

