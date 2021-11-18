"While the motor engagement criteria are satisfied, when the motor engagement becomes not confirmed, the motor engagement controller shall command motor engagement within 100 ms."

req2(T1, T2, TNotConfirmed) :-
        d_while(satisfied, T1, T2), d_holdsSomeInstantIn(engage(not_confirmed), TNotConfirmed, T1, T2).


check2(T1, T2, TNotConfirmed, TEngage) :-
        req2(T1, T2, TNotConfirmed), happens(motor_engage, TEngage), TEngage .<. TNotConfirmed + 0.1, TEngage .>. TNotConfirmed.

check2dual(T1, T2, TNotConfirmed, TEngage) :-
        req2(T1, T2, TNotConfirmed), TEngage .<. TNotConfirmed + 0.1, TEngage .>. TNotConfirmed, not_happens_in(motor_engage, TNotConfirmed, TEngage). 


check2 :- check2(T1, T2, TNotConfirmed, TEngage).
check2dual :- check2dual(T1, T2, TNotConfirmed, TEngage).


req2 :- req2(T1, T2, TNotConfirmed).