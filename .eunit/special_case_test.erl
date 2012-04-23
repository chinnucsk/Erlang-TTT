-module(special_case_test).
-include_lib("eunit/include/eunit.hrl").

check_3_element_no_moves_test() ->
  AI = x,
  Opponent = o,
  Empty = game_record:untaken_space(),
  Board = [[AI   , Opponent, Empty],
           [Empty, Empty,    Empty],
           [Empty, Empty,    Empty]],
  ?assertNot(special_case:check(Board, AI, Opponent)).

check_3_element_no_fork_test() ->
  AI = x,
  Opponent = o,
  Empty = game_record:untaken_space(),
  Board = [[AI,       Empty,    Empty],
           [Empty,    Opponent, Empty],
           [Opponent, Opponent, Empty]],
  ?assertNot(special_case:check(Board, AI, Opponent)).

check_3_element_fork_upper_left_lower_right_test() ->
  AI = o,
  Opponent = x,
  Empty = game_record:untaken_space(),
  Board = [[Opponent, Empty, Empty   ],
           [Empty,    AI   , Empty   ],
           [Empty,    Empty, Opponent]],
  {true, Space} = special_case:check(Board, AI, Opponent),
  ForkBlock = (Space == {1, 2})
           or (Space == {2, 1})
           or (Space == {2, 3})
           or (Space == {3, 2}),
  ?assert(ForkBlock).

check_3_element_fork_upper_right_lower_left_test() ->
  AI = o,
  Opponent = x,
  Empty = game_record:untaken_space(),
  Board = [[Empty,    Empty, Opponent],
           [Empty,    AI   , Empty   ],
           [Opponent, Empty, Empty   ]],
  {true, Space} = special_case:check(Board, AI, Opponent),
  ForkBlock = (Space == {1, 2})
           or (Space == {2, 1})
           or (Space == {2, 3})
           or (Space == {3, 2}),
  ?assert(ForkBlock).

check_first_move_test() ->
  AI = x,
  Opponent = o,
  Board = board:create(3),
  {true, Space} = special_case:check(Board, AI, Opponent),
  ?assertEqual({1, 1}, Space).
