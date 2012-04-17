-module(player_type_interactor_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(ui_interactor).

cleanup() ->
  meck:unload(ui_interactor).

player_type_return_human_test() ->
  setup(),
  meck:expect(ui_interactor, get_player_type, 2, human),
  ?assertEqual(human, player_type_interactor:player_type(fake_io, x)),
  cleanup().

player_type_return_ai_test() ->
  setup(),
  meck:expect(ui_interactor, get_player_type, 2, ai),
  ?assertEqual(ai, player_type_interactor:player_type(fake_io, o)),
  cleanup().

player_type_retry_on_invalid_test() ->
  setup(),
  meck:expect(ui_interactor, get_player_type, 2, fail),
  meck:expect(ui_interactor, inform_player_type_invalid, 1, ok),
  meck:expect(ui_interactor, get_player_type, 2, human),
  ?assertEqual(human, player_type_interactor:player_type(fake_io, x)),
  cleanup().

