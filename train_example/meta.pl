
:- use_module(library(clpr)).
:- discontiguous rule/2.
rule(stoppedIn(T1, Fluent, T2, Ein, Eout), 
	[fluent(Fluent),
    time(T1), time(T2),
    event(Event),
    terminates(Event, Fluent, T),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    lt(T1, T), lt(T, T2)]).

lt(T1, T2) :- {T1 < T2}.

rule(stoppedIn(T1, Fluent, T2, Ein, Eout),
    [fluent(Fluent),
    time(T1), time(T2),
    event(Event),
    releases(Event, Fluent, T),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    lt(T1, T), lt(T, T2)]).

rule(startedIn(T1, Fluent, T2, Ein, Eout),
    [time(T1), time(T2),
    fluent(Fluent),
    event(Event),
    initiates(Event, Fluent, T),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    lt(T1, T), lt(T, T2)]).

rule(holdsAt(Fluent, T, Ein, Eout),
    [lt(0,T),
    fluent(Fluent),
    time(T),
    initiallyP(Fluent),
    not(stoppedIn(0, Fluent, T, Ein, Eout))]).




%% MODIFIED BASIC EVENT CALCULUS (BEC) THEORY 

%% ALWAYS USE A MAX_TIME USING max_time(MaxTime)
%% ALWAYS SPECIFY THE SET OF EVENTS THAT MODIFY FLUENTS IN THE SYSTEM USING event(EventName)
%% USE holdsAt(F, T) TO QUERY FLUENTS, AND -holdsAt(F, T) TO QUERY NEGATIONS

precision(0).

%% BEC1 - StoppedIn(t1,f,t2)
stoppedIn(T1, Fluent, T2, Ein, Eout) :-
    event(Event),
    terminates(Event, Fluent, T),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout), 
    T1 .>=. 0, 
    T1 .<. T, T .<. T2, 
    max_time(T3), T2 .<. T3.

stoppedIn(T1, Fluent, T2) :-
    event(Event),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    not terminates(Event, Fluent, T),
    releases(Event, Fluent, T),
    T1 .>=. 0, T1 .<. T, T .<. T2, 
    max_time(T3), T2 .<. T3.
   

not_stoppedIn(T1, Fluent, T2, Ein) :-
    time(T1), time(T2), {T1 < T2},
    findall(E, terminates(E,F,_), EventList),
    not_happen(EventList, T1, T2, Ein),


happens(E, T1, T2, Ein, Eout) :-
       add(E, Ein, Eout),
       happens(E, T),
       {T1 < T, T < T2}.

not_happen([H|T], T1, T2, Ein) :- 
        not(happens(H, T1, T2, Ein)) 
not_happen_event(H, T1, T2, Ein) :-
        add(H, Ein, E1),
        happen(H, T, E1, E2),



%% BEC2 - StartedIn(t1,f,t2)
startedIn(T1, Fluent, T2, Ein, Eout) :-
    time(T1), time(T2), time(T),
    fluent(Fluent), event(Event)
    initiates(Event, Fluent, T),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    {T1 =< T, T =< T2}.
    
startedIn(T1, Fluent, T2, Ein, Eout) :-
    time(T1), time(T2), time(T),
    fluent(Fluent),
    event(Event),
    add(Event, Ein, E1),
    happens(Event, T, E1, Eout),
    not(initiates(Event, Fluent, _)),
    releases(Event, Fluent, T),
    {T1  < T, T < T2}.
    
not_startedIn(T1, Fluent, T2, Ein) :-
    time(T1), time(T2), 
    {T1 < T2},
    findall(E, initiates(E, Fluent, _), EventList),
    %not_released(Fluent, EventList, T1, T2, yes),
    not_happens(EventList, T1, T2).


%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T, Ein, Eout) :-
    event(Event),
    time(T), time(T1),
    initiates(Event, Fluent, T1),
    add(Event, Ein, E1),
    happens(Event, T1, E1, Eout),
    precision(P),
    {T1 > 0, T1 + P < T},
    not_stoppedIn(T1, Fluent, T).
%    not -holdsAt(Fluent, T).


%% BEC3 - holdsAt(f,t)
holdsAt(Fluent2, T2, Ein, Eout) :-
    event(Event),
    time(T2),
    add(Event, Ein, E1),
    happens(Event, T1, E1, Eout),
    initiates(Event, Fluent1, T1),
    trajectory(Fluent1, T1, Fluent2, T2),
    not_stoppedIn(T1, Fluent1, T2, Eout).
%    not -holdsAt(Fluent2, T2).

%% BEC4 - holdsAt(f,t)
holdsAt(Fluent, T, Ein, Ein) :-
    time(T),
    fluent(Fluent),
    initiallyP(Fluent),
    not_stoppedIn(0, Fluent, T, Ein).
%    not -holdsAt(Fluent, T).
  
%% BEC5 - not holdsAt(f,t)
not_holdsAt(Fluent, T, Ein, Ein) :-
    time(T),    
    fluent(Fluent),
    initiallyN(Fluent),
    not_startedIn(0, Fluent, T, Ein).
%    not holdsAt(Fluent, T).


%% BEC7 - not holdsAt(f,t)
not_holdsAt(Fluent, T, Ein, Eout) :-
    time(T1), time(T),
    fluent(Fluent),
    precision(P),
    {T1 >= 0, T1 + P < T},
    event(Event),
    terminates(Event, Fluent, T1),
    add(Event, Ein, E1),
    happens(Event, T1, E1, Eout),
    not_startedIn(T1, Fluent, T, Eout).
%    not holdsAt(Fluent, T).

bound(4).

add(X, T, [X|T]) :- 
     bound(B),
     length([X|T], L), 
     L =< B.


length([], 0).
length([H|T], L) :-
    length(T, L1),
    L is L1 + 1.