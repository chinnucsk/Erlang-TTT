-module(player_type_importer_test).
-include_lib("eunit/include/eunit.hrl").

import_human_test() ->
  ?assertEqual(human, player_type_importer:import(human)).

import_Human_test() ->
  ?assertEqual(human, player_type_importer:import('Human')).

import_HUMAN_test() ->
  ?assertEqual(human, player_type_importer:import('HUMAN')).

import_ai_test() ->
  ?assertEqual(ai, player_type_importer:import(ai)).

import_AI_test() ->
  ?assertEqual(ai, player_type_importer:import('AI')).

import_fail_test() ->
  ?assertEqual(fail, player_type_importer:import(fail)).

