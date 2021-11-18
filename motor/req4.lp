"While motor engagement is commanded, when the motor engagement becomes confirmed, the motor engagement controller shall set motor status to engaged within x ms."

req4(T1, T2, TConfirmed) :- 
       while(T1, T2, motor(engage)), T1 .=<. T, T .=<. T2, d_holds(engage(confirmed), T).

check4(T1, T2, TConfirmed, TEngage) :-
      req4(T1, T2, TConfirmed), holds(motor_status(engage), TEngage), 
      TEngage .<. TConfirmed + 0.1, TEngage .>. TConfirmed.

check4dual(T1, T2, TConfirmed, TEngage) :-
      req4(T1, T2, TConfirmed), TEngage .<. TConfirmed + 0.1, TEngage .>. TConfirmed, 
      not_holdsIn(motor_status(engage), TEngage).


check4 :- check4(T1, T2, TConfirmed, TEngage).
check4dual :- check4dual(T1, T2, TConfirmed, TEngage).