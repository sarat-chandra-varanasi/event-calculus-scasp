
% helper predicate: error_becomes_lt(V, T) capture the time T when the altitude error drops below V
error_becomes_lt(V, T) :-
          holdsAt(error(E1), T1),
          holdsAt(error(E2), T2),
          E1 .>. V,
          E2 .=<. V,
          precision(P),
          T2 .>. T1, T2 .<. T1 + P, 
          inf(T2, T).

% helper predicate: similar to error_becomes_lt 
error_becomes_gt(V, T) :-
          holdsAt(error(E1), T1),
          holdsAt(error(E2), T2),
          E1 .<. V,
          E2 .>=. V,
          precision(P),
          T2 .>. T1, T2 .<. T1 + P,
          inf(T2, T).	


departure_trajectory(T2) :-
           error_becomes_gt(200, T), 
           T2 .>. T.


in_alert_zone(T2) :- 
         error_becomes_gt(200, T),
         T2 .>. T.

in_alert_zone(T2) :- 
         error_becomes_lt(1000, T),
         T2 .>. T.
