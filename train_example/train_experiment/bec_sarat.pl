
holdsAt(F, T) :- 
     % var(T),
     initiates(E, F, T1),
     happens(E, T1),
     {T > T1}, 
     % nonvar(T1),
     not_stoppedIn(T1, F, T).

stoppedIn(T1, F, T) :- 
     terminates(E, F, _), 
     happens(E, T2),
     {T > T1, T =< T2}.
     
not_stoppedIn(T1, F, T) :- 
     not(stoppedIn(T1, F, T)).
     
        
