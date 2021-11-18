abs(X, Y, Z) :- X .>. Y, Z .=. X - Y.
abs(X, Y, Z) :- X .=<. Y, Z .=. Y - X.

earliest_lt(Value, T) :- 
       d_holds(altitude_error(E), T), E .<. Value, 
       d_holds(altitude_error(E1), T1), E1 .>=. Value, T .>. T1, T - T1 .<. 0.2. 
       %not not_least(T, lt, Value).

earliest_gt(Value, T) :- 
       d_holds(altitude_error(E), T), E .>. Value,    
       d_holds(altitude_error(E1), T1), E1 .=<. Value, T .>. T1, T - T1 .<. 0.2. 
       %not not_least(T, gt, Value).    

% holdsIn(Fluent, T1, T2) :-
%       not_stoppedIn(T1, Fluent, T2), holds(Fluent, T1), holds(Fluent, T2), T1 .<. T2.


holdsIn(Fluent, T1, T2) :-
       holds(Fluent, T1), not_stoppedIn(T1, Fluent, T2), T1 .<. T2.

d_holdsIn(Fluent, T1, T2) :-
       d_holds(Fluent, T1),  T1 .<. T2, not d_stoppedIn(T1, F, T2).
 
d_stoppedIn(T1, Fluent, T2) :- T1 .<. T, T .<. T2, not d_holds(Fluent, T).

not_holdsIn(Fluent, T1, T2) :-
       not_holds(Fluent, T1).

not_holdsIn(Fluent, T1, T2) :-
       not_holds(Fluent, T2).

not_holdsIn(Fluent, T1, T2) :-
        T1 .<. T, T .<. T2, stoppedIn(T1, Fluent, T2).

while_clipped(Fluent, T1, T2) :-
      holdsIn(Fluent, T1, T2), T3 .>. T2, not_holds(Fluent, T3).

not_while_clipped(Fluent, T1, T2) :- 
      not_holdsIn(Fluent, T1, T2).

not_while_clipped(Fluent, T1, T2) :-
      holdsIn(Fluent, T1, T2), T3 .>. T2, holds(Fluent, T3).

while(Fluent, T1, T2) :-
      holdsIn(Fluent, T1, T2).

d_while(Fluent, T1, T2) :-
      d_holdsIn(Fluent, T1, T2).


not_d_while(Fluent, T1, T2) :-
       holdsSomeInstant(Fluent, T1, T2).

not_while(Fluent, T1, T2) :-
      not_holdsIn(Fluent, T1, T2).

append([H|T], L, [H|L1]) :- append(T, L, L1).
append([], L, L).



out_of_range(T) :- T1 .>. T, d_holds(altitude_error(E), T1), E .<. 180.
out_of_range(T) :- T1 .>. T, d_holds(altitude_error(E), T1), E .>. 1020.

%not out_of_range(T) :- T1 .=<. T.
%not out_of_range(T) :- T1 .>. T, not d_holds(error(E), T1).
%not out_of_range(T) :- T1 .>. T, d_holds(altitude_error(E), T1), E .>=. 180.
%not out_of_range(T) :- T1 .>. T, d_holds(altitude_error(E), T1), E .=<. 1020.



below_180(T) :- error(E, T), E .<. 180.
above_1020(T) :- error(E, T), E .>. 1020, not out_of_range(T). 


not_out_of_range(Time) :- 
          findall(T1, below_180(T1), List1) ,
          findall(T2, above_1020(T2), List2),
          append(List1, List2, List),
          check_times(List, Time).

check_times([H|T], Time) :- 
          H .=<. Time, 
          check_times(T, Time).

check_times([], _).


holdsSomeInstant(Fluent, T1, T2) :-
          T1 .=<. T, T .=<. T2, T1 .<. T2, holds(Fluent, T).

d_holdsSomeInstant(Fluent, T1, T2) :-
          T1 .=<. T, T .=<. T2, T1 .<. T2, d_holds(Fluent, T).          


inconsistency(F, T) :- holds(F, T), not_d_holds(F, T).
d_inconsistency(F, T) :- d_holds(F, T), not_d_holds(F, T).