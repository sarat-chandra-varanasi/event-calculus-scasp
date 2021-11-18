#include 'bec_theory.lp'.
#include 'events.lp'.
#include 'utils.lp'.

initiallyN(s1(closed)).
initiallyP(s1(open)).
initiallyN(s2(open)).
initiallyP(s2(closed)).
initiallyN(r(activated)).
initiallyP(r(deactivated)).
intiallyN(light(on)).
initiallyP(light(off)).


happens(s1_close, 10).

happens(relay_activate, T) :-  holds(s1(closed), T1), inf(T1, T).
happens(s2_open, T) :- holds(relay(activated), T1), inf(T1, T).


holds(light(on), T) :- holds(s1(closed), T1), holds(s2(closed), T1), inf(T1, T).


max_time(20).