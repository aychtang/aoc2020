:- use_module(library(pure_input)).
:- use_module(library(dcg/basics)).

line([Line|Data]) --> string(Line), "\n", line(Data).
line([]) --> eos.

load_data(Data) :-
	open('input3.txt', read, Stream),
	phrase_from_stream(line(Data), Stream).

check_collision_for_coord(Line, X, Y) :-
	nth0(Y, Line, Row),
	length(Row, Line_length),
	Pos is X mod Line_length,
	nth0(Pos, Row, 35).

lets_crash_into_some_trees(Map, _, Y, _, _, 0) :-
	length(Map, MaxY),
	Y >= MaxY.

lets_crash_into_some_trees(Map, X, Y, Dx, Dy, Count) :-
	(
		check_collision_for_coord(Map, X, Y) ->
			Count1 is 1;
			Count1 is 0
	),
	X1 is X + Dx,
	Y1 is Y + Dy,
	lets_crash_into_some_trees(Map, X1, Y1, Dx, Dy, Acc),
	Count is Count1 + Acc.

solution(1, Answer) :-
	load_data(Map),
	lets_crash_into_some_trees(Map, 0, 0, 3, 1, Answer).

solution(2, Answer) :-
	load_data(Map),
	lets_crash_into_some_trees(Map, 0, 0, 1, 1, C1),
	lets_crash_into_some_trees(Map, 0, 0, 3, 1, C2),
	lets_crash_into_some_trees(Map, 0, 0, 5, 1, C3),
	lets_crash_into_some_trees(Map, 0, 0, 7, 1, C4),
	lets_crash_into_some_trees(Map, 0, 0, 1, 2, C5),
	Answer is C1 * C2 * C3 * C4 * C5.
