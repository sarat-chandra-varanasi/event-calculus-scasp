switch(s1).
switch(s2).
relay(r).

opened(s1, T1) :- happens(s1, open, T), T1 .=. T + 0.1.
opened(s2, T1) :- happens(s2, open, T),  T1 .=. T + 0.1.
closed(s1, T1) :- happens(s1, close, T),  T1 .=. T + 0.1.
closed(s2, T1) :- happens(s2, close, T), T1 .=. T + 0.1.
activated(r, T1) :- happens(r, activate, T), T1 .=. T + 0.1.
deactivated(r, T1) :- happens(r, deactivate, T), T1 .=. T + 0.1.


happens(r, activate, T) :- closed(s1, T1), inf(T1, T). 
happens(s2, open, T) :- activated(r, T1), inf(T1, T).


lighton(T) :- closed(s1, T), closed(s2, T).

terminates(Switch, opened, close) :- switch(Switch).
terminates(Switch, closed, open) :- switch(Switch). 
terminates(Relay, activated, activate) :- relay(Relay).
terminates(Relay, deactivated, deactivate) :- relay(Relay).


opened(Switch, T) :- opened(Switch, _, T).
closed(Switch, T) :- closed(Switch, _, T).
activated(Relay, T) :- activated(Relay, _, T).
deactivated(Relay, T) :- deactivated(Relay, _, T).
opened(Switch, T1, T2) :- switch(Switch), opened(Switch, T1), T1 .>=. 0, T1 .<. T2, not stopped(Switch, opened, T1, T2).
closed(Switch, T1, T2) :- switch(Switch), closed(Switch, T1), T1 .>=. 0, T1 .<. T2, not stopped(Switch, closed, T1, T2).
activated(Relay, T1, T2) :- relay(Relay), activated(Relay, T1), T1 .>=. 0, T1 .<. T2, not stopped(Relay, activated, T1, T2).
deactivated(Relay, T1, T2) :- relay(Relay), deactivated(Relay, T1), T1 .>=. 0, T1 .<. T2, not stopped(Relay, deactivated, T1, T2). 
stopped(Object, State, T1, T2) :-  terminates(Object, State, Event), happensIn(Object, Event, T1, T2), T2 .>=. T1 + 0.1. 


happensIn(Object, Event, T1, T2) :- happens(Object, Event, T), T1 .>. 0, T .>. T1, T .=<. T2.


opened(s1, 0).
closed(s2, 0).
deactivated(r, 0).

happens(s1, close, 10).