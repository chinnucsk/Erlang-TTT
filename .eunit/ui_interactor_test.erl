-module(ui_interactor_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(ui).

cleanup() ->
  meck:unload(ui).

greet_test() ->
  setup(),
  meck:expect(ui, string_output, fun(mock_io, _) -> ok end),
  ?assertEqual(ok, ui_interactor:greet(mock_io)),
  cleanup().

get_player_type_for_x_test() ->
  setup(),
  meck:expect(ui, string_output, fun(mock_io, _) -> ok end),
  PlayerType = human,
  meck:expect(ui, atom_input, fun(mock_io) -> PlayerType end),
  ?assertEqual(PlayerType, ui_interactor:get_player_type(mock_io, x)),
  cleanup().

get_player_type_for_o_test() ->
  setup(),
  meck:expect(ui, string_output, fun(mock_io, _) -> ok end),
  PlayerType = ai,
  meck:expect(ui, atom_input, fun(mock_io) -> PlayerType end),
  ?assertEqual(PlayerType, ui_interactor:get_player_type(mock_io, o)),
  cleanup().

inform_player_type_invalid_test() ->
  setup(),
  meck:expect(ui, string_output, fun(mock_io, _) -> ok end),
  ?assertEqual(ok, ui_interactor:inform_player_type_invalid(mock_io)),
  cleanup().
