-module(board_test).
-include_lib("eunit/include/eunit.hrl").

create_1_x_1_test() ->
  Board = board:create(1),
  ?assertEqual([[game_record:untaken_space()]], Board).

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

is_open_space_negative_out_of_bounds_test() ->
  Board = [[space]],
  ?assertNot(board:is_open_space(Board, {-1, -1})).

is_open_space_outside_of_board_test() ->
  Board = [[space]],
  ?assertNot(board:is_open_space(Board, {2, 2})).

take_space_test() ->
  Board = [[game_record:untaken_space()]],
  NewBoard = board:take_space(Board, {1, 1}, x),
  ?assertEqual([[x]], NewBoard).

take_space_3_sized_board_test() ->
  Empty = game_record:untaken_space(),
  Board = [[x, o,     Empty],
           [o, Empty, o],
           [x, Empty, Empty]],
  NewBoard = board:take_space(Board, {2, 2}, x),
  ?assertEqual([[x, o,     Empty],
                [o, x,     o],
                [x, Empty, Empty]],
              NewBoard).

print_board_1_element_test() ->
  Board = board:create(1),
  BoardString = board:to_string(Board),
  ?assertEqual("  1|\n----\n1|_|\n\n", BoardString).

print_board_3_element_test() ->
  Empty = game_record:untaken_space(),
  Board = [[x, o,     x],
           [o, Empty, o],
           [x, x,     o]],
  BoardString = board:to_string(Board),
  ?assertEqual("  1|2|3|\n--------\n1|x|o|x|\n2|o|_|o|\n3|x|x|o|\n\n", BoardString).

