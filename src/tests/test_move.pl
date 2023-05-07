:- use_module(library(plunit)).
:- [../main].


:- begin_tests(lists).

test(move_up) :-
	writeln(''), write_w_ansi([cursor_start_prev], ''),
	test_run(P, M).

:- end_tests(lists).
