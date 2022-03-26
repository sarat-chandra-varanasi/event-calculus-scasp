holdsAt(F, T1) :-
       time(T),  
       happens(E, T),
       initiates(E, F, T),
       lt(T, T1), 
       not stopped(F, T, T1).      

stopped(F, T1, T2) :-
      lt(T1, T), lt(T, T2),
      terminates(E, F, _),
      happens(E, T).

-holdsAt(F, T1) :-
        time(T), 
        happens(E, T), 
        terminates(E, F, T),
        lt(T, T1),
         not started(F, T, T1).


started(F, T1, T2) :-
        lt(T1, T), lt(T, T2), 
         initiates(E, F, T),
         happens(E, T).


holdsAt(F, T) :- 
       first(T),
       initiallyP(F).

-holdsAt(F, T) :- 
       first(T),
       initiallyN(F).

 
lt(t1, t2). lt(t2, t3).
lt(X, Y) :- lt(X, Z), lt(Z, Y).

first(t1).

time(t1).
time(t2).
time(t3).


happens(toggle, t1).
happens(toggle, t2).
happens(toggle, t3).

initiallyP(lighton). initiallyN(lightoff).

initiates(toggle, lighton, T) :- time(T), holdsAt(lightoff, T).
terminates(toggle, lightoff, T) :- time(T), holdsAt(lightoff, T).

initiates(toggle, lightoff, T) :- time(T), holdsAt(lighton, T).
terminates(toggle, lighton, T) :- time(T), holdsAt(lighton, T).

#show holdsAt/2.
% #show -holdsAt/2.

