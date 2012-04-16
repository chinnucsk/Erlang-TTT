-module(ui_interactor_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(mock_io).

cleanup() ->
  meck:unload(mock_io).

greet_test() ->
  setup(),
  meck:expect(mock_io, fwrite, fun(_, _) -> ok end),
  ?assertEqual(ok, ui_interactor:greet(mock_io)),
  cleanup().

get_player_type_for_x_test() ->
  setup(),
  meck:expect(mock_io, fwrite, fun(_, _) -> ok end),
  PlayerType = human,
  meck:expect(mock_io, fread, 2, PlayerType),
  ?assertEqual(PlayerType, ui_interactor:get_player_type(mock_io, x)),
  cleanup().

get_player_type_for_o_test() ->
  setup(),
  meck:expect(mock_io, fwrite, fun(_, _) -> ok end),
  PlayerType = ai,
  meck:expect(mock_io, fread, 2, PlayerType),
  ?assertEqual(PlayerType, ui_interactor:get_player_type(mock_io, o)),
  cleanup().

