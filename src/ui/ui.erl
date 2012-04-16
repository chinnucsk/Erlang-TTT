-module(ui).
-export([atom_input/1, integer_input/1, string_output/2]).

atom_input(IODevice) ->
  {ok, Response} = apply(IODevice, fread, ['', "~a"]),
  [Atom|_] = Response,
  Atom.

integer_input(IODevice) ->
  apply(IODevice, fread, ['', "~d"]).

string_output(IODevice, Message) ->
  apply(IODevice, fwrite, [Message]).

