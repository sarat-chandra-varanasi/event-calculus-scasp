#include 'bec_original.lp'.

max_time(20).

event(a).
event(b).

fluent(state_1).
fluent(state_2).

initiates(a, state_1, T).
initiates(b, state_2, T).
terminates(b, state_1, T).


initiallyN(state_1).
initiallyN(state_2).

 happens(b, T2) :- holdsAt(state_1, T), T1 .=. T + 1, inf(T1, T2).

% happens(b, T2) :- happens(a, T1), T2 .=. T1 + 1.

% happens(b, 4).

happens(a, 2).

