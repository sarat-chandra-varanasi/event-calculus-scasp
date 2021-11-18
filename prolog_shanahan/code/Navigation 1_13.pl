/*

   Test queries:

   :- abdemo([holds_at(in(robot,r3),T)],R).

   :- abdemo([happens(go_to_room(r3),T1,T2)],R).

*/


/*
   With recursive compound events, it's important to leave the second
   time argument of happens unbound as long as possible, so that when
   we reach the base case it can be bound to an existing time constant.
*/

axiom(happens(go_to_room(R,R),T,T),[]).

axiom(happens(go_to_room(R1,R3),T1,T3),
     [connects(D,R1,R2), happens(go_through(D),T1),
     happens(go_to_room(R2,R3),T2,T3), before(T1,T2),
     not(clipped(T1,in(robot,R2),T2))]).

axiom(initiates(go_to_room(R1,R2),in(robot,R2),T),[holds_at(in(robot,R1),T)]).



/* Primitive actions */


axiom(initiates(go_through(D),in(robot,R1),T),
     [connects(D,R2,R1), holds_at(in(robot,R2),T)]).

axiom(terminates(go_through(D),in(robot,R),T),[holds_at(in(robot,R),T)]).




axiom(initially(in(robot,r1)),[]).

axiom(initially(neg(in(robot,r2))),[]).

axiom(initially(neg(in(robot,r3))),[]).



/* Room connectivity */


axiom(connects(d1,r1,r2),[]).

axiom(connects(d2,r2,r3),[]).



/* Abduction policy */


abducible(dummy).

executable(pick_up(P)).

executable(put_down(P)).

executable(go_through(D)).
