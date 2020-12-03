:- set_prolog_flag(answer_write_options,[max_depth(0)]).
:- use_module(library(lists)).
:- use_module(library(pure_input)).
:- use_module(library(dcg/basics)).

line([Line|Data]) -->
	string(Line), "\n", line(Data).

line([]) --> eos.

load_data(Data) :-
	open('input3.txt', read, Stream),
	phrase_from_stream(line(Data), Stream).

check_collision_for_line(Line, N, Dx) :-
	length(Line, LineLength),
	Pos is (N * Dx) mod LineLength,
	nth0(Pos, Line, 35).

lets_crash_into_some_trees([], _, _, _, _, 0).
lets_crash_into_some_trees(_, Index, _, Dy, _, 0) :- Index mod Dy > 0.
lets_crash_into_some_trees([Line|Tail], Index, Dx, Dy, MaxY, Count) :-
	NextIndex is Index + 1,
	lets_crash_into_some_trees(Tail, NextIndex, Dx, Dy, MaxY, Acc),
	(check_collision_for_line(Line, Index, Dx) ->
		Count is Acc + 1;
		Count is Acc
	).

solution(1, Answer) :-
	load_data(List),
	length(List, MaxY),
	lets_crash_into_some_trees(List, 0, 3, 1, MaxY, Answer).

solution(2, Answer) :-
	load_data(List),
	length(List, MaxY),
	lets_crash_into_some_trees(List, 0, 1, 1, MaxY, A1),
	lets_crash_into_some_trees(List, 0, 3, 1, MaxY, A2),
	lets_crash_into_some_trees(List, 0, 5, 1, MaxY, A3),
	lets_crash_into_some_trees(List, 0, 7, 1, MaxY, A4),
	lets_crash_into_some_trees(List, 0, 1, 2, MaxY, A5),
	Answer is A1 * A2 * A3 * A4 * A5.
