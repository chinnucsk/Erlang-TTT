-module(runner_test).
-include_lib("eunit/include/eunit.hrl").

create_std_io_node_test() ->
  meck:new(ui),
  PidIOMock = 1,
  meck:expect(ui, start, fun({io_device, io}) -> PidIOMock end),
  ?assertEqual(PidIOMock, runner:create_std_io_node()),
  meck:unload(ui).
