-module(ui_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(mock_io).

cleanup() ->
  meck:unload(mock_io).

atom_input_test() ->
  setup(),
  MockInput = test,
  meck:expect(mock_io, fread, fun(_, "~a") -> {ok, [MockInput]} end),
  ?assertEqual(MockInput, ui:atom_input(mock_io)),
  cleanup().

integer_input_test() ->
  setup(),
  MockInput = 1,
  meck:expect(mock_io, fread, fun(_, "~d") -> MockInput end),
  ?assertEqual(MockInput, ui:integer_input(mock_io)),
  cleanup().

string_output_test() ->
  setup(),
  meck:expect(mock_io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, ui:string_output(mock_io, 'Message')),
  cleanup().
