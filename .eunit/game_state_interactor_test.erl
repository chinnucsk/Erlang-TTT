-module(game_state_interactor_test).
-include_lib("eunit/include/eunit.hrl").
-include("../../src/game_record/game_record.hrl").

player_type() ->
  human.

io_device() ->
  mock_io.

type_test_setup(PlayerCharacter) ->
  meck:new(ui_interactor),
  meck:expect(ui_interactor, get_player_type, fun(_, PlayerCharacter) -> player_type() end).

cleanup() ->
  meck:unload(ui_interactor).

update_player_type_x_test() ->
  type_test_setup(x),
  GameState = game_record:new_game(1),
  NewGameState = game_state_interactor:update_player_type(io_device(), GameState, x),
  ?assertEqual(player_type(), NewGameState#game.player_x_type),
  cleanup().

update_player_type_o_test() ->
  type_test_setup(o),
  GameState = game_record:set_player_type(game_record:new_game(1), {x, human}),
  NewGameState = game_state_interactor:update_player_type(io_device(), GameState, o),
  ?assertEqual(player_type(), NewGameState#game.player_o_type),
  cleanup().

take_turn_human_test() ->
  Turn = x,
  GameState = game_record:set_player_type(game_record:new_game(1), {x, human}),
  meck:new(ui_interactor),
  meck:expect(ui_interactor, take_space, fun(mock_io, Turn) -> {1, 1} end),
  meck:expect(ui_interactor, print_board, 1, ok),
  NewGameState = game_state_interactor:take_turn(mock_io, GameState),
  ?assertEqual([[Turn]], game_record:get_board(NewGameState)),
  cleanup().
