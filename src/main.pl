:- initialization(main).
:- use_module(library(clpfd)).
:- use_module(library(optparse)).
:- [utils].
:- [parser].

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
		play(File)
	;
		writeln('invalid options!')
	).

play(F) :-
        read_file_to_string(F, S, []),
	parse(S, Puzzle),
	writeln(Puzzle).

