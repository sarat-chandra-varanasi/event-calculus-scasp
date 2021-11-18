/*
   Here are a number of tricky problems that can expose unsoundness
   or incompleteness in a planner.
*/




/*
   ANOMALY 1

   Test query:

        :- abdemo([holds_at(r1,T),holds_at(p1,T)],[],R).

   A plan should be:

        [happens(e1,t1), happens(e2,t2), before(t2,t1)]

   This problem illustrates the need for proofs of not(clipped)
   facts to be able to add happens facts to the residue.
*/

axiom(initially(p1),[]).

axiom(initially(q1),[]).

axiom(initiates(e1,r1,T),[]).

axiom(terminates(e1,p1,T),[holds_at(q1,T)]).

axiom(terminates(e2,q1,T),[]).




/*
   ANOMALY 2 (due to Rob Miller)

   Test query:

        :- demo([holds_at(p2,t1)],[happens(e3,t0),before(t0,t1)],[],N).

   The query should fail. This problem illustrates the unsoundness of
   negation-as-failure when applied to holds_at.
*/

axiom(initially(p2),[]).

axiom(terminates(e3,p2,T),[holds_at(q2,T)]).




/*
   ANOMALY 3 (Missiaen, et al., JLC, vol.5 no.5).

   Test queries:

        :- abdemo([holds_at(p,T),holds_at(q,T),holds_at(r,T)],[],R).

        :- demo_naf([clipped(0,r,t7)],
             [before(t2,t1), happens(e2,t2),
             before(t0,t1), happens(e1,t0)]).

   Both queries should fail. This illustrates the unsoundness of
   negation-as-failure when applied to before.
*/


axiom(initially(r),[]).

axiom(initiates(e1,p,T),[]).

axiom(initiates(e2,q,T),[]).

axiom(terminates(e1,r,T),[holds_at(q,T)]).

axiom(terminates(e2,r,T),[holds_at(p,T)]).




executable(e1).

executable(e2).

abducible(dummy).