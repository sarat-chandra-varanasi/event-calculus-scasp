/*

   Formulae for the shopping example from Russell and Norvig

   Here's a test query.

   :- abdemo([holds_at(have(drill),T), holds_at(have(milk),T),
        holds_at(have(banana),T), holds_at(at(home),T)],R).

   Here's a simpler one.

   :- abdemo([holds_at(have(drill),T), holds_at(have(milk),T)],R).

*/



axiom(initiates(go(X),at(X),T),[]).

axiom(terminates(go(X),at(Y),T),[diff(X,Y)]).

axiom(initiates(buy(X),have(X),T),[sells(Y,X), holds_at(at(Y),T)]).

axiom(sells(hws,drill),[]).

axiom(sells(sm,milk),[]).

axiom(sells(sm,banana),[]).



/* Abduction policy */

abducible(dummy).

executable(go(X)).

executable(buy(X)).
