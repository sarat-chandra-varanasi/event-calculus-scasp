holdsAt(F, T) :-
    happens3(E, T1, T2),
    initiates(E, F, T1),
    T .>=. T1,
    T .=<. T2,
    not stoppedIn(T1, F, T),
    not deHappens(E, T).

stoppedIn(T1, F, T2) :-
    happens3(E, T3, T4),
    terminates(E, F, T3),
    T3 .>=. T1,
    T3 .=<. T2.