#include 'bec_theory.lp'.

% model the train
event(approach).
event(in).
event(out).
event(exit).
fluent(approaching).
fluent(passing).
fluent(leaving).

% model the gate
fluent(raise).
fluent(up).
fluent(lower).
fluent(down).

% model the controller
event(raise_up).
event(lower_down).
event(lock_down).
event(lock_up).

initiates(approach, approaching, T).
terminates(in, approaching, T).
initiates(in, passing, T).
terminates(out, passing, T).
initiates(out, leaving, T).
terminates(exit, leaving, T).

% it takes 2 time-units to lower down the gate
happens(lower_down, T) :- happens(approach, T), holdsAt(up, T).
initiates(lower_down, lower, T).
happens(lock_down, T2) :- happens(lower_down, T), T2 .=. T + 2.
terminates(lock_down, lower, T).
initiates(lock_down, down, T).

happens(raise_up, T) :- happens(exit, T).
terminates(raise_up, down, T).
initiates(raise_up, raise, T).
% it takes 2 time-units to raise up the gate
happens(lock_up, T2) :- happens(raise_up, T), T2 .=. T + 2.
terminates(lock_up, raise, T).
initiates(lock_up, up, T).

% constraints to assert system requirements
:- holdsAt(passing, T), holdsAt(up, T).

initiallyP(up).
initiallyN(down).
initiallyN(lower).
initiallyN(raise).
happens(approach, 1).
happens(in, 5).
happens(out, 11).
happens(exit, 12).
#show happens/2, holdsAt/2.
