-module(game_record_test).
-include_lib("eunit/include/eunit.hrl").
-include("../../src/game_record/game_record.hrl").

new_game_must_pass_integer_test() ->
  ?assertError(function_clause, game_record:new_game(fail)).

new_game_must_be_positive_test() ->
  ?assertError(function_clause, game_record:new_game(-1)),
  ?assertError(function_clause, game_record:new_game(0)).

new_game_default_to_turn_x_test() ->
  GameState = game_record:new_game(1),
  ?assertEqual(x, GameState#game.turn).

new_game_empty_board_test() ->
  GameState = game_record:new_game(1),
  ?assertEqual([[empty]], GameState#game.board).

get_board_test() ->
  GameState = game_record:new_game(1),
  ?assertEqual([[game_record:untaken_space()]], game_record:get_board(GameState)).

set_player_type_x_test() ->
  GameState = game_record:new_game(1),
  NewGameState = game_record:set_player_type(GameState, {x, human}),
  ?assertEqual(human, NewGameState#game.player_x_type).

set_player_type_o_test() ->
  GameState = game_record:new_game(1),
  NewGameState = game_record:set_player_type(GameState, {o, ai}),
  ?assertEqual(ai, NewGameState#game.player_o_type).

get_player_type_test() ->
  GameState = game_record:new_game(1),
  ?assertEqual(undefined, game_record:get_player_type(GameState, x)),
  ?assertEqual(undefined, game_record:get_player_type(GameState, o)).

get_player_type_when_set_test() ->
  GameState = game_record:new_game(1),
  XSetToHuman = game_record:set_player_type(GameState, {x, human}),
  OSetToAI = game_record:set_player_type(GameState, {o, ai}),
  ?assertEqual(human, game_record:get_player_type(XSetToHuman, x)),
  ?assertEqual(ai, game_record:get_player_type(OSetToAI, o)).

get_player_turn_test() ->
  GameState = #game{turn = x},
  ?assertEqual(x, game_record:get_player_turn(GameState)).

swtitch_player_turn_x_to_o_test() ->
  GameState = #game{turn = x},
  NewGameState = game_record:switch_player_turn(GameState),
  ?assertEqual(o, NewGameState#game.turn).

switch_player_turn_o_to_x_test() ->
  GameState = #game{turn = o},
  NewGameState = game_record:switch_player_turn(GameState),
  ?assertEqual(x, NewGameState#game.turn).
