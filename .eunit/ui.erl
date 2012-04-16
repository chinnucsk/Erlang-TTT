-module(ui).
-export([atom_input/1, integer_input/1, string_output/2]).

atom_input(IODevice) ->
  apply(IODevice, fread, ['', "~a"]).

integer_input(IODevice) ->
  apply(IODevice, fread, ['', "~d"]).

string_output(IODevice, Message) ->
  apply(IODevice, fwrite, ["~s", Message]).

