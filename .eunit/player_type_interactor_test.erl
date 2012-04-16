-module(player_type_interactor_test).
-include_lib("eunit/include/eunit.hrl").

player_type_return_human_test() ->
  meck:new(ui_interactor),
  meck:expect(ui_interactor, get_player_type, 2, human),
  ?assertEqual(human, player_type_interactor:player_type(fake_io, x)),
  meck:unload(ui_interactor).

player_type_return_ai_test() ->
  meck:new(ui_interactor),
  meck:expect(ui_interactor, get_player_type, 2, ai),
  ?assertEqual(ai, player_type_interactor:player_type(fake_io, o)),
  meck:unload(ui_interactor).

player_type_retry_on_invalid_test() ->
  meck:new(ui_interactor),
  meck:expect(ui_interactor, get_player_type, 2, fail),
  meck:expect(ui_interactor, get_player_type, 2, human),
  ?assertEqual(human, player_type_interactor:player_type(fake_io, x)),
  meck:unload(ui_interactor).

