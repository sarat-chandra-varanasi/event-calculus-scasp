#include '../bec_theories/bec_sarat.lp'.
#include '../bec_theories/causal_sarat.lp'.
#include 'events.lp'.
%#include 'utils.lp'.


initiallyP(s1(open)).
initiallyN(s1(closed)).
initiallyP(s2(closed)).
initiallyN(s2(open)).
initiallyP(s3(closed)).
initiallyN(s3(open)).
initiallyN(light(on)).
initiallyP(light(off)).
initiallyP(relay(deactivated)).
initiallyN(relay(activated)).

happens(s1_close, 10).

happens(light_on, T1) :- 
        stopped(light(on), T), 
        initiated(s1(closed), T), 
        initiated(s2(closed), T),
        T1 .=. T + 1.

happens(s2_open, T1) :- 
         started(s2(closed), T), 
         initiated(relay(activated), T),
         T1 .=. T + 1.


happens(relay_activate, T1) :-
             stopped(relay(activated), T),
             initiated(s1(closed), T),
             initiated(s3(closed), T),
             T1 .=. T + 1.

max_time(20).
	
