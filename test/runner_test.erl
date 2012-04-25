-module(runner_test).
-include_lib("eunit/include/eunit.hrl").

invoke_game_server_and_client_test() ->
  IODevice = std_io,
  meck:new(game_server),
  GameServerPid = 1,
  meck:expect(game_server, start, 1, GameServerPid),
  meck:new(game_client),
  meck:expect(game_client, start, fun(GameServerPid, IODevice) -> ok end),
  runner:run(IODevice),
  meck:unload(game_server),
  meck:unload(game_client).
