:- initialization(main).
:- use_module(library(clpfd)).
:- use_module(library(optparse)).

:- [config].
:- [utils/utils].
:- [utils/ansi].
:- [utils/input].
:- [display/static_screens].
:- [display/display].
:- [other/parser].
:- [modes/play].
:- [modes/solve].
:- [rr].

option_spec([
	[opt(game), 	longflags([game]),	default([])],
	[opt(solve),	longflags([solve]),	default([])],
	[opt(gen), 	longflags([gen]),	default([])],
	[opt(test), 	longflags([test]),	default([])]
	]).

main :-
	current_prolog_flag(argv, Argv),
	parse_args(Argv, Opts),
	( memberchk(game([T|_]), Opts) ->
		term_to_atom(T, F),
		play_setup(F, S),
		play_loop(S)
	; memberchk(solve(_), Opts) ->
		solve_setup(P),
		writeln(''),
		solve_iterative_deepening(P, 0)
	;
		writeln('invalid option!')
	).

parse_args(Argv, Opts) :-
	option_spec(OptSpec),
    	opt_parse(OptSpec, Argv, Opts, _).

