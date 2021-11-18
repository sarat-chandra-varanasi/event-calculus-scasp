
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
    T1 .>=. 0,
    max_time(T3), T2 .<. T3,
    findall(E, terminates(E,F,_), EventList),
    not_happen(EventList, T1, T2, Ein).
    %not_released(Fluent, EventList, T1, T2, yes, E1, Eout).
    % holdsIn(Fluent, T1, T2).




%% BEC2 - StartedIn(t1,f,t2)
startedIn(T1, Fluent, T2) :-
    T1 .>=. 0,
    max_time(T3), T2 .<. T3,
    initiates(Event, Fluent, T),
    happens(Event, T),
    T1 .=<. T, T .=<. T2.
    
startedIn(T1, Fluent, T2) :-
    T1 .>=. 0,
    max_time(T3), T2 .<. T3,
    happens(Event, T),
    not initiates(Event, Fluent, T),
    releases(Event, Fluent, T),
    T1 .<. T, T .<. T2.
    
not_startedIn(T1, Fluent, T2) :-
    T1 .>=. 0, 
    max_time(T3), T2 .<. T3,
    findall(E, event(E), EventList),
    not_released(Fluent, EventList, T1, T2, yes),
    not_initiated(Fluent, EventList, T1, T2, yes).

%not_startedIn(T1, Fluent, T2) :-
%    T1 .<. T2,
%    findall(E, event(E), EventList),
%    not_initiated(Fluent, EventList, T1, T2, yes).
 
not_initiated(Fluent, [H|_], T1, T2, no) :- 
    initated(H, Fluent, T1, T2).

init_check(E, F, T) :- initiates(E, F, T), happens(E, T, [], _).

not_initiated(Fluent, [H|X], T1, T2, Val) :-
      findall(T, init_check(H,Fluent,T), List),
      no_initiate(List, T1, T2),
      not_initiated(Fluent, X, T1, T2, Val).

no_initiate([H|T], T1, T2) :- H .=<. T1, no_initiate(T, T1, T2).
no_initiate([H|T], T1, T2) :- H .>=. T2, no_initiate(T, T1, T2).
no_initiate([], _, _).

not_initiated(_, [], _, _, yes).    

initiated(Event, Fluent, T1, T2) :-
   initiates(Event, Fluent, T), happens(Event, T), T1 .=<. T, T .=<. T2.


%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T, Ein, Eout) :-
    event(Event),
    initiates(Event, Fluent, T1),
    add(Event, Ein, E1),
    happens(Event, T1, E1, Eout),
    precision(P),
    T1 .>. 0, T1 + P .<. T,
    not_stoppedIn(T1, Fluent, T).
%    not -holdsAt(Fluent, T).


%% BEC3 - holdsAt(f,t)
holdsAt(Fluent2, T2, Ein, Eout) :-
    event(Event),
    add(Event, Ein, Eout),
    happens(Event, T1),
    initiates(Event, Fluent1, T1),
    trajectory(Fluent1, T1, Fluent2, T2),
    not_stoppedIn(T1, Fluent1, T2).
%    not -holdsAt(Fluent2, T2).

%% BEC4 - holdsAt(f,t)
holdsAt(Fluent, T, Ein, Ein) :-
    initiallyP(Fluent),
    0 .=<. T,
    not_stoppedIn(0, Fluent, T).
%    not -holdsAt(Fluent, T).
  
%% BEC5 - not holdsAt(f,t)
not_holdsAt(Fluent, T, Ein, Ein) :-
     0 .=<. T,
     max_time(T3), T .<. T3,
    initiallyN(Fluent),
    not_startedIn(0, Fluent, T).
%    not holdsAt(Fluent, T).


%% BEC7 - not holdsAt(f,t)
not_holdsAt(Fluent, T, Ein, Eout) :-
    precision(P),
    T1 .>=. 0, T1 + P.<. T,
    max_time(T3), T .<. T3,
    event(Event),
    add(Event, Ein, Eout),
    happens(Event, T1),
    terminates(Event, Fluent, T1),
    not_startedIn(T1, Fluent, T).
%    not holdsAt(Fluent, T).

