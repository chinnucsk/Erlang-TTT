-module(player_type_interactor).
-export([player_type/2]).

player_type(IODevice, PlayerCharacter) ->
  PlayerType = ui_interactor:get_player_type(IODevice, PlayerCharacter),
  case player_type_validator:validate(PlayerType) of
    {success, false} ->
      ui_interactor:inform_player_type_invalid(IODevice),
      player_type(IODevice, PlayerCharacter);
    {success, true} -> PlayerType
  end.
