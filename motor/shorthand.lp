
inhibit(T) :- d_holds(motor_inhibit(active), T).
not_confirmed(T) :- d_holds(engage(not_confirmed), T).
confirmed(T) :- d_holds(engage(confirmed), T).
sat(T) :- d_holds(satisfied, T).
unsat(T) :- d_holds(not_satisfied, T).