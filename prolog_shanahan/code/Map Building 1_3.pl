/*
   The idea here is to abduce room connectivity given a narrative of
   robot actions plus some holds_at facts about which rooms it ends
   up in. The initiates and terminates clauses are the same as for the
   navigation domain.

   Test queries:

   :- abdemo([holds_at(in(robot,r2),t1),holds_at(in(robot,r3),t3)],
           [happens(go_through(d1),t0),before(t0,t1),
           happens(go_through(d2),t2),before(t1,t2),before(t2,t3)],R).

   Should abduce that:

        connects(d1,r1,r2)
        connects(d2,r2,r3)
*/



/* Primitive actions */


axiom(happens(A,T,T),[happens(A,T)]).

axiom(initiates(go_through(D),in(robot,R1),T),
     [connects(D,R2,R1), holds_at(in(robot,R2),T)]).

axiom(terminates(go_through(D),in(robot,R),T),[holds_at(in(robot,R),T)]).



/* Initial situation */


axiom(initially(in(robot,r1)),[]).

axiom(initially(neg(in(robot,r2))),[]).

axiom(initially(neg(in(robot,r3))),[]).



/* Abduction policy */


abducible(connects(D,R1,R2)).

executable(dummy).
