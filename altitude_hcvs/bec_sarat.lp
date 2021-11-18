
%% MODIFIED BASIC EVENT CALCULUS (BEC) THEORY 

%% ALWAYS USE A MAX_TIME USING max_time(MaxTime)
%% ALWAYS SPECIFY THE SET OF EVENTS THAT MODIFY FLUENTS IN THE SYSTEM USING event(EventName)
%% USE holdsAt(F, T) TO QUERY FLUENTS, AND not_holdsAt(F, T) TO QUERY NEGATIONS


%% BEC1 - StoppedIn(t1,f,t2)
stoppedIn(T1, Fluent, T2) :-
    event(Event),
    terminates(Event, Fluent, T),
    happens(Event, T), 
    T1 .>=. 0, 
    T1 .<. T, T .<. T2, 
    max_time(T3), T2 .<. T3.

stoppedIn(T1, Fluent, T2) :-
    event(Event),
    happens(Event, T),
    not terminates(Event, Fluent, T),
    releases(Event, Fluent, T),
    T1 .>=. 0, T1 .<. T, T .<. T2, 
    max_time(T3), T2 .<. T3.
   

not_stoppedIn(T1, Fluent, T2) :-
    T1 .>=. 0,
    max_time(T3), T2 .<. T3,
    findall(E, event(E), EventList),
    not_terminated(Fluent, EventList, T1, T2, yes),
    not_released(Fluent, EventList, T1, T2, yes).

%not_stoppedIn(T1, Fluent, T2) :-
%    T1 .>=. 0, 
%    max_time(T3), T2 .<. T3,
%    findall(E, event(E), EventList),
%    not_released(Fluent, EventList, T1, T2, yes).

released(Event, Fluent, T1, T2) :-
     releases(Event, Fluent, T), T1 .=<. T, T .=<. T2, happens(Event, T).

not_released(Fluent, [H|X], T1, T2, no) :-
          released(H, Fluent, T1, T2, no).

not_released(Fluent, [H|X], T1, T2, Val) :-
      findall(T,rel(H,Fluent,T),List),
      no_release(List, T1, T2),
      not_released(Fluent, X, T1, T2, Val).

no_release([H|T], T1, T2) :- H .=<. T1, no_release(T, T1, T2).
no_release([H|T], T1, T2) :- H .>=. T2, no_release(T, T1, T2).
no_release([], _, _).

not_released(_, [], _, _, yes).

rel(E, F, T1) :- releases(E, F, T, T1), happens(E, T).

terminated(Event, Fluent, T1, T2) :-
     terminates(Event, Fluent, T), happens(Event, T), T1 .>. 0,  T1 .=<. T, T .=<. T2.

not_terminated(Fluent, [H|X], T1, T2, no) :-
      terminated(H, Fluent, T1, T2).

term(E, F, T1) :- terminates(E, F, T, T1), happens(E, T).

not_terminated(Fluent, [H|X], T1, T2, Val) :-
      findall(T, term(H, Fluent, T), List),
      no_terminate(List, T1, T2),
      not_terminated(Fluent, X, T1, T2, Val).

no_terminate([H|T], T1, T2) :- H .=<. T1, no_terminate(T, T1, T2).
no_terminate([H|T], T1, T2) :- H .>=. T2, no_terminate(T, T1, T2).
no_terminate([], _, _).

not_terminated(_, [], _, _, yes).


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

init(E, F, T1) :- initiates(E, F, T, T1), happens(E, T).

not_initiated(Fluent, [H|X], T1, T2, Val) :-
      findall(T, init(H,Fluent,T), List),
      no_initiate(List, T1, T2),
      not_initiated(Fluent, X, T1, T2, Val).

no_initiate([H|T], T1, T2) :- H .=<. T1, no_initiate(T, T1, T2).
no_initiate([H|T], T1, T2) :- H .>=. T2, no_initiate(T, T1, T2).
no_initiate([], _, _).

not_initiated(_, [], _, _, yes).    

initiated(Event, Fluent, T1, T2) :-
   initiates(Event, Fluent, T), happens(Event, T), T1 .=<. T, T .=<. T2.


%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    event(Event),
    initiates(Event, Fluent, T2, T1),
    happens(Event, T2),
    T1 .>. 0, T1 .<. T,
    not_stoppedIn(T1, Fluent, T).
%    not not_holdsAt(Fluent, T).


%% BEC3 - holdsAt(f,t)
holdsAt(Fluent2, T2) :-
    event(Event),
    happens(Event, T),
    initiates(Event, Fluent1, T, T1),
    trajectory(Fluent1, T1, Fluent2, T2),
    not_stoppedIn(T1, Fluent1, T2).
%    not not_holdsAt(Fluent2, T2).

%% BEC4 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    initiallyP(Fluent),
    0 .=<. T,
    not_stoppedIn(0, Fluent, T).
%    not not_holdsAt(Fluent, T).
 
%% BEC5 - not holdsAt(f,t)
not_holdsAt(Fluent, T) :-
     0 .=<. T,
     max_time(T3), T .<. T3,
    initiallyN(Fluent),
    not_startedIn(0, Fluent, T).
%    not holdsAt(Fluent, T).


%% BEC7 - not holdsAt(f,t)
not_holdsAt(Fluent, T) :-
    T1 .>=. 0, T1 .<. T,
    max_time(T3), T .<. T3,
    event(Event),
    happens(Event, T2),
    terminates(Event, Fluent, T2, T1),
    not_startedIn(T1, Fluent, T).
%    not holdsAt(Fluent, T).

             