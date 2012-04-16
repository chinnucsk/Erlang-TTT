-module(ui_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(mock_io).

cleanup() ->
  meck:unload(mock_io).

input_test() ->
  setup(),
  MockInput = 'test',
  meck:expect(mock_io, read, fun() -> MockInput end),
  ?assertEqual(MockInput, ui:input(mock_io)),
  cleanup().

output_test() ->
  setup(),
  meck:expect(mock_io, write, fun(_) -> ok end),
  ?assertEqual(ok, ui:output(mock_io, 'Message')),
  cleanup().
