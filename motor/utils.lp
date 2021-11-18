abs(X, Y, Z) :- X .>. Y, Z .=. X - Y.
abs(X, Y, Z) :- X .=<. Y, Z .=. Y - X.


earliest(T, T1) :- inf(T, T1).


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
      d_holdsIn(Fluent, T1, T2), max_time(T3), T2 .=<. T3.   


not_d_while(Fluent, T1, T2) :-
       holdsSomeInstant(Fluent, T1, T2).

not_while(Fluent, T1, T2) :-
      not_holdsIn(Fluent, T1, T2).

append([H|T], L, [H|L1]) :- append(T, L, L1).
append([], L, L).




holdsSomeInstant(Fluent, T1, T2) :-
          T1 .=<. T, T .=<. T2, T1 .<. T2, holds(Fluent, T).

d_holdsSomeInstant(Fluent, T1, T2) :-
          T1 .=<. T, T .=<. T2, T1 .<. T2, d_holds(Fluent, T).          

d_holdsSomeInstantIn(Fluent, TInstant, T1, T2) :-
          T1 .=<. TInstant, TInstant .=<. T2, T1 .<. T2, d_holds(Fluent, TInstant).


inconsistency(F, T) :- holds(F, T), not_d_holds(F, T).
d_inconsistency(F, T) :- d_holds(F, T), not_d_holds(F, T).

not_happens_in(Event, T1, T2) :- 
        findall(T, happens(Event, T), List),
        outside(List, T1, T2).

happens_in(Event, T1, T2) :- 
         happens(Event, T), T1 .=<. T, T .=<. T2.


outside([H|T], T1, T2) :-  H .<. T1, outside(T, T2).
outside([H|T], T1, T2) :-  H .>. T2, outside(T, T2).
outside([], _, _).