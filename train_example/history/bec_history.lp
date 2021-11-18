
%% BASIC EVENT CALCULUS (BEC) THEORY

precision(0).
time(T) :- T .>. 0, T .<. 12.
     
%% BEC4 - holdsAt(f,t)
holdsAt(Fluent, T, E, E) :-
    0 .<. T,
    fluent(Fluent),
    time(T),
    initiallyP(Fluent),
    not_stoppedIn(0, Fluent, E, T).

%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T, Ein, Eout) :-
    event(Event),
    fluent(Fluent),
    time(T1), time(T),
    initiates(Event, Fluent, T1),
    happens(Event, T1, Ein, Eout),
    precision(P),
    T1 + P .<. T,
    not_stoppedIn(T1, Fluent, Eout, T).

not_stoppedIn(T1, Fluent, Eout, T2) :-
     findall(E, terminates(E, Fluent, _), List),
     happens_outside(List, T1, T2, Eout).


happens_outside([H|R], T1, T2, Eout) :- 
        findall(T, happens(H, T, Eout, _), List),
        out(List, T1, T2), 
        happens_outside(R, T1, T2, Eout).
happens_outside([], _, _, _).

out([H|T], T1, T2) :- outside(H, T1, T2), out(T, T1, T2).
out([], _, _).

outside(T, T1, T2) :- T .<. T1, T .<. T2.
outside(T, T1, T2) :- T .>. T2, T .>. T1.

bound(10).

%add(X, T, [X|T]) :- 
%     bound(B),
%     length([X|T], L), 
%     L =< B.

add(X, T, T) :-
      member(X, T).

add(X, T, [X|T]) :-
      not member(X, T).

length([], 0).
length([H|T], L) :-
    length(T, L1),
    L is L1 + 1.


member(H, [H|T]).
member(H, [X|T]) :- X \= H, member(H, T).


?- not_stoppedIn(1, approaching, [], T2).