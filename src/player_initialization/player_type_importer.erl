-module(player_type_importer).
-export([import/1]).

import(human) ->
  human();
import('Human') ->
  human();
import('HUMAN') ->
  human();
import(ai) ->
  ai();
import('AI') ->
  ai();
import(Other) ->
  Other.

human() ->
  human.

ai() ->
  ai.

