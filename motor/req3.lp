"When the motor engagement become not satisfied, the motor engagement controller shall command motor disengagement within 100 ms."

req3(T) :- 
     d_holds(not_satisfied, T).


check3(T, TEngage) :- 
     req3(T), happens(motor_disengage, TEngage), TEngage .<. T + 0.1, TEngage .>. T.


check3dual(T, TEngage) :-
     req3(T), TEngage .<. T + 0.1, TEngage .>. T, not_happens_in(motor_disengage, T, TEngage).

check3 :- check3(T, TEngage).
check3dual :- check3dual(T, TEngage).  