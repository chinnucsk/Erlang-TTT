-module(game_rules_test).
-include_lib("eunit/include/eunit.hrl").

horizontal_winner_1_element_test() ->
  Board = [[x]],
  {Winner, CharacterValue} = game_rules:horizontal_winner(Board),
  ?assert(Winner),
  ?assertEqual(x, CharacterValue).

horizontal_winner_3_element_test() ->
  Board = [[x, o, o],
           [x, x, x], 
           [o, o, x]],
  {Winner, CharacterValue} = game_rules:horizontal_winner(Board),
  ?assert(Winner),
  ?assertEqual(x, CharacterValue).

horizontal_no_winner_3_element_test() ->
  Board = [[x, o, x],
           [o, x, o],
           [x, x, o]],
  Winner = game_rules:horizontal_winner(Board),
  ?assertNot(Winner).

vertical_winner_1_element_test() ->
  Board = [[x]],
  {Winner, CharacterValue} = game_rules:vertical_winner(Board),
  ?assert(Winner),
  ?assertEqual(x, CharacterValue).

vertical_winner_3_element_test() ->
  Empty = game_record:untaken_space(),
  Board = [[x, o,     x    ],
           [x, o,     o    ],
           [x, Empty, Empty]],
  {Winner, CharacterValue} = game_rules:vertical_winner(Board),
  ?assert(Winner),
  ?assertEqual(x, CharacterValue).

vertical_no_winner_3_element_test() ->
  Board = [[o, x, o],
           [x, o, x],
           [x, o, o]],
  Winner = game_rules:vertical_winner(Board),
  ?assertNot(Winner).

diagonal_winner_1_element_test() ->
  Board = [[x]],
  {Winner, CharacterValue} = game_rules:diagonal_winner(Board),
  ?assert(Winner),
  ?assertEqual(x, CharacterValue).

diagonal_winner_3_element_left_to_right_test() ->
  Board = [[x, o, x],
           [o, x, o],
           [o, x, x]],
  {Winner, CharacterValue} = game_rules:diagonal_winner(Board),
  ?assert(Winner),
  ?assertEqual(x, CharacterValue).

diagonal_winner_3_element_right_to_left_test() ->
  Board = [[o, o, x],
           [x, x, o],
           [x, o, x]],
  {Winner, CharacterValue} = game_rules:diagonal_winner(Board),
  ?assert(Winner),
  ?assertEqual(x, CharacterValue).

diagonal_no_winner_3_element_test() ->
  Board = [[o, x, o],
           [x, o, x],
           [x, o, x]],
  Winner = game_rules:diagonal_winner(Board),
  ?assertNot(Winner).

draw_3_element_test() ->
  Board = [[o, x, o],
           [x, o, x],
           [x, o, x]],
  Draw = game_rules:draw(Board),
  ?assert(Draw).

draw_false_open_space_test() ->
  Board = [[game_record:untaken_space()]],
  Draw = game_rules:draw(Board),
  ?assertNot(Draw).

end_game_no_winner_test() ->
  ?assertNot(game_rules:end_game([[game_record:untaken_space()]])).

end_game_winner_test() ->
  {Winner, CharacterValue} = game_rules:end_game([[x]]),
  ?assert(Winner),
  ?assertEqual(x, CharacterValue).

end_game_draw_test() ->
  Board = [[o, x, o],
           [x, o, x],
           [x, o, x]],
  {Over, EndState} = game_rules:end_game(Board),
  ?assert(Over),
  ?assertEqual(draw, EndState).
