%% BASIC EVENT CALCULUS (BEC) THEORY


%% BEC1 - StoppedIn(t1,f,t2)
stoppedIn(T1, Fluent, T2) :-
    time(T1), time(T2), time(T),
    event(Event), fluent(Fluent),
    terminates(Event, Fluent, T),
    happens(Event, T),
    T1 < T, T < T2.
    

stoppedIn(T1, Fluent, T2) :-
    time(T1), time(T2), time(T),
     event(Event), fluent(Fluent),
    releases(Event, Fluent, T),
    happens(Event, T),
    T1 < T, T < T2.
    

%% BEC2 - StartedIn(t1,f,t2)
startedIn(T1, Fluent, T2) :-
    time(T1), time(T2), time(T),
     event(Event), fluent(Fluent),
    initiates(Event, Fluent, T),
    happens(Event, T),
    T1 < T, T < T2.
 

startedIn(T1, Fluent, T2) :-
    time(T1), time(T2), time(T),
     event(Event), fluent(Fluent),
    releases(Event, Fluent, T),
    happens(Event, T),
    T1 < T, T < T2.
    

%% BEC4 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    time(T),
    0 < T,
    initiallyP(Fluent),
    fluent(Fluent),
    not stoppedIn(0, Fluent, T).

%% BEC3 - holdsAt(f,t)
holdsAt(Fluent2, T2) :-
    time(T1), time(T2), time(T),
     event(Event), fluent(Fluent1),
     fluent(Fluent2),
    initiates(Event, Fluent1, T1),
    happens(Event, T1),
    trajectory(Fluent1, T1, Fluent2, T2),
    not stoppedIn(T1, Fluent1, T2).

%% BEC5 - not holdsAt(f,t)
-holdsAt(Fluent, T) :-
    time(T),
    0 < T,
    fluent(Fluent),
    initiallyN(Fluent),
    not startedIn(0, Fluent, T).

%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    time(T1), time(T),
    initiates(Event, Fluent, T1),
     event(Event), fluent(Fluent),
    happens(Event, T1),
     T1 < T,
    not stoppedIn(T1, Fluent, T).

%% BEC7 - not holdsAt(f,t)
-holdsAt(Fluent, T) :-
    time(T), time(T1),
    terminates(Event, Fluent, T1),
    happens(Event, T1),
     T1 < T,
    not startedIn(T1, Fluent, T).


