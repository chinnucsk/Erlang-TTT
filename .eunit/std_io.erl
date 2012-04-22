-module(std_io).
-export([flash/1, prompt/1, atom_input/0, integer_input/0]).

flash(Message) ->
  string_output(Message).

prompt(Message) ->
  string_output(Message).

string_output(Message) ->
  io:fwrite(Message).

atom_input() ->
  input_return(io:fread('', "~a"), atom_input, "Invalid input, try again.\n").

integer_input() ->
  input_return(io:fread('', "~d"), integer_input, "Invalid input, must be an integer. Try again.\n").

input_return(ResponseMessage, Caller, FailMessage) ->
  {Type, Response} = ResponseMessage,
  case Type of
    ok ->
      [Value|_] = Response,
      Value;
    error ->
      string_output(FailMessage),
      apply(std_io, Caller, [])
  end.

