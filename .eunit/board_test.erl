-module(board_test).
-include_lib("eunit/include/eunit.hrl").

create_1_x_1_test() ->
  Board = board:create(1),
  ?assertEqual([[empty]], Board).

create_3_x_3_test() ->
  Empty = game_record:untaken_space(),
  Board = board:create(3),
  ?assertEqual([[Empty, Empty, Empty],
                [Empty, Empty, Empty],
                [Empty, Empty, Empty]],
              Board).

is_open_space_true_test() ->
  Board = [[game_record:untaken_space()]],
  ?assert(board:is_open_space(Board, {1, 1})).

is_open_space_false_test() ->
  Board = [[taken]],
  ?assertNot(board:is_open_space(Board, {1, 1})).

take_space_test() ->
  Board = [[game_record:untaken_space()]],
  NewBoard = board:take_space(Board, {1, 1}, x),
  ?assertEqual([[x]], NewBoard).

take_space_3_sized_board_test() ->
  Board = board:create(3),
  NewBoard = board:take_space(Board, {2, 2}, x),
  Empty = game_record:untaken_space(),
  ?assertEqual([[Empty, Empty, Empty],
                [Empty, x, Empty],
                [Empty, Empty, Empty]],
              NewBoard).

