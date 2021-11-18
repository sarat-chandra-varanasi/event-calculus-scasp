started(F, T) :- 
    holdsAt(F, T).

started(F, T) :- 
    initiates(E, F, T),
    happens(E, T).

stopped(F, T) :-
    -holdsAt(F, T).

stopped(F, T) :-
    terminates(E, F, T),
    happens(E, T).


initiated(F, T) :-
    started(F, T), not stopped(F, T).


terminated(F, T) :-
     stopped(F, T), not started(F, T).
