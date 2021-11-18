% #include 'bec_tiny.lp'.

#include './bec_theories/bec_sarat.lp'.

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
fluent(leaving).

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
angle_lower_rate(20).
angle_rise_rate(10).

trajectory(started, T1, position(X), T2) :-
              train_speed(S),
              T2 .>. T1,
              X .=. ( T2 - T1 ) * S.

gateanglelower(A,T2) :- 
           happens(lower, T),
           angle_lower_rate(Ar),
           T2 .>. T,
            A .=. ( T2 - T ) * Ar.

happens(start, 1).

% conditions for controller to detect train is in gate area
happens(in, T) :- 
    holdsAt(position(X1), T1), 
    holdsAt(position(X2), T2), 
    X1 .<. 10, 
    X2 .>=.10, 
    sampling_window(W),
    T2 .<. T1 + W,
    T2 .>. T1,
    inf(T2, T).

% controller signals lowering of the gate
happens(lower, T) :-
	holdsAt(position(X1), T1), 
  holdsAt(position(X2), T2), 
    X1 .<. 5, 
    X2 .>=.5, 
    sampling_window(W),
    T2 .<. T1 + W,
    T2 .>. T1,
    inf(T2, T).	      

% gate closure
 happens(close, T) :-     
      gateanglelower(A1, T1),
      gateanglelower(A2, T2),
      A1 .<. 90,
      A2 .>=. 90,
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

gateanglerise(A, T2) :-
         happens(raise, T1),
         angle_rise_rate(Ar),
          T2 .>. T1,
          A .=. 90 - (T2 - T1) * Ar.

happens(open, T) :-
    gateanglerise(A1, T1), 
    gateanglerise(A2, T2), 
    A1 .>. 0, 
    A2 .=<. 0, 
    sampling_window(W),
    T2 .<. T1 + W,
    T2 .>. T1,
    inf(T2, T).


% ?- holdsAt(passing, T), holdsAt(rising, T).

unsafe :- holdsAt(passing, T), holdsAt(rising, T).
unsafe :- holdsAt(passing, T), holdsAt(opened, T).
unsafe :- holdsAt(passing, T), holdsAt(lowering, T).

safe :- holdsAt(passing, T), holdsAt(closed, T).

live :-  holdsAt(passing, T), holdsAt(closed, T), 
         holdsAt(opened, T1), T1 .>. T.


% ?- unsafe.
% ?- holdsAt(passing, T).
% ?- live.
