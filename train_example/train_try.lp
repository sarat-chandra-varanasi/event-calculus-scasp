#include 'bec_sarat.lp'.
max_time(10).

random(0.24).

happens(approach, 1).

initiates(approach, approaching, T).
initiates(in, passing, T).
terminates(in, approaching, T).

happens(in, T2) :-
       happens(approach, T1),
       random(R), 
       T + R .>. T1, T - T1 + R .<. 2,
       inf(T, T2).
       holdsAt(approaching, T2).

event(approach).
event(in).
       
fluent(approaching).
fluent(passing).
