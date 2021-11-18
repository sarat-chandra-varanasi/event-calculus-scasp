#include 'bec_sarat.lp'.
#include 'causal_sarat.lp'.
#include 'events.lp'.
#include 'utils.lp'.


initiallyN(s1(open)).
initiallyP(s1(closed)).
initiallyP(s2(closed)).
initiallyN(s2(open)).
initiallyP(s3(closed)).
initiallyN(s3(open)).
initiallyN(light(on)).
initiallyP(light(off)).
initiallyP(relay(deactivated)).
initiallyN(relay(activated)).

happens(s1_close, 10).

happens(light_on, T) :- 
     stopped(light(off), T), initiated(s1(closed), T), initiated(s2(closed), T).
happens(s2_off, T) :- started(s2(closed), T), initiated(relay(activated), T).
happens(relay_deactivate, T) :- stopped(relay(activated), T), initiated(s1(closed), T), initiated(s3(closed), T).


max_time(20).