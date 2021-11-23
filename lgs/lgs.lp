#include '../bec_theories/bec_constructive.lp'.

cond_open_door(T) :-
      holdsAt(on_ground, T), 
      holdsAt(adjustment_necessary, T).


becomes(req_open_door_true, T) :-
      not cond_open_door(T1),
      cond_open_door(T2),
      T2 .>. T1, 
      T2 .<. T1 + 0.1,
      inf(T2, T). 


initiates(e1, on_ground, T).
initiates(e2, adjustment_necessary, T).

happens(open_door, T) :-
         becomes(req_open_door_true, T).
         % becomes(X, T).

initiates(open_door, opening_door, T).
initiates(open_door, opening_door_2, T).


% #abducible happens(e3, 7).

happens(e3, T) :- 
    holdsAt(opening_door_2, T1), 
    T2 .>. T1 + 5, 
   inf(T2, T). 

terminates(e3, opening_door, T).

happens(e1, 1).
happens(e2, 2).

%% Loops
?- holdsAt(opening_door, T1), happens(e3, T).

%% Changing order works
% ?- happens(e3, T), holdsAt(opening_door, T1).

