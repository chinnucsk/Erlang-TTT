-module(ui_interactor_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(mock_io).

cleanup() ->
  meck:unload(mock_io).

greet_test() ->
  setup(),
  meck:expect(mock_io, write, fun(_) -> ok end),
  ?assertEqual(ok, ui_interactor:greet(mock_io)),
  cleanup().

set_player_type_for_x_test() ->
  setup(),
  meck:expect(mock_io, write, fun(_) -> ok end),
  PlayerType = 'Human',
  meck:expect(mock_io, read, fun() -> PlayerType end),
  ?assertEqual(PlayerType, ui_interactor:set_player_type(mock_io, x)),
  cleanup().

set_player_type_for_o_test() ->
  setup(),
  meck:expect(mock_io, write, fun(_) -> ok end),
  PlayerType = 'Human',
  meck:expect(mock_io, read, fun() -> PlayerType end),
  ?assertEqual(PlayerType, ui_interactor:set_player_type(mock_io, o)),
  cleanup().

