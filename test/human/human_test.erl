-module(human_test).
-include_lib("eunit/include/eunit.hrl").

take_space_test() ->
  IODevice = mock_ui,
  PlayerCharacter = human,
  Space = {1, 1},
  meck:new(ui_interactor),
  meck:expect(ui_interactor, take_space, fun(IODevice, PlayerCharacter) -> Space end),
  ?assertEqual(Space, human:take_space(IODevice, PlayerCharacter)),
  meck:unload(ui_interactor).
