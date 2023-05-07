% construct vector based on X and Y values
vec2(X, Y, vec2(X, Y)).

% sum to vectors
vec2_add(vec2(X1, Y1), vec2(X2, Y2), vec2(X3, Y3)) :-
	X3 #= X1 + X2,
	Y3 #= Y1 + Y2.

% multiply vector with constant
vec2_mult(M, vec2(X, Y), vec2(X3, Y3)) :-
	X3 #= X * M,
	Y3 #= Y * M.

% set element in list
set_element([_|Tail], 0, E, [E|Tail]).
set_element([L0|Ls0], I, E, [L0|Ls1]) :-
    I #> 0, I0 #= I - 1,
    set_element(Ls0, I0, E, Ls1).

% alias for atomic_list_concat
build_string(L, S) :-
	atomic_list_concat(L, S).

% read file from stdin to string
read_file_from_stdin(S) :-
	read_line_to_string(user_input, S0),
	( S0 = end_of_file -> S = ' '
	; read_file_from_stdin(Ss), build_string([S0,'\n',Ss], S) ).

% same as between but with right boudary excluded
range(L, U0, R) :-
	U #= U0 - 1,
	between(L, U, R).

% zip 2 lists together
zip([], _, []).
zip(_, [], []).
zip([H1|T1], [H2|T2], [(H1, H2)|T]) :-
    zip(T1, T2, T).

% take the first N elements from a list
first_n(N, L, R) :-
    length(R, N),
    append(R, _, L).

% uniefs direction vector with symbolic representation
string_dir(vec2(-1,  0), 'L').
string_dir(vec2( 0,  1), 'D').
string_dir(vec2( 0, -1), 'U').
string_dir(vec2( 1,  0), 'R').
