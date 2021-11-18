% DEC 1
stoppedIn(T1, F, T2) :-
         time(T1),
         time(T2),
         event(E),
         happens(E, T),
         time(T),
         T1 < T, T < T2,
         terminates(E, F, T).

% DEC 2
startedIn(T1, F, T2) :-
         event(E),
         time(T1),
         time(T2),
         happens(E, T),
         T1 < T, T < T2,
         initiates(E, F, T).


% DEC 5
holdsAt(F, T+1) :-
        time(T+1),
        time(T),
        holdsAt(F, T),
        event(E),
        happens(E, T),
        terminates(E, F, T).

% DEC 6
-holdsAt(F, T+1) :-
        time(T+1),
        time(T),
        -holdsAt(F, T),
        event(E),
        happens(E, T),
        initiates(E, F, T).


