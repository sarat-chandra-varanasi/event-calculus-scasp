

 
% not_stoppedIn(6, lowering, T2) :- T2 .>. 6, T2 .=<. 11, angle_lower_rate(18).
% not_stoppedIn(6, lowering, T2) :- T2 .>. 6, T2 .=<. 15, angle_lower_rate(15).


not_stoppedIn2(T1, F, T2) :- not_stoppedIn(T1, F, T2).

not_stoppedIn(T1, started, T2) :- {T1 >= 1}, max_time(T3), {T2 > T1, T2 < T3}.

not_stoppedIn(T1, lowering, T2) :-
    happens(lower, T1),
    findall(T, term_check(close, lowering, T), List), 
    no_terminate(List, T1, T2).   

not_stoppedIn(T1, passing, T2) :- 
    happens(in, T1),
    findall(T, term_check(exit, passing, T), List), 
    no_terminate(List, T1, T2).   


not_stoppedIn(T1, rising, T2) :-
    happens(raise, T1),
    findall(T, term_check(open, rising, T), List), 
    no_terminate(List, T1, T2).   

not_stoppedIn(T1, opened, T2) :- 
    happens(open, T1),
    findall(T, term_check(lower, opened, T), List), 
    no_terminate(List, T1, T2).   

not_stoppedIn(T1, closed, T2) :-
    happens(close, T1),
    findall(T, term_check(raise, closed, T), List), 
    no_terminate(List, T1, T2).   


%not_stoppedIn(T1, Fluent, T2) :-
%    T1 .>=. 0,
%    max_time(T3), T2 .<. T3,
%    % Fluent \= lowering,
%    findall(E, terminates(E, Fluent, _ ), EventList),
%    not_terminated(Fluent, EventList, T1, T2, yes). 
    
%neg_not_stoppedIn(T1, Fluent, T2) :-
%    T1 .>=. 0,
%    max_time(T3), T2 .<. T3,
%    % Fluent \= lowering,
%    not not_stoppedIn(T1, Fluent, T2),
%    findall(E, terminates(E, Fluent, _ ), EventList),
%    not_terminated(Fluent, EventList, T1, T2, yes).
    

terminated(Event, Fluent, T1, T2) :-
     terminates(Event, Fluent, T), happens(Event, T), {T1 > 0,  T1 =< T, T =< T2, T1 < T2}.

not_terminated(Fluent, [H|X], T1, T2, no) :-
      terminated(H, Fluent, T1, T2).
    

term_check(E, F, T) :- terminates(E, F, T), happens(E, T).

not_terminated(Fluent, [H|X], T1, T2, Val) :-
      findall(T, term_check(H, Fluent, T), List),
      no_terminate(List, T1, T2),
      not_terminated(Fluent, X, T1, T2, Val).

no_terminate([H|T], T1, T2) :- {H =< T1, H =< T2}, no_terminate(T, T1, T2).
no_terminate([H|T], T1, T2) :- {H >= T2, H >= T1}, no_terminate(T, T1, T2).
no_terminate([], _, _).

not_terminated(_, [], _, _, yes).

%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    initiates(Event, Fluent, T1),
    happens(Event, T1),
    not_stoppedIn2(T1, Fluent, T),
    {T1 > 0, T1 < T}.


%% BEC3 - holdsAt(f,t)
holdsAt(Fluent2, T2) :-
    trajectory(Fluent1, T1, Fluent2, T2),
    initiates(Event, Fluent1, T1),
    happens(Event, T1),
    not_stoppedIn2(T1, Fluent1, T2).

%% BEC4 - holdsAt(f,t)
%holdsAt(Fluent, T) :-
%    initiallyP(Fluent),
%    0 .=<. T,
%    not_stoppedIn(0, Fluent, T).
  
