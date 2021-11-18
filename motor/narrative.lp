#include 'bec_sarat.lp'.
#include 'definitions.lp'.
#include 'events.lp'.
#include 'utils.lp'.
#include 'shorthand.lp'.
#include 'requirements.lp'.

max_time(40).

happens(dummy, 0).


d_holds(automation(online), T) :- T .>=. 5.
d_holds(feedback(true), T) :- T .=<. 10.


d_holds(feedback(false), T) :- T .>. 10, max_time(T3), T .=<. T3.

initiallyP(no_reset).
initiallyN(reset).

happens(reset, 5.01).

happens(motor_engage, 10.01).