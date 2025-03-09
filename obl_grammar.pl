/*  Part of SWI-Prolog

    Author:        Tolga Keskinoglu
    E-mail:        viva.tolga@gmail.com

*/

:- set_prolog_flag(double_quotes, codes).
:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).

% Show lists of codes as text
:- portray_text(true).
% Show 100 chars before truncating
:- set_portray_text(ellipsis, _, 2000).


% Useful catch all for testing.
... --> [] | [_], ... .

% TODO: consider way of optimizing this.
string_with_escaped_quotes([]) --> [].
string_with_escaped_quotes([34 | T]) --> "\\\"", string_with_escaped_quotes(T). % Handle escaped quote
string_with_escaped_quotes([C | T]) --> [C], { C \= 34, C \= 92 }, string_with_escaped_quotes(T). % Handle regular characters
string_with_escaped_quotes([C | T]) --> [C], { C = 92, \+ memberchk(C, [34, 92]) }, string_with_escaped_quotes(T). % Handle backslash


token(T) --> "\"", string_without("\"", T), "\"".

object_class(O, C) --> token(O), ":", token(C).

class_superclass(C, S) --> token(C), "::", token(S).

key(K) --> token(K), "->".

value(V) --> "\"", string_with_escaped_quotes(V), "\"".
value(V) --> number(V).

key_value(K,V) --> key(K), value(V).
key_value(K,V) --> key(K), frame(V).

key_value_chain([[Key, Value] | Rest]) -->
    key_value(Key, Value),
    key_value_chain_r(Rest).

key_value_chain_r([[Key, Value] | Rest]) -->
    ", ",
    key_value(Key, Value),
    key_value_chain_r(Rest), ! .
key_value_chain_r([]) --> [] .

frame([]) --> "[]".
frame(F)  --> "[", key_value_chain(F), "]".

obl_frame("Entity", O, C, S, F) -->
    object_class(O, C), frame(F), ".\n" ,
    class_superclass(C, S), ".".
obl_frame("Relation", O, C, [], F) -->
    object_class(O,C), frame(F), { F = [["entityAOBL", _] | _] }, ".".
obl_frame("Event", O, C, [], F) -->
    object_class(O,C), frame(F), { F = [["ordinalOBL", _] | _] }, ".".