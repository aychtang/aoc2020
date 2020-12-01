:- use_module(library(pure_input)).
:- use_module(library(dcg/basics)).

line([X|Data]) --> integer(X), "\n", line(Data).
line([]) --> eos.

load_data(Data) :-
	open('input.txt', read, Stream),
	phrase_from_stream(line(Data), Stream).

sum_to_target(List, Target, N1, N2) :-
	select(N1, List, List2),
	select(N2, List2, _),
	Target is N1 + N2.

sum_to_target(List, Target, N1, N2, N3) :-
	select(N1, List, List2),
	select(N2, List2, List3),
	select(N3, List3, _),
	Target is N1 + N2 + N3.

solution1(Target, Answer) :-
	load_data(List),
	sum_to_target(List, Target, N1, N2),
	Answer is N1 * N2.

solution2(Target, Answer) :-
	load_data(List),
	sum_to_target(List, Target, N1, N2, N3),
	Answer is N1 * N2 * N3.
