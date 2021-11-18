
num(0..10).
time(0..10).

initiates(entry, no_of_entries(B+1),T) :- time(T), num(B), holdsAt(no_of_entries(B), T). 
terminates(entry, no_of_entries(B),T) :- time(T), num(B), holdsAt(no_of_entries(B), T).

initiallyP(no_of_entries(0)).
initiallyN(no_of_entries(B)) :- num(B), B != 0.

fluent(no_of_entries(B)) :- num(B).

happens(entry, T) :- time(T), not neg_happens(entry, T).
neg_happens(entry, T) :- time(T), not happens(entry, T).

event(entry).
max_time(10).

:- not holdsAt(no_of_entries(5), 10).
% :- holdsAt(no_of_entries(B), T), B > 5.
:- happens(entry, T), max_time(T).

% #show holdsAt/2.

#show happens/2.