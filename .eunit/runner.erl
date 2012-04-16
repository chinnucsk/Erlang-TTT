-module(runner).
-export([run/0, create_std_io_node/0]).

run() ->
  PidUI = create_std_io_node(),
  PidUI ! greet.

create_std_io_node() ->
  ui:start({io_device, io}).
