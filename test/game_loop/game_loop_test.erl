-module(game_loop_test).
-include_lib("eunit/include/eunit.hrl").

loop_exits_with_end_game_test() ->
  EndState = draw,
  meck:new(game_state_interactor),
  meck:new(ui_interactor),
  meck:expect(game_state_interactor, update, fun(mock_ui, _) -> {end_game, EndState} end),
  meck:expect(ui_interactor, end_game, fun(mock_ui, EndState) -> ok end),
  ?assertEqual(ok, game_loop:start(mock_ui)),
  meck:unload(game_state_interactor),
  meck:unload(ui_interactor).
