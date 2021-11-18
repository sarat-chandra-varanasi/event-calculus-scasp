% "While motor engagement is not confirmed, when the motor engagement criteria become satisfied, the motor engagement controller shall command motor engagement within 100 ms."

req1(T1, T2, TSatisfied) :- 
      d_while(engage(not_confirmed), T1, T2), d_holdsSomeInstantIn(satisfied, TSat, T1, T2), earliest(TSat, TSatisfied).


check1(TSatisfied, TEngage) :- 
     happens(motor_engage, TEngage), TEngage .<. TSatisfied + 0.1, TEngage .>. TSatisfied.

check1dual(TSatisfied, TEngage) :- 
      TEngage .<. TSatisfied + 0.1, TEngage .>. TSatisfied, not_happens_in(motor_engage, TSatisfied, TEngaged).

check1(T1, T2, TSatisfied, TEngage) :- req1(T1, T2, TSatisfied), check1(TSatisfied, TEngage).
check1dual(T1, T2, TSatisfied, TEngage) :- req1(T1, T2, TSatisfied), check1dual(TSatisfied, TEngage).

check1 :- check1(T1, T2, TSatisfied, TEngage).
check1dual :- check1dual(T1, T2, TSatisfied, TEngage).