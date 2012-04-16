-module(ui_interactor).
-export([greet/1, get_player_type/2]).

greet(IODevice) ->
  ui:string_output(IODevice, "Welcome to Erlang TTT\n").

get_player_type(IODevice, PlayerCharacter) ->
  prompt_player_type(IODevice, PlayerCharacter),
  retrieve_player_type(IODevice).

prompt_player_type(IODevice, PlayerCharacter) ->
  PlayerCharacterString = case PlayerCharacter of
    x -> "Player x";
    o -> "Player o"
  end,
  UserQuery = string:concat(PlayerCharacterString, " is a human or ai?\n"),
  ui:string_output(IODevice, UserQuery).

retrieve_player_type(IODevice) ->
  player_type_importer:import(ui:atom_input(IODevice)).

