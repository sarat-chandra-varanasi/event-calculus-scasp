#include 'bec_theory.lp'.

% modeling switches
event(close_s1).
event(close_s2).
event(close_s3).
fluent(is_closed_s1).
fluent(is_closed_s2).
fluent(is_closed_s3).
event(turn_light_on).
event(turn_light_off).
fluent(light_on).
event(turn_relay_on).
fluent(relay_on).
event(pop_s1).
event(pop_s2).
event(pop_s3).

% for circuit s1-s2-light
happens(turn_light_on, T) :-
    happens(close_s1, T),
    holdsAt(is_closed_s2, T).

happens(turn_light_on, T) :-
    happens(close_s2, T),
    holdsAt(is_closed_s1, T).

happens(turn_light_off, T2) :-
    T2 .>. T,
    holdsAt(light_on, T),
    happens(pop_s1, T).
happens(turn_light_off, T2) :-
    T2 .>. T,
    holdsAt(light_on, T),
    happens(pop_s2, T).


% for circuit s1-s3-relay
happens(turn_relay_on, T) :-
    happens(close_s1, T),
    holdsAt(is_closed_s3, T).

happens(turn_relay_on, T) :-
    happens(close_s3, T),
    holdsAt(is_closed_s1, T).

initiates(turn_relay_on, relay_on, T).

% for relay-s2
happens(pop_s2, T2) :-
    holdsAt(is_closed_s2, T), happens(turn_relay_on, T), T2 .>. T.



initiates(turn_light_on, light_on, T).
terminates(turn_light_off, light_on, T).
initiates(close_s1, is_closed_s1, T).
initiates(close_s2, is_closed_s2, T) :- not_holdsAt(relay_on, T).
initiates(close_s3, is_closed_s3, T).
terminates(pop_s1, is_closed_s1, T).
terminates(pop_s2, is_closed_s2, T).
terminates(pop_s3, is_closed_s3, T).

initiallyN(is_closed_s2).
initiallyN(is_closed_s1). 
initiallyN(is_closed_s3).
initiallyN(relay_on).
initiallyN(light_on).

happens(close_s1, 4).
happens(close_s2, 6).
happens(close_s3, 8).