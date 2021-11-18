#include '../bec_sarat.lp'.

max_time(30).

event(start).
event(in).
event(lower).
event(close).
event(exit).
event(raise).
event(open).

fluent(started).
fluent(position(_)).
fluent(lowering).
fluent(gateangle(_)).
fluent(passing).
fluent(rising).
fluent(opened).
fluent(closed).

sampling_window(0.1).

initiates(start, started, T).
initiates(in, passing, T).
initiates(lower, lowering, T).
initiates(close, closed, T).     
initiates(exit, leaving, T).
initiates(raise, rising, T).
initiates(open, opened, T).

terminates(lower, opened, T).
terminates(close, lowering, T).
terminates(exit, passing, T).
terminates(raise, closed, T).
terminates(open, rising, T).


train_speed(10).
angle_lower_rate(15).
angle_rise_rate(15).

trajectory(started, T1, position(X), T2) :-
              train_speed(S),
              T2 .>. T1,
              X .=. ( T2 - T1 ) * S.

trajectory(lowering, T, gateangle(A), T2) :-
            angle_lower_rate(Ar),
            T2 .>. T,
            A .=. ( T2 - T ) * Ar.

happens(start, 1).

happens(in, T) :- 
    holdsAt(position(X1), T1), 
    holdsAt(position(X2), T2), 
    X1 .<. 10, 
    X2 .>=.10, 
    sampling_window(W),
    T2 .<. T1 + W,
    T2 .>. T1,
    inf(T2, T).

happens(lower, T) :-
	holdsAt(position(X1), T1), 
    holdsAt(position(X2), T2), 
    X1 .<. 5, 
    X2 .>=.5, 
    sampling_window(W),
    T2 .<. T1 + W,
    T2 .>. T1,
    inf(T2, T).	      

 happens(close, T) :-     
      holdsAt(gateangle(A1), T1),
      holdsAt(gateangle(A2), T2),
      A1 .<. 88,
      A2 .>=. 88,
      sampling_window(W),
      T2 .<. T1 + W,
      T2 .>. T1,
      inf(T2, T).


happens(exit, T) :-
    holdsAt(position(X1), T1), 
    holdsAt(position(X2), T2), 
    X1 .<. 20, 
    X2 .>=. 20, 
    sampling_window(W),
    T2 .<. T1 + W,
    T2 .>. T1,
    inf(T2, T).


happens(raise, T) :-
     holdsAt(passing, T1),
     holdsAt(leaving, T2),
     sampling_window(W),
     T2 .<. T1 + W,
     T2 .>. T1,
     inf(T2, T).

trajectory(rising, T1, gateangle(A), T2) :-
       holdsAt(gateangle(A1), T1),
       angle_rise_rate(Ar),
       T2 .>. T1,
       A .=. A1 - (T2 - T1) * Ar.

happens(open, T) :-
    holdsAt(gateangle(A1), T1), 
    holdsAt(gateangle(A2), T2), 
    A1 .>. 1, 
    A2 .=<. 1, 
    sampling_window(W),
    T2 .<. T1 + W,
    T2 .>. T1,
    inf(T2, T).

safe(T) :- holdsAt(passing,T), holdsAt(closed, T).
