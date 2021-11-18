
holdsAt(F, T) :- 
     % var(T),
     initiates(E, F, T1),
     happens(E, T1, _),
     T .>. T1, 
     % nonvar(T1),
     not_stoppedIn(T1, F, T).


not_stoppedIn(T1, approaching, T) :- 
        happens(in, T2, _), 
        T1 .=<. T2, T2 .=<. T. 


      