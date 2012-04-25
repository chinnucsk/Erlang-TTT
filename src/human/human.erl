-module(human).
-export([take_space/2]).

take_space(IODevice, PlayerCharacter) ->
  ui_interactor:take_space(IODevice, PlayerCharacter).
