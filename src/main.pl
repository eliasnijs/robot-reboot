:- use_module(library(clpfd)).
:- use_module(library(tabling)).
:- use_module(library(optparse)).
:- use_module(library(yall)).
:- use_module(library(random)).

:- [config].

:- [utils/utils].
:- [utils/ansi].

:- [robotreboot].

:- [display/display].
:- [display/static_screens].

:- [other/parser].

:- [modes/play].
:- [modes/generate].
:- [modes/solve].
:- [modes/test].

:- ['../tests/tests.pl'].

option_spec([
	[opt(game), 	longflags([game]),	default([]),	type(term)	],
	[opt(solve),	longflags([solve]),	default(false),	type(boolean)	],
	[opt(gen), 	longflags([gen]),	default([]),	type(term)	],
	[opt(test), 	longflags([test]),	default([]),	type(term)	],
	[opt(plu), 	longflags([plu]),	default(false),	type(boolean)	]
	]).

main(Argv) :-
	option_spec(OptSpec),
    	opt_parse(OptSpec, Argv, Opts, _),
	(member(solve(true), Opts) ->
		solve_setup(P),
		writeln(''),
		solve_iterative_deepening(P, 0, 10000)
	; member(gen([RC, W, H]), Opts) ->
		writeln(''),
		generate(specification(RC, W, H))
	; member(game([T|_]), Opts) ->
		term_to_atom(T, F),
		play_setup(F, S),
		play_loop(S)
	;  member(test([ID, D]), Opts) ->
		test_setup(specification(ID, D), M, P),
		test_run(P, M, _)
	; member(plu(true), Opts) ->
		run_tests
	;
		writeln('invalid option!')
	).

:- initialization(( current_prolog_flag(argv, Argv), main(Argv), halt )).
