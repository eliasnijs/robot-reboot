:- initialization(main).
:- use_module(library(clpfd)).
:- use_module(library(optparse)).
:- use_module(library(lists)).

:- [utils].
:- [ansi].
:- [parser].
:- [display].
:- [input].
:- [play].

option_spec([
	[opt(game), 	longflags([game]),	default([])],
	[opt(solve),	longflags([solve]),	default([])],
	[opt(gen), 	longflags([gen]),	default([])],
	[opt(test), 	longflags([test]),	default([])]
	]).
parse_args(Argv, Opts) :-
	option_spec(OptSpec),
    	opt_parse(OptSpec, Argv, Opts, _).

main :-
	current_prolog_flag(argv, Argv),
	parse_args(Argv, Opts),
	( memberchk(game([Term|_]), Opts) ->
		term_to_atom(Term, File),
		play_setup(File, Session),
		play_loop(Session)
	; writeln('invalid options!')).

