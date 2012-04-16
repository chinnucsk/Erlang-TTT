-module(player_type_validator_test).
-include_lib("eunit/include/eunit.hrl").

validate_pass_with_human_test() ->
  ?assertEqual({validation, passed}, player_type_validator:validate(human)).

validate_pass_with_ai_test() ->
  ?assertEqual({validation, passed}, player_type_validator:validate(ai)).

validate_fail_test() ->
  ?assertEqual({validation, failed}, player_type_validator:validate(fail)).

