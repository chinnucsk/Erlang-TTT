-module(player_type_validator).
-export([validate/1]).

validate(human) ->
  validation_passed();
validate(ai) ->
  validation_passed();
validate(Other) ->
  validation_failed().

validation_passed() ->
  {validation, passed}.

validation_failed() ->
  {validation, failed}.
