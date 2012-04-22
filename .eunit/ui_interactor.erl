-module(ui_interactor).
-export([greet/1]).
-export([get_player_type/2, inform_player_type_invalid/1]).
-export([take_space/2, inform_move_invalid/1]).

greet(IODevice) ->
  apply(IODevice, flash, ["Welcome to Erlang TTT\n"]).

get_player_type(IODevice, PlayerCharacter) ->
  prompt_player_type(IODevice, PlayerCharacter),
  retrieve_player_type(IODevice).

prompt_player_type(IODevice, PlayerCharacter) ->
  PlayerCharacterString = player_string(PlayerCharacter),
  UserQuery = string:concat(PlayerCharacterString, " is a Human or AI?\n"),
  apply(IODevice, prompt, [UserQuery]).

retrieve_player_type(IODevice) ->
  PlayerType = apply(IODevice, atom_input, []),
  player_type_importer:import(PlayerType).

inform_player_type_invalid(IODevice) ->
  apply(IODevice, flash, ["Player Type is invalid\nTry either Human or AI\n"]).

take_space(IODevice, PlayerCharacter) ->
  PlayerCharacterString = player_string(PlayerCharacter),
  Prompt = string:concat(PlayerCharacterString, "'s turn\n"),
  apply(IODevice, prompt, [Prompt]),
  apply(IODevice, prompt, ["Row?\n"]),
  Row = apply(IODevice, integer_input, []),
  apply(IODevice, prompt, ["Column?\n"]),
  Column = apply(IODevice, integer_input, []),
  {Row, Column}.

player_string(PlayerCharacter) ->
  PlayerCharacterString = case PlayerCharacter of
    x -> "Player x";
    o -> "Player o"
  end.

inform_move_invalid(IODevice) ->
  apply(IODevice, flash, ["That's not a valid move!\n"]).
