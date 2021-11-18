started(F, T) :- 
    holds(F, T).

started(F, T) :- 
    initiates(E, F, T),
    happens(E, T).

stopped(F, T) :-
    -holds(F, T).

stopped(F, T) :-
    terminates(E, F, T),
    happens(E, T).

initiated(F, T) :-
     started(F, T).

initated(F, T) :-
    not terminate(F, T).

terminate(F, T) :-
      terminates(E, F, T),
      happens(E, T).

terminated(F, T) :- 
      stopped(F, T).

terminated(F, T) :-
     not initiate(F, T).

initiate(F, T) :-
        initiates(E, F, T),
        happens(E, T).      