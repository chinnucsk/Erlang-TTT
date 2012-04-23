-module(special_case).
-export([check/3]).

check(Board, AICharacter, OpponentCharacter) ->
  Length = length(Board),
  case Length of
    3 -> three_dimension_cases(Board, AICharacter, OpponentCharacter);
    _ -> false
  end.

three_dimension_cases(Board, AICharacter, OpponentCharacter) ->
  Fork = check_fork(Board, AICharacter, OpponentCharacter),
  FirstMove = check_first_move(Board),
  case Fork of
    {true, _} -> Fork;
    false ->
        case FirstMove of
          true -> {true, {1, 1}};
          false -> false
        end
  end.

check_fork(Board, AICharacter, OpponentCharacter) ->
  case board_matches_fork(Board, AICharacter, OpponentCharacter) of
    true -> {true, {1, 2}};
    false -> false
  end.

check_first_move(Board) ->
  Board == board:create(3).

board_matches_fork(Board, AI, Opponent) ->
  Empty = game_record:untaken_space(),
  (Board == [[Empty,    Empty, Opponent],
             [Empty,    AI   , Empty   ],
             [Opponent, Empty, Empty   ]]) or
  (Board == [[Opponent, Empty, Empty   ],
             [Empty,    AI   , Empty   ],
             [Empty,    Empty, Opponent]]).

