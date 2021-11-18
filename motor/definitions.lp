d_holds(engage(confirmed), T) :-
              d_holds(feedback(true), T).

d_holds(engage(not_confirmed), T) :- 
              d_holds(feedback(false), T).


d_holds(automation(req), T) :- 
            holds(pilot(req), T).

d_holds(automation(not_req), T) :- 
            holds(pilot(not_req), T).


d_holds(satisfied, T) :- 
         d_holds(automation(online), T),
         T1 .=. T - 5, 
         d_holdsSomeInstant(motor_inhibit(active), T1, T).


d_holds(not_satisfied, T) :- 
        d_holds(automation(not_online), T).

d_holds(not_satisfied, T) :- 
         d_holds(automation(online), T),
         T1 .=. T - 5, 
         d_holdsIn(motor_inhibit(inactive), T1, T).
 
d_holds(motor_inhibit(active), T) :- 
              d_holds(any_function(invalid), T).

d_holds(motor_inhibit(active), T) :-
              d_holds(motor_feedback(invalid), T).

d_holds(motor_inhibit(active), T) :-
              d_holds(monitor_flag(set), T). %% should check with Bren

d_holds(motor_inhibit(active), T) :-
              d_holds(motor_runway(active), T).

d_holds(motor_inhibit(active), T) :- 
              holds(reset, T).

d_holds(motor_runway(active), T) :- 
            d_holds(runway_monitor(active), T), 
            d_holds(motor_feedback(runway), T).

d_holds(motor_runway(inactive), T) :- 
            d_holds(runway_monitor(inactive), T), d_holds(motor_feedback(not_runway), T).


d_holds(motor_feedback(valid), T) :- 
            T1 .=. T - 3,
            holdsSomeInstant(feedback_up(valid), T1, T),
            holdsSomeInstant(feedback_down(valid), T1, T). 

d_holds(motor_feedback(invalid), T) :-
            T1 .=. T - 3, 
            holdsSomeInstant(feedback_up(invalid), T1, T).

d_holds(motor_feedback(invalid), T) :- 
           T1 .=. T - 3,
           holdsSomeInstant(feedback_down(invalid), T1, T).

d_holds(motor(open), T) :- 
          T1 .=. T - 0.5, 
          d_holdsIn(satisfied, T1, T).
          d_holds(engage(not_confimed), T).

          