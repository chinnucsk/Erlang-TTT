-module(std_io_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(io, [unstick, passthrough]).

cleanup() ->
  meck:unload(io).

flash_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, std_io:flash("Message")),
  cleanup().

prompt_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, std_io:flash("Message")),
  cleanup().

atom_input_test() ->
  setup(),
  MockInput = test,
  meck:expect(io, fread, fun(_, "~a") -> {ok, [MockInput]} end),
  ?assertEqual(MockInput, std_io:atom_input()),
  cleanup().

atom_input_fail_test() ->
  setup(),
  meck:expect(io, fread, fun(_, "~a") -> {error, []} end),
  meck:expect(io, fwrite, fun(_) -> ok end),
  MockInput = test,
  meck:expect(io, fread, fun(_, "~a") -> {ok, [MockInput]} end),
  ?assertEqual(MockInput, std_io:atom_input()),
  cleanup().

integer_input_test() ->
  setup(),
  MockInput = 1,
  meck:expect(io, fread, fun(_, "~d") -> {ok, [MockInput]} end),
  ?assertEqual(MockInput, std_io:integer_input()),
  cleanup().

integer_input_fail_test() ->
  setup(),
  meck:expect(io, fread, fun(_, "~d") -> {error, []} end),
  meck:expect(io, fwrite, fun(_) -> ok end),
  MockInput = 1,
  meck:expect(io, fread, fun(_, "~d") -> {ok, [MockInput]} end),
  ?assertEqual(MockInput, std_io:integer_input()),
  cleanup().

