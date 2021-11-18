/*
   Test queries:

        :- abdemo([holds_at(on(b,a),T)],[],R).

        :- demo([holds_at(clear(a),t)], [], [], N).

        :- demo([holds_at(neg(on(X, a)), t2)],
             [happens(move(a,table),t1), before(t1,t2)], [], N)
*/


axiom(initiates(move(X,Y),on(X,Y),T),
     [holds_at(clear(X),T), holds_at(clear(Y),T)]).

axiom(terminates(move(X,Y),on(X,Z),T),
     [holds_at(on(X,Z),T), diff(X,Z), holds_at(clear(X),T),
     holds_at(clear(Y),T)]).

axiom(holds_at(clear(Y),T),[holds_at(neg(on(X,Y)),T)]).

axiom(holds_at(clear(table),T),[]).


axiom(initially(on(c,table)),[]).

axiom(initially(on(b,c)),[]).

axiom(initially(on(a,b)),[]).

axiom(initially(clear(Y)),[]) :-
     \+ axiom(initially(on(X,Y)),[]).



abducible(dummy).

executable(move(X,Y)).
