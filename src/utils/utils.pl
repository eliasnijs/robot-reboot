vec2(X, Y, vec2(X, Y)).
vec2_add(vec2(X1, Y1), vec2(X2, Y2), vec2(X3, Y3)) :-
	X3 #= X1 + X2,
	Y3 #= Y1 + Y2.
vec2_mult(M, vec2(X, Y), vec2(X3, Y3)) :-
	X3 #= X * M,
	Y3 #= Y * M.

set_element([_|Tail], 0, E, [E|Tail]).
set_element([L0|Ls0], I, E, [L0|Ls1]) :-
    I #> 0, I0 #= I - 1,
    set_element(Ls0, I0, E, Ls1).

build_string(L, S) :-
	atomic_list_concat(L, S).

read_file_from_stdin(S) :-
	read_line_to_string(user_input, S0),
	( S0 = end_of_file -> S = ' '
	; read_file_from_stdin(Ss), build_string([S0,'\n',Ss], S) ).

range(L, U0, R) :-
	U #= U0 - 1,
	between(L, U, R).

even(X) :- 0 #= X mod 2.
uneven(X) :- 1 #= X mod 2.

random_even(L0, U0, X) :-
	L #= L0 div 2, U #= U0 div 2,
	random(L, U, X0),
	X #= X0 * 2.
random_uneven(L0, U0, X) :-
	L #= L0 div 2, U #= U0 div 2,
	random(L, U, X0),
	X #= X0 * 2 + 1.

zip([], _, []).
zip(_, [], []).
zip([H1|T1], [H2|T2], [(H1, H2)|T]) :-
    zip(T1, T2, T).

first_n(N, L, R) :-
    length(R, N),
    append(R, _, L).

