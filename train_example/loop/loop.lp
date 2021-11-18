#include 'bec_bounded_events.lp'.

event(open).
event(close).

happens(close, 1, E, E). 

fluent(opened).
fluent(closed).

initiates(open, opened, T).
terminates(open, closed, T).

initiates(close, closed, T). 
terminates(close, opened, T).

initiallyN(opened).
initiallyN(closed).

happens(open, T, Ein, Eout) :-
       add(close, Ein, E1),  
       happens(close, T, E1, E2),
       T .=. T1 + 1,
       holdsAt(closed, T1, E2, Eout).

