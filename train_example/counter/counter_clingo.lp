
num(1..10).
time(0..10).

initiates(entry, no_of_entries(B+1),T) :- time(T), num(B), holdsAt(no_of_entries(B), T). 
terminates(entry, no_of_entries(B),T) :- time(T), num(B), holdsAt(no_of_entries(B), T).

initiallyP(no_of_entries(0)).
initiallyN(no_of_entries(B)) :- num(B), B != 0.

happens(entry, 2).

event(entry).
max_time(10).