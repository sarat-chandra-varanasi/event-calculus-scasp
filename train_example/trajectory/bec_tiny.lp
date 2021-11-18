 
not_stoppedIn(T1, Fluent, T2) :-
    T1 .>=. 0,
    max_time(T3), T2 .<. T3,
    findall(E, terminates(E, Fluent, _ ), EventList),
    not_terminated(Fluent, EventList, T1, T2, yes). 
    
terminated(Event, Fluent, T1, T2) :-
     terminates(Event, Fluent, T), happens(Event, T), T1 .>. 0,  T1 .=<. T, T .=<. T2, T1 .<. T2.

not_terminated(Fluent, [H|X], T1, T2, no) :-
      % terminated(H, Fluent, T1, T2).
      term_0(H, Fluent, T1, T2).

term_check(E, F, T) :- terminates(E, F, T), happens(E, T).

not_terminated(Fluent, [H|X], T1, T2, Val) :-
      findall(T, term_check(H, Fluent, T), List),
      no_terminate(List, T1, T2),
      not_terminated(Fluent, X, T1, T2, Val).

no_terminate([H|T], T1, T2) :- H .=<. T1, H .=<. T2, no_terminate(T, T1, T2).
no_terminate([H|T], T1, T2) :- H .>=. T2, H .>=. T1, no_terminate(T, T1, T2).
no_terminate([], _, _).

not_terminated(_, [], _, _, yes).

%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    initiates(Event, Fluent, T1),
    happens(Event, T1),
    not_stoppedIn(T1, Fluent, T),
    T1 .>. 0, T1 .<. T.


%% BEC3 - holdsAt(f,t)
holdsAt(Fluent2, T2) :-
    trajectory(Fluent1, T1, Fluent2, T2),
    initiates(Event, Fluent1, T1),
    happens(Event, T1),
    not_stoppedIn(T1, Fluent1, T2).

%% BEC4 - holdsAt(f,t)
%holdsAt(Fluent, T) :-
%    initiallyP(Fluent),
%    0 .=<. T,
%    not_stoppedIn(0, Fluent, T).
  
