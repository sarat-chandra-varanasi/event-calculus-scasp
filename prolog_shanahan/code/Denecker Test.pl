/*

   Here's a test query.

   :- abdemo([holds_at(q,T), holds_at(p,T)],R).

   Should fail.

*/



axiom(initially(neg(q)),[]).

axiom(initially(neg(p)),[]).

axiom(initiates(a,q,T),[]).

/*
axiom(terminates(a,neg(q),T),[]).
*/

axiom(holds_at(p,T),[holds_at(q,T)]).


abducible(dummy).

executable(a).


