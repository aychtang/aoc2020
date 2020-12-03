:- use_module(library(pure_input)).
:- use_module(library(dcg/basics)).

line([[Minimum,Maximum,Character,Password]|Data]) -->
	integer(Minimum),
	"-",
	integer(Maximum),
	" ",
	string(Character),
	": ",
	string(Password),
	"\n",
	line(Data).

line([]) --> eos.

load_data(Data) :-
	open('input2.txt', read, Stream),
	phrase_from_stream(line(Data), Stream).

occurrences_of(List, X, Count) :- aggregate_all(count, member(X, List), Count).

occurs_at_positions_once(List, X, Pos1, Pos2) :-
	nth1(Pos1, List, X), not(nth1(Pos2, List, X));
	nth1(Pos2, List, X), not(nth1(Pos1, List, X)).

valid_password([Minimum, Maximum, [Code], CodeList]) :-
	occurrences_of(CodeList, Code, Count),
	Count >= Minimum,
	Count =< Maximum.

valid_password_2([Pos1, Pos2, [Code], CodeList]) :-
	occurs_at_positions_once(CodeList, Code, Pos1, Pos2).

count_valid_passwords(Predicate, List, Count) :-
	exclude(Predicate, List, List2),
	length(List, Count1),
	length(List2, Count2),
	Count is Count1 - Count2.

solution(1, Answer) :-
	load_data(List),
	count_valid_passwords(valid_password, List, Answer).

solution(2, Answer) :-
	load_data(List),
	count_valid_passwords(valid_password_2, List, Answer).
