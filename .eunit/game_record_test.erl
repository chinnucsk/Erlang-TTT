-module(game_record_test).
-include_lib("eunit/include/eunit.hrl").
-include("../../src/game_state/game_record.hrl").

new_game_must_pass_integer_test() ->
  ?assertError(function_clause, game_record:new_game(fail)).

new_game_must_be_positive_test() ->
  ?assertError(function_clause, game_record:new_game(-1)),
  ?assertError(function_clause, game_record:new_game(0)).

new_game_default_to_turn_x_test() ->
  GameState = game_record:new_game(1),
  ?assertEqual(x, GameState#game.turn).

new_game_empty_1_board_test() ->
  GameState = game_record:new_game(1),
  ?assertEqual([[empty]], GameState#game.board).

new_game_empty_3_board_test() ->
  GameState = game_record:new_game(3),
  ?assertEqual([[empty, empty, empty], [empty, empty, empty], [empty, empty, empty]], GameState#game.board).
