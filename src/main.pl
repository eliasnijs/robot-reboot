:- initialization(main).
:- use_module(library(clpfd)).
:- use_module(library(tabling)).
:- use_module(library(optparse)).
:- use_module(library(yall)).

:- [config].
:- [utils/utils].
:- [utils/ansi].
:- [display/display].
:- [display/static_screens].
:- [other/parser].
:- [modes/play].
:- [modes/generate].
:- [modes/solve].
:- [robotreboot].

option_spec([
	[opt(game), 	longflags([game]),	default([]),	type(term)	],
	[opt(solve),	longflags([solve]),	default(false),	type(boolean)	],
	[opt(gen), 	longflags([gen]),	default([]),	type(term)	],
	[opt(test), 	longflags([test]),	default([]),	type(term)	]
	]).

main :-
	current_prolog_flag(argv, Argv),
	option_spec(OptSpec),
    	opt_parse(OptSpec, Argv, Opts, _),
	(member(solve(true), Opts) ->
		solve_setup(P),
		writeln(''),
		solve_iterative_deepening(P, 0)
	; member(gen([RC, W, H]), Opts) ->
		generate_puzzle(specification(RC, W, H), P),
		writeln(P),
		display(puzzle, P)
	; member(game([T|_]), Opts) ->
		term_to_atom(T, F),
		play_setup(F, S),
		play_loop(S)
	;
		writeln('invalid option!')
	).


