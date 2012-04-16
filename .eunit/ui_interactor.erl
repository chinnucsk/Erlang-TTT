-module(ui_interactor).
-export([message_processing/1, greet/1, set_player_type/2]).

message_processing(IODevice) ->
  receive
    {request, Pid, greet} ->
      greet(IODevice),
      reply(Pid, ok);
    {request, Pid, setup_player, PlayerCharacter} ->
      PlayerType = set_player_type(IODevice, PlayerCharacter),
      reply(Pid, PlayerType);
    {request, death} ->
      ok
  end.

greet(IODevice) ->
  ui:output(IODevice, 'Welcome to Erlang TTT\n').

set_player_type(IODevice, PlayerCharacter) ->
  prompt_player_type(IODevice, PlayerCharacter),
  user_input(IODevice).

prompt_player_type(IODevice, PlayerCharacter) ->
  PlayerCharacterString = case PlayerCharacter of
    x -> "Player x";
    o -> "Player o"
  end,
  UserQuery = string:concat(PlayerCharacterString, " is a Human or AI?\n"),
  ui:output(IODevice, UserQuery).

user_input(IODevice) ->
  ui:input(IODevice).

reply(Pid, Response) ->
  Pid ! {response, Response}.
