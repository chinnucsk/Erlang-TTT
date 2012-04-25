-module(special_case).
-export([check/3]).

check(Board, AICharacter, OpponentCharacter) ->
  Length = length(Board),
  case Length of
    3 -> three_dimension_cases(Board, AICharacter, OpponentCharacter);
    _ -> false
  end.

three_dimension_cases(Board, AICharacter, OpponentCharacter) ->
  {ForkCase, Fork} = check_fork(Board, AICharacter, OpponentCharacter),
  {FirstMoveCase, FirstMove} = check_first_move(Board),
  if
    ForkCase -> {true, Fork};
    FirstMoveCase -> {true, FirstMove};
    true -> false
  end.

check_fork(Board, AICharacter, OpponentCharacter) ->
  case board_matches_fork(Board, AICharacter, OpponentCharacter) of
    true -> {true, {1, 2}};
    false -> {false, no_match}
  end.

check_first_move(Board) ->
  case Board == board:create(3) of
    true -> {true, {1, 1}};
    false -> {false, no_match}
  end.

board_matches_fork(Board, AI, Opponent) ->
  Empty = game_record:untaken_space(),
  (Board == [[Empty,    Empty, Opponent],
             [Empty,    AI   , Empty   ],
             [Opponent, Empty, Empty   ]]) or
  (Board == [[Opponent, Empty, Empty   ],
             [Empty,    AI   , Empty   ],
             [Empty,    Empty, Opponent]]).

