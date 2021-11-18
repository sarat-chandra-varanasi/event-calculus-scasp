"When the motor engagement criteria become not satisfied, the motor engagement controller shall set motor status to disengaged within x ms."

req5(T) :- 
       d_holds(not_satisfied, T).

check5(T, TDisengage) :- 
      req5(T), holds(status(disengage), TDisengage), 
      TDisengage .<. T + 0.1, TDisengage .>. T.


check5dual(T, TDisengage) :- 
      req5(T),  TDisengage .<. T + 0.1, TDisengage .>. T, 
      not_holds(status(disengage), TDisengage).


check5 :- check5(T, TDisengage).
check5dual :- check5dual(T, TDisengage).

