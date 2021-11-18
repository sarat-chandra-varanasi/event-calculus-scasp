event(error_becomes_lt_1000).
event(error_becomes_gt_200).
event(error_outside_180_1020).
event(adjust(_)).
event(stop_adjust).
event(reset).
event(not_5).

fluent(altitude_not_adjusting).
fluent(altitude_adjusting).
fluent(value(V)).
fluent(baro(B)).
fluent(error(E)).
fluent(departure_alert_on).
fluent(departure_alert_off).
fluent(capture_alert_on).
fluent(capture_alert_off).
fluent(altitude_alert_on).
fluent(altitude_alert_off).
fluent(not_5).


% effect of issuing capture alert
initiates(error_becomes_lt_1000, capture_alert_on, T).
terminates(error_becomes_lt_1000, capture_alert_off, T).

% effect of issuing departure alert
initiates(error_becomes_gt_200, departure_alert_on, T).
terminates(error_becomes_gt_200, departure_alert_off, T).

% issue altitude alert
initiates(error_becomes_lt_1000, altitude_alert_on, T).
terminates(error_becomes_lt_1000, altitude_alert_off, T).


initiates(error_becomes_gt_200, altitude_alert_on, T).
terminates(error_becomes_gt_200, altitude_alert_off, T).



% withdraw all alerts
initiates(error_outside_180_1020, capture_alert_off, T).
initiates(error_outside_180_1020, departure_alert_off,  T).
initiates(error_outside_180_1020, altitude_alert_off, T).	


terminates(error_outside_180_1020, capture_alert_on,  T).
terminates(error_outside_180_1020, departure_alert_on, T).
terminates(error_outside_180_1020, altitude_alert_on, T).

% Altitude is being adjusted when event adjust/1 happens
initiates(adjust(_), altitude_adjusting, T).
terminates(adjust(_), altitude_not_adjusting, T).
terminates(adjust(_), not_5, T).

% stop_adjust bounds the duration of adjust/1
initiates(stop_adjust, altitude_not_adjusting, T).
terminates(stop_adjust, altitude_adjusting, T).


initiates(not_5, not_5, T).
terminates(not_5, altitude_adjusting, T).
% reset unconditionally sets the altitude value to 0

 initiates(reset, altitude_not_adjusting, T).
 terminates(reset, altitude_adjusting, T).

% initiates(reset, altitude_adjusting, T).
% terminates(reset, altitude_not_adjusting, T).
 
terminates(reset, departure_alert_on, T).
terminates(reset, capture_alert_on, T).
terminates(reset, altitude_alert_on, T).

initiates(reset, departure_alert_off, T).
initiates(reset, capture_alert_off, T).
initiates(reset, altitude_alert_off, T).

terminates(reset, not_5, T).

trajectory(altitude_adjusting, T1, error(0), T2) :- 
                      T2 .=<. 5,
                      T2 .>. 0.

trajectory(not_5, T1, error(E), D) :-
                     D .>=. 0,
                     max_time(T3),
                     D .=<. T3 - T1,
                     T2 .=. T1 + D, 
                     T1 .>. 0,
                     %d_holdsAt(baro(B), T2),
                      holdsAt(baro(B), T2),
                      holdsAt(value(V), T2),
                     abs_diff(B, V, E).
                    
