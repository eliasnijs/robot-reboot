get_input(S) :-
	write('> '),
	read_line_to_string(user_input, C0),
	atomic_list_concat([C0], S).
