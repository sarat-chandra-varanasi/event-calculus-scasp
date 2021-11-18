
%% BASIC EVENT CALCULUS (BEC) THEORY

:- use_module(library(clpr)).

precision(0).
time(T) :- {T > 0, T < 12}.

%% BEC1 - StoppedIn(t1,f,t2)
stoppedIn(T1, Fluent, T2, Ein, Eout) :-
    terminates(Event, Fluent, T),
    fluent(Fluent),
    time(T1), time(T2),
    event(Event),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    {T1 < T, T < T2}.
    

stoppedIn(T1, Fluent, T2, Ein, Eout) :-
    releases(Event, Fluent, T),
    fluent(Fluent),
    time(T1), time(T2),
    event(Event),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    {T1 < T, T < T2}.
    

%% BEC2 - StartedIn(t1,f,t2)
startedIn(T1, Fluent, T2, Ein, Eout) :-
    initiates(Event, Fluent, T),
    time(T1), time(T2),
    fluent(Fluent),
    event(Event),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    {T1 < T, T < T2}.
 

startedIn(T1, Fluent, T2, Ein, Eout) :-
    releases(Event, Fluent, T),
    time(T1), time(T2),
    event(Event),
    fluent(Fluent),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    {T1 < T, T < T2}.
    

%% BEC4 - holdsAt(f,t)
holdsAt(Fluent, T, Ein, Eout) :-
    {0 < T},
    fluent(Fluent),
    time(T),
    initiallyP(Fluent),
    not(stoppedIn(0, Fluent, T, Ein, _)).

%% BEC3 - holdsAt(f,t)
%holdsAt(Fluent2, T2, Ein, Eout) :-
%    fluent(Fluent2),
%    fluent(Fluent1),
%    time(T1), time(T2),
%    event(Event),
%    initiates(Event, Fluent1, T1),
%    add(Event, Ein, E1),
%    happens(Event, T1, E1, Eout),
%    trajectory(Fluent1, T1, Fluent2, T2),
%    not(stoppedIn(T1, Fluent1, T2, Eout, _)).

%% BEC5 - not holdsAt(f,t)
-holdsAt(Fluent, T, Ein, Ein) :-
    {0 < T},
    fluent(Fluent),
    time(T),
    initiallyN(Fluent),
    not(startedIn(0, Fluent, T, Ein, _)).

%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T, Ein, Eout) :-
    initiates(Event, Fluent, T1),
    event(Event),
    fluent(Fluent),
    time(T1), time(T),
    add(Event, Ein, E1),
    not(stoppedIn(T1, Fluent, T, E1, _)),
    happens(Event, T1, E1, Eout),
    precision(P),
     {T1 + P < T}.
   

%% BEC7 - not holdsAt(f,t)
-holdsAt(Fluent, T, Ein, Eout) :-
    time(T1), time(T),
    event(Event), 
    fluent(Fluent),
    terminates(Event, Fluent, T1),
    add(Event, Ein, E1),
    happens(Event, T1, E1, Eout),
    precision(P),
     {T1 + P < T},
    not(startedIn(T1, Fluent, T, Eout, _)).

bound(5).

add(X, T, [X|T]) :- 
     bound(B),
     length([X|T], L), 
     L =< B.

