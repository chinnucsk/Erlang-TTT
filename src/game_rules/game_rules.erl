-module(game_rules).
-export([end_game/1]).
-export([horizontal_winner/1, vertical_winner/1, diagonal_winner/1]).
-export([draw/1]).

end_game(Board, [draw]) ->
  Draw = game_rules:draw(Board),
  if
    Draw -> {true, draw};
    true -> false
  end;
end_game(Board, CheckList) ->
  [CurrentCheck|RemainingCheckList] = CheckList,
  Check = apply(game_rules, CurrentCheck, [Board]),
  case Check of
    {true, _} -> Check;
    _ -> end_game(Board, RemainingCheckList)
  end.
end_game(Board) ->
  CheckList = [horizontal_winner, vertical_winner, diagonal_winner, draw],
  end_game(Board, CheckList).

horizontal_winner(true, LastRow, _) ->
  {true, lists:last(LastRow)};
horizontal_winner(false, _, []) ->
  false;
horizontal_winner(false, _, Board) ->
  horizontal_winner(Board).
horizontal_winner(Board) ->
  [Row|Rest] = Board,
  AllEqual = all_equal(Row),
  horizontal_winner(AllEqual, Row, Rest).

vertical_winner(_, 0) ->
  false;
vertical_winner(Board, ColumnNumber) ->
  Column = lists:map(column_fun(ColumnNumber), Board),
  case all_equal(Column) of
    true -> {true, lists:last(Column)};
    false -> vertical_winner(Board, ColumnNumber-1)
  end.
vertical_winner(Board) ->
  vertical_winner(Board, length(Board)).

column_fun(ColumnNumber) ->
  fun(BoardRow) -> lists:nth(ColumnNumber, BoardRow) end.

diagonal_winner(Board) ->
  LeftToRightList = diagonal_list(Board),
  RightToLeftList = diagonal_list(reversed_rows(Board)),
  LeftToRightAllEqual = all_equal(LeftToRightList),
  RightToLeftAllEqual = all_equal(RightToLeftList),
  if
    LeftToRightAllEqual -> {true, lists:last(LeftToRightList)};
    RightToLeftAllEqual -> {true, lists:last(RightToLeftList)};
    true -> false
  end.

diagonal_list([], _, AccumulatedList) ->
  AccumulatedList;
diagonal_list(Board, Nth, AccumulatedList) ->
  [Row|Rest] = Board,
  NewAccumulatedList = lists:merge(AccumulatedList, [lists:nth(Nth, Row)]),
  diagonal_list(Rest, Nth + 1, NewAccumulatedList).
diagonal_list(Board) ->
  diagonal_list(Board, 1, []).

reversed_rows(Board) ->
  ReverseFun = fun(Row) -> lists:reverse(Row) end,
  lists:map(ReverseFun, Board).

draw(Board) ->
  FlatBoard = lists:flatten(Board),
  not lists:member(game_record:untaken_space(), FlatBoard).

all_equal(_, []) ->
  true;
all_equal(Previous, Remaining) ->
  [Head|Tail] = Remaining,
  if
    Previous =/= Head -> false;
    true -> all_equal(Head, Tail)
  end.
all_equal(List) ->
  UntakenSpace = lists:member(game_record:untaken_space(), List),
  if
    UntakenSpace -> false;
    length(List) == 1 -> true;
    true ->
      [Head|Tail] = List,
      all_equal(Head, Tail)
  end.

