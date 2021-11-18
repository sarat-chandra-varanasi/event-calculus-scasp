% when the altitude error drops below 1000 ft, the system shall enable capture alert
% within 1 second

happens(error_becomes_lt_1000, T, T2) :-
              error_becomes_lt(1000, T),
              T2 .=<. T + 1.


happens(error_becomes_gt_200, T, T2) :-
           error_becomes_gt(200, T),
           T2 .=<. T + 1.           


happens(error_outside_180_1020, T, T2) :-
           error_becomes_lt(180, T), 
           T2 .=<. T + 1.

happens(error_outside_180_1020, T, T2) :-
         error_becomes_gt(1020, T), 
         T2 .=<. T + 1.

% bound duration of adjust to 5 seconds (deliberately done to terminate adjusting for 5 seconds)
happens(stop_adjust, T2, T2) :-
           T1 .=. T - 5,
           T - 5 .>. 0,
%%           holdsIn(altitude_adjusting, T1, T),
           not_happensIn(adjust(_), T1, T),
           inf(T, T2). 

% simulate adjust event when reset happens

% happens(adjust(_), T, T) :- happens(reset, T, T).

happens(not_5, T2, T2) :-
          T1 .=. T - 5,
          T - 5 .>=. 0,
          happens(adjust(_), T1, T1),
          not_happensIn(adjust(_), T1, T),
          inf(T, T2).


% happens(stop_adjust, 5, 5).
% happens(stop_adjust, 15, 15).
