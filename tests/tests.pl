:- use_module(library(plunit)).

lv(0, "┏━━━━━┓
┃     ┃
┃     ┃
┃  ▣  ┃
┃     ┃
┃     ┃
┗━━━━━┛
"
).

lv(1, "
┏━┓
┃▣┃
┗━┛
"
).

:- begin_tests(lists).

test(move_down_1, [nondet]) :-
	lv(0, S),
	parse(S, P0),
	move(P0, 0, vec2(0,1), P1),
	\+ ( P0 = P1).
test(move_up_1, [nondet]) :-
	lv(0, S),
	parse(S, P0),
	move(P0, 0, vec2(0,-1), P1),
	\+ ( P0 = P1).
test(move_right_1, [nondet]) :-
	lv(0, S),
	parse(S, P0),
	move(P0, 0, vec2(1,0), P1),
	\+ ( P0 = P1).
test(move_left_1, [nondet]) :-
	lv(0, S),
	parse(S, P0),
	move(P0, 0, vec2(-1,0), P1),
	\+ ( P0 = P1).

test(move_down_2, [nondet]) :-
	lv(1, S),
	parse(S, P0),
	move(P0, 0, vec2(0,1), P1),
	P0 = P1.
test(move_up_2, [nondet]) :-
	lv(1, S),
	parse(S, P0),
	move(P0, 0, vec2(0,-1), P1),
	P0 = P1.
test(move_right_2, [nondet]) :-
	lv(1, S),
	parse(S, P0),
	move(P0, 0, vec2(1,0), P1),
	P0 = P1.
test(move_left_2, [nondet]) :-
	lv(1, S),
	parse(S, P0),
	move(P0, 0, vec2(-1,0), P1),
	P0 = P1.

:- end_tests(lists).
