vec2_add(vec2(X1, Y1), vec2(X2, Y2), vec2(X3, Y3)) :-
	X3 #= X1 + X2,
	Y3 #= Y1 + Y2.

vec_equal(vec2(X1, Y1), vec2(X2, Y2)) :-
	X1 = X2,
	Y1 = Y2.

replace_chars([], _, _, []).
replace_chars([C|Cs], From, To, [NewC|NewCs]) :-
    (nth0(_, From, C) -> NewC = To ; NewC = C),
    replace_chars(Cs, From, To, NewCs).
