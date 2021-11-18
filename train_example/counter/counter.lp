#include 'bec_original.lp'.


initiates(entry, no_of_entries(1),T).
terminates(entry, no_of_entries(0),T).

initiallyP(no_of_entries(0)).
initiallyN(no_of_entries(B)) :- B .<>. 0.

happens(entry, 2).


event(entry).
max_time(10).