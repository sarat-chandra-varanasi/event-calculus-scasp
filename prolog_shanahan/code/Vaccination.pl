/*

   Rob Miller's vaccination example

   Here's a test query.

   :- abdemo([holds_at(immune,T)],R).

   A valid plan is
      [happens(vaccinate1,t1), happens(vaccinate2,t2), t1 < t2, t2 < T]

*/

axiom(initiates(vaccinate1,immune,T),[holds_at(type1,T)]).

axiom(initiates(vaccinate2,immune,T),[holds_at(neg(type1),T)]).

executable(vaccinate1).

executable(vaccinate2).

abducible(dummy).

