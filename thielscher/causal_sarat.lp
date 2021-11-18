started(F, T) :- 
    holdsAt(F, T).

started(F, T) :- 
    event(E),
    initiates(E, F, T),
    happens(E, T).

stopped(F, T) :-
    not_holdsAt(F, T).

stopped(F, T) :-
    event(E),
    terminates(E, F, T),
    happens(E, T).


initiated(F, T) :-
    started(F, T), 
    not_terminatedcheck(F, T).

terminatedcheck(F, T) :- 
      event(E), 
      terminates(E, F, T), 
      happens(E, T).

terminated(F, T) :- 
      stopped(F, T),
      not_initiatedcheck(F, T).

initiatedcheck(F, T) :-
        event(E),
        initiates(E, F, T),
        happens(E, T).

inits(E, F) :- event(E), initiates(E, F, _).
terms(E, F) :- event(E), terminates(E, F, _).

not_terminatedcheck(F, T) :-
        findall(E, terms(E, F), EventList),
        not_happens(EventList, T).

not_initiatedcheck(F, T) :-
        findall(E, inits(E, F), EventList),
        not_happens(EventList, T).

not_happens(EventList, T) :-
       findall(E, happens(E, T), List),
       disjoint(EventList, List).


disjoint([], _).
disjoint([H|T], List) :- disjoint_element(H, List), disjoint(T, List).
disjoint_element(_, []).
disjoint_element(H, [H1|T1]) :- H \= H1, disjoint_element(H, T1).