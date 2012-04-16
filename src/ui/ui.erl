-module(ui).
-export([start/1, input/1, output/2]).

start({io_device, IODevice}) ->
  spawn(fun() -> ui_interactor:message_processing(IODevice) end).

input(IODevice) ->
  apply(IODevice, read, []).

output(IODevice, Message) ->
  apply(IODevice, write, [Message]).

