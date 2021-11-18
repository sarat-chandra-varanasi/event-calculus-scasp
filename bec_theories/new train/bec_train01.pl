

%% Include the BASIC EVENT CALCULUS THEORY
#include 'bec_theory01'.

initiates(entry, no_of_entries(N), T) :-
    happens(entry,T),
    holdsAt(no_of_entries(B), T),
    N .=. B + 1.

terminates(entry, no_of_entries(B), T).
    


initiallyP(no_of_entries(0)).
initiallyN(no_of_entries(B)) :- B .>. 0.

happens(entry, 2).
happens(entry, 5).
happens(entry, 8).

?- holdsAt(no_of_entries(0),1).
?- holdsAt(no_of_entries(1),T).
?- holdsAt(no_of_entries(2),T).
?- holdsAt(no_of_entries(N),T).


