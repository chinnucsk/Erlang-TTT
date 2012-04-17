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
