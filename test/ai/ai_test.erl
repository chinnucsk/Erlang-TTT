-module(ai_test).
-include_lib("eunit/include/eunit.hrl").

take_space_1_element_test() ->
  Board = [[game_record:untaken_space()]],
  Space = ai:take_space(Board, x, o),
  ?assertEqual({1, 1}, Space).

take_space_3_element_test() ->
  AI = x,
  Opponent = o,
  Empty = game_record:untaken_space(),
  Board = [[Empty, x, o],
           [x,     o, x],
           [x,     o, o]],
  Space = ai:take_space(Board, AI, Opponent),
  ?assertEqual({1, 1}, Space).

take_space_for_the_win_test() ->
  AI = x,
  Opponent = o,
  Empty = game_record:untaken_space(),
  Board = [[Empty,    Opponent, AI],
           [Opponent, AI,       Empty],
           [Empty,    Empty,    Empty]],
 ?assertEqual({3, 1}, ai:take_space(Board, AI, Opponent)).

take_space_block_loss_test() ->
  AI = x,
  Opponent = o,
  Empty = game_record:untaken_space(),
  Board = [[Empty, AI,       Opponent],
           [AI,    Opponent, Empty   ],
           [Empty, Empty,    Empty   ]],
  ?assertEqual({3, 1}, ai:take_space(Board, AI, Opponent)).

take_space_prefer_win_to_block_loss_test() ->
  AI = x,
  Opponent = o,
  Empty = game_record:untaken_space(),
  Board = [[Empty, AI   , Opponent],
           [Empty, AI   , Opponent],
           [Empty, Empty, Empty   ]],
  ?assertEqual({3, 2}, ai:take_space(Board, AI, Opponent)).

take_space_avoid_fork_upper_left_lower_right_test() ->
  AI = o,
  Opponent = x,
  Empty = game_record:untaken_space(),
  Board = [[Opponent, Empty, Empty   ],
           [Empty,    AI,    Empty   ],
           [Empty,    Empty, Opponent]],
  Space = ai:take_space(Board, AI, Opponent),
  ForkBlock = (Space == {1, 2})
           or (Space == {2, 1})
           or (Space == {2, 3})
           or (Space == {3, 2}),
  ?assert(ForkBlock).

take_space_avoid_fork_upper_right_lower_left_test() ->
  AI = o,
  Opponent = x,
  Empty = game_record:untaken_space(),
  Board = [[Empty,    Empty, Opponent],
           [Empty,    AI,    Empty   ],
           [Opponent, Empty, Empty   ]],
  Space = ai:take_space(Board, AI, Opponent),
  ForkBlock = (Space == {1, 2})
           or (Space == {2, 1})
           or (Space == {2, 3})
           or (Space == {3, 2}),
  ?assert(ForkBlock).
