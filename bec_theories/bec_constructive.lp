
%% BASIC EVENT CALCULUS (BEC) THEORY

max_time(30).

%% BEC1 - StoppedIn(t1,f,t2)
stoppedIn(T1, Fluent, T2) :-
    terminates(Event, Fluent, T),
    happens(Event, T),
    T1 .<. T, T .<. T2,
    max_time(Max),
    T1 .=<. Max,
    T .=<. Max, 
    T2 .=<. Max.

%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    initiates(Event, Fluent, T1),
    happens(Event, T1),
     T1 .<. T,
     max_time(Max),
     T1 .=<. Max, T .=<. Max,
     not stoppedIn(T1, Fluent, T).
     

