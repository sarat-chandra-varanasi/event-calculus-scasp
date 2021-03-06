
%% BASIC EVENT CALCULUS (BEC) THEORY


%% BEC1 - StoppedIn(t1,f,t2)
stoppedIn(T1, Fluent, T2) :-
    terminates(Event, Fluent, T),
    happens(Event, T),
    T1 .<. T, T .<. T2.
    

stoppedIn(T1, Fluent, T2) :-
    releases(Event, Fluent, T),
    happens(Event, T),
    T1 .<. T, T .<. T2.
    

%% BEC2 - StartedIn(t1,f,t2)
startedIn(T1, Fluent, T2) :-
    initiates(Event, Fluent, T),
    happens(Event, T),
    T1 .<. T, T .<. T2.
 

startedIn(T1, Fluent, T2) :-
    releases(Event, Fluent, T),
    happens(Event, T),
    T1 .<. T, T .<. T2.
    

%% BEC4 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    0 .<. T,
    initiallyP(Fluent),
    not stoppedIn(0, Fluent, T).

%% BEC3 - holdsAt(f,t)
holdsAt(Fluent2, T2) :-
    initiates(Event, Fluent1, T1),
    happens(Event, T1),
    trajectory(Fluent1, T1, Fluent2, T2),
    not stoppedIn(T1, Fluent1, T2).

%% BEC5 - not holdsAt(f,t)
-holdsAt(Fluent, T) :-
    0 .<. T,
    initiallyN(Fluent),
    not startedIn(0, Fluent, T).

%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    initiates(Event, Fluent, T1),
    happens(Event, T1),
     T1 .<. T,
    not stoppedIn(T1, Fluent, T).

%% BEC7 - not holdsAt(f,t)
-holdsAt(Fluent, T) :-
    terminates(Event, Fluent, T1),
    happens(Event, T1),
     T1 .<. T,
    not startedIn(T1, Fluent, T).

