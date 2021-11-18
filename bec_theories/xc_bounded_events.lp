% XC1
holdsAt(F, T, Ein, Ein) :-
       T .>. 0,
       initiallyP(F),
       not_clipped(0, F, T).

% XC2

% tweak to give preferencne to BEC over XC
holdsAt(F, T2, Ein, Eout) :-
       T2 .>. 0,
       initiates(E, F, T1),
       add(E, Ein, E1),
       happens(E, T1, T1, E1, Eout),
       % not_cancelled(E, F, T1, T2),  [Not using cancelled for now]
       T1 .<. T2,
       not_clipped(T1, F, T2).


holdsAt(F, T3, Ein, Eout) :-
       T1 .>. 0,
       initiates(E, F, T1),
       add(E, Ein, E1),
       happens(E, T1, T2, E1, Eout),
       T1 .=<. T2,
       % not_cancelled(E, F, T1, T2),  [Not using cancelled for now]
       T2 .<. T3,
       not_clipped(T1, F, T3).

% XC3
clipped(T1, F, T4) :-
       T1 .>. 0, 
       terminates(E, T2),
       happens(E, T2, T3),
       T2 .=<. T3,
       T1 .<. T3,
       T2 .=<. T4.

% XC4
not_holdsAt(F, T, Ein, Ein) :-
       T .>. 0, 
       initiallyN(F),
       not_declipped(0, F, T).

% XC5
not_holdsAt(F, T3, Ein, Eout) :-
       T3 .>. 0,
       terminates(E, F, T1),
       add(E, Ein, E1),
       happens(E, T1, T2, E1, Eout),
       T1 .=<. T2,
       %not_cancelled(E, F, T1, T2),
       T2 .=<. T3,
       not_declipped(T1, F, T3).

% XC6
declipped(T1, F, T4) :-
        T1 .>. 0,
        initiates(E, F, T1),
        happens(E, T2, T3),
        T2 .=<. T3,
        T1 .<. T3,
        T2 .<. T4.
        %not_cancelled(E, F, T2, T3).

% XC7 happens(E, T1, T2) => T1 < T2 is referenced in every other axiom

% XC8 : Cancellation axiom, not using now

cancelled(E1, F, T1, T2) :-
          cancels(E2, E1, F),
          happens(E2, T1, T2).  

%  XC9: Trajectory axiom 
holdsAt(F2, T3, Ein, Eout) :-
        initiates(E, F1, T1),
        trajectory(F1, T1, F2, D),
        add(E, Ein, E1)m
        happens(E, T1, T2, E1, Eout),
        T1 .=<. T2,
        T2 .<. T3,
        T3 .=. T2 + D,
        not_clipped(T1, F1, T3).


term(E, F, T) :- 
       terminates(E, F, T), 
       happens(E, T, _).

init(E, F, T) :-
       initiates(E, F, T),
       happens(E, T, _).

 not_clipped(T1, F, T2) :-
      %findall(T, term(E, F, T), List),
      findall(E, terminates(E, F,_), List),
      out(T1, T2, List).


 not_declipped(T1, F, T2) :-
       %findall(T, init(E, F, T), List),
       findall(E, initiates(E, F, _), List),
       out(T1, T2, List).

 out_of(T1, _, T) :- T .<. T1.
 out_of(_, T2, T) :- T .>=. T2.

out(T1, T2, [H|T]) :-
            happens(E, Time, [], _),
            out_of(T1, T2, Time),
            out(T1, T2, T).

out(T1, T2, [H|T]) :-
            not happens(E, _, _, _),
            out(T1, T2, T).

out(T1, T2, []).


happens(E, T) :- happens(E, T, T, [], _). 

bound(3).

add(X, List, [X|List]) :-
         length([X|List], L),
         bound(B),
         L =< B.

length([], 0).
length([H|T], L) :-
     length(T, L1),
     L is L1 + 1.