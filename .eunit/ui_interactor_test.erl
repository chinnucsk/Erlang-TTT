-module(ui_interactor_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(mock_ui).

cleanup() ->
  meck:unload(mock_ui).

greet_test() ->
  setup(),
  meck:expect(mock_ui, flash, fun(_) -> ok end),
  ?assertEqual(ok, ui_interactor:greet(mock_ui)),
  cleanup().

get_player_type_for_x_test() ->
  setup(),
  meck:expect(mock_ui, prompt, fun(_) -> ok end),
  PlayerType = human,
  meck:expect(mock_ui, atom_input, fun() -> PlayerType end),
  ?assertEqual(PlayerType, ui_interactor:get_player_type(mock_ui, x)),
  cleanup().

get_player_type_for_o_test() ->
  setup(),
  meck:expect(mock_ui, prompt, fun(_) -> ok end),
  PlayerType = ai,
  meck:expect(mock_ui, atom_input, fun() -> PlayerType end),
  ?assertEqual(PlayerType, ui_interactor:get_player_type(mock_ui, o)),
  cleanup().

inform_player_type_invalid_test() ->
  setup(),
  meck:expect(mock_ui, flash, fun(_) -> ok end),
  ?assertEqual(ok, ui_interactor:inform_player_type_invalid(mock_ui)),
  cleanup().

take_space_test() ->
  setup(),
  meck:expect(mock_ui, prompt, fun(_) -> ok end),
  meck:expect(mock_ui, integer_input, fun() -> 1 end),
  Space = ui_interactor:take_space(mock_ui, x),
  ?assertEqual({1, 1}, Space),
  cleanup().

inform_move_invalid_test() ->
  setup(),
  meck:expect(mock_ui, flash, fun(_) -> ok end),
  ?assertEqual(ok, ui_interactor:inform_move_invalid(mock_ui)),
  cleanup().

print_board_test() ->
  setup(),
  meck:expect(mock_ui, flash, fun(_) -> ok end),
  ?assertEqual([ok], ui_interactor:print_board(mock_ui, [[x]])),
  cleanup().
