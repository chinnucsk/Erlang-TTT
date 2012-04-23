-module(ai).
-export([take_space/3]).

take_space(Board, AICharacter, OpponentCharacter) ->
  SpecialCase = special_case:check(Board, AICharacter, OpponentCharacter),
  case SpecialCase of
    {true, Space} -> Space;
    false -> non_special_case(Board, AICharacter, OpponentCharacter)
  end.

non_special_case(Board, AICharacter, OpponentCharacter) ->
  FreeSpaces = free_spaces(Board),
  SpaceScoreReport = lists:map(space_report(Board, AICharacter, OpponentCharacter), FreeSpaces),
  {Score, Space} = lists:max(SpaceScoreReport),
  Space.

space_report(Board, AICharacter, OpponentCharacter) ->
  fun(Space) ->
      NewBoard = board:take_space(Board, Space, AICharacter),
      {score(NewBoard, AICharacter, OpponentCharacter, OpponentCharacter, 1), Space}
  end.

score(Board, AICharacter, OpponentCharacter, Turn, Depth) ->
  GameOver = game_rules:end_game(Board),
  case GameOver of
    {true, draw} -> 0;
    {true, AICharacter} -> ai_win_weight(Depth);
    {true, OpponentCharacter} -> opponent_win_weight(Depth);
    false ->
      FreeSpaces = free_spaces(Board),
      Scores = lists:map(next_level_score(Board, AICharacter, OpponentCharacter, Turn, Depth), FreeSpaces),
      lists:sum(Scores)
  end.

ai_win_weight(Depth) ->
  case Depth of
    1 -> urgent_move();
    _ -> 1
  end.

opponent_win_weight(Depth) ->
  case Depth of
    2 -> -1 * urgent_move();
    _ -> -1
  end.

next_level_score(Board, AICharacter, OpponentCharacter, Turn, Depth) ->
  fun(Space) ->
      NewDepth = Depth + 1,
      NewBoard = board:take_space(Board, Space, Turn),
      NewTurn = switch_turn(AICharacter, OpponentCharacter, Turn),
      score(NewBoard, AICharacter, OpponentCharacter, NewTurn, NewDepth)
  end.

free_spaces(Board) ->
  Length = length(Board),
  free_spaces(Length, Length, [], Board).
free_spaces(0, _, FoundSpaces, _) ->
  FoundSpaces;
free_spaces(Row, 0, FoundSpaces, Board) ->
  free_spaces(Row-1, length(Board), FoundSpaces, Board);
free_spaces(Row, Column, FoundSpaces, Board) ->
  IsOpen = board:is_open_space(Board, {Row, Column}),
  case IsOpen of
    true -> AccumulatedFoundSpaces = lists:append(FoundSpaces, [{Row, Column}]);
    false -> AccumulatedFoundSpaces = FoundSpaces
  end,
  free_spaces(Row, Column-1, AccumulatedFoundSpaces, Board).

switch_turn(AICharacter, OpponentCharacter, Turn) ->
  if
    AICharacter == Turn -> OpponentCharacter;
    OpponentCharacter == Turn -> AICharacter
  end.

urgent_move() ->
  10000.
