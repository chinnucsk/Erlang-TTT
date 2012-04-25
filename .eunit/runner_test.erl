-module(runner_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(ui_interactor),
  meck:expect(ui_interactor, greet, fun(std_io) -> ok end).

cleanup() ->
  meck:unload(ui_interactor).

run_starts_game_loop_test() ->
  setup(),
  meck:new(game_loop),
  meck:expect(game_loop, start, fun(std_io) -> ok end),
  runner:run(std_io),
  cleanup().
