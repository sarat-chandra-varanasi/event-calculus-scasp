#include 'bec_clingo_1.lp'.

initiates(entry, no_of_entries(N), T) :- 
               time(T),
	       num(B), 
               holdsAt(no_of_entries(B), T),
               N = B + 1.


terminates(entry, no_of_entries(B), T) :-
               time(T),
	       num(B), 
               holdsAt(no_of_entries(B), T).

fluent(no_of_entries(B)) :- num(B).

num(0).
num(1).

initiallyP(no_of_entries(0)).
initiallyN(no_of_entries(B)) :- num(B), B \= 0.

happens(entry, 2).
max_time(4).
event(entry).

time(0).
time(1).
time(2).
time(3).
time(4).

% #show holdsAt/2.
