#include '../bec_theories/xc_shanahan.lp'.
#include 'definitions.lp'.
#include 'events.lp'.
#include 'happens.lp'.
#include 'utils.lp'.
#include 'shorthand.lp'.

% initially all alerts are off
initiallyP(capture_alert_off).
initiallyP(departure_alert_off).
initiallyP(altitude_alert_off).


initiallyN(capture_alert_on).
initiallyN(departure_alert_on).
initiallyN(altitude_alert_on).

% initially altitude is not adjusting
initiallyP(altitude_adjusting).
initiallyN(altitude_not_adjusting).

% assuming an initial selected altitude value of 34000
initiallyN(value(V)) :- initiallyP(value(V1)), V \= V1.
initiallyP(value(32300)).

max_time(100).
precision(0.1).

% barometric altitude is 32000 ft throught (only for convenience of modelling)
d_holdsAt(baro(32000), T) :- max_time(T1), T .=<. T1, T .>=. 0. 


happens(adjust(32300), 0, 0).



% we will check the behavior of the system using the reset abducible
% SEU (Single Event Upset)
#abducible happens(reset, 10, 10).

% reset/0 depends on abducible event
 reset :- happens(reset, _, _).

default :- not reset.

?- holdsAt(departure_alert_on, T).

% ?- happens(init_departure_alert, T).

query(T, T1) :- happens(reset, T), T1 .>=. T + 5, departure_trajectory(T1), holdsAt(departure_alert_on, T1). 

%query(T1, T2) :- 
%       happens(reset, T1), 
%       T2 .>=. T1 + 5,
%       departure_trajectory(T2),
%       happens(error_becomes_gt_200, T2, T2).

%?- query(T, T2).


% ?- default, holdsAt(departure_alert_on, T).

% ?- holdsAt(departure_alert_on, T) : 76937.49999382632 ms
% holdsAt(departure_alert_on), T .>. 15:  1639140.624938502 ms
% reset run, with invalid requirements:  

% REQ5' RESET
?- reset, query(T1, T2).