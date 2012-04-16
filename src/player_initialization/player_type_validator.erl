-module(player_type_validator).
-export([validate/1]).

validate(human) ->
  validation_passed();
validate(ai) ->
  validation_passed();
validate(_) ->
  validation_failed().

validation_passed() ->
  {success, true}.

validation_failed() ->
  {success, false}.
