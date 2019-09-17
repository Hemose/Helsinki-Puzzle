grid_build(N,M):-
			grid_build(N,1,M).
grid_build(N,C,[H|T]):-
			C\=N,
			length(H,N),
			N1 is C+1,
			grid_build(N,N1,T).
grid_build(N,N,[H]):-
			length(H,N).
grid_gen(N,G):-
			grid_build(N,G),
			row_col_match(G),		
			helper1(N,0,G),
			distinct_rows(G),
			check_num_grid(G).
helper1(N,C,[H|T]):-
			C<N,
			help2(N,0,H),
			C1 is C+1,
			helper1(N,C1,T).
helper1(N,N,[]).
help2(N,C,[H|T]):-
			C<N,
			C1 is C+1,
			num_gen(1,N,R),
			member(H,R),
			help2(N,C1,T).
help2(N,N,[]).

num_gen(F,L,[F|T]):-
			F\=L,
			F1 is F+1,
			num_gen(F1,L,T).
num_gen(F,F,[F]).
max_grid([H|T],M,R):-
			max_grid(H,M,R1),
			max_grid(T,R1,R).
max_grid(H,M,H):-
			\+is_list(H),
			H>M.
max_grid(H,M,M):-
			\+is_list(H),
			H=<M.
max_grid([],M,M).
check_num_grid(G):-
			max_grid(G,0,R),
			length(G,L),
			R=<L,
			check(G,1,R).
check(G,X,R):-
			X\==R,
			check(G,X),
			X1 is X+1,
			check(G,X1,R).
check(_,R,R).
check([H|T],X):-
			check3(H,X),!;
			check(T,X).
check3([H|T],X):-
			X=H,!;
			check3(T,X).
acceptable_distribution(G):-
			ad(G,G,1).
ad(G,[H|T],C):-
			col(G,C,R),
			H\==R,
			C1 is C+1,
			ad(G,T,C1).
ad(_,[],_).
col([H|T],C,[A|B]):-
			find(H,C,A),
			col(T,C,B).
col([],_,[]).
find([_|T],C,A):-
			C\=1,
			C1 is C-1,
			find(T,C1,A).
find([H|_],1,H).
trans(M,M1):-
			len(M,N),
			trans(M,1,N,M1).
trans(M,F,E,[H|T]):-
			F\=E,
			col(M,F,H),
			F1 is F+1,
			trans(M,F1,E,T).
trans(M,E,E,[H]):-
			col(M,E,H).
len([_|T],N):-
			len(T,N1),
			N is N1 +1.
len([],0).
distinct_rows([H|T]):-
			dr(H,T),
			distinct_rows(T).
distinct_rows([]).
dr(X,[H|T]):-
			X\==H,
			dr(X,T).
dr(_,[]).
distinct_columns(M):-
			trans(M,C),
			distinct_rows(C).

helsinki(N,G):-
			grid_gen(N,G).

row_col_match(G):-
			trans(G,M),
			acceptable_permutation(G,M).
	



acceptable_permutation(L,R):-
	permutation(L,R),
	ff(L,R).
ff([],[]).
ff([H|T],[X|T2]):-
	H\==X,
	ff(T,T2).	




check2([H|T],M):-
			member2(H,M),
			check2(T,M).
check2([],_).
member2(X,[H|T]):-
			H==X,!;
			member2(X,T).
member2(_,[]).

