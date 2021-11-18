/*

   Formulae for the mail delivery domain.

   Example queries:

   :- abdemo([holds_at(in(p1,r3),T)],R).

   :- abdemo([holds_at(in(p1,r3),T),holds_at(neg(got(p1)),T)],R).

*/


/* There should probably be some releases clauses for compound actions */

/* Compound actions */


axiom(happens(shift_pack(P,R),T1,T4),
     [happens(retrieve_pack(P),T1,T2), before(T2,T3),
     happens(deliver_pack(P,R),T3,T4),
     not(clipped(T2,got(P),T3))]).

axiom(initiates(shift_pack(P,R),in(P,R),T),[]).


axiom(happens(retrieve_pack(P),T1,T2),
     [holds_at(in(P,R),T1), happens(go_to_room(R),T1),
     happens(pick_up(P),T2), before(T1,T2),
     not(clipped(T1,in(robot,R),T2))]).

axiom(initiates(retrieve_pack(P),got(P),T),[]).


axiom(happens(deliver_pack(P,R),T1,T2),
     [happens(go_to_room(R),T1),
     happens(put_down(P),T2), before(T1,T2),
     not(clipped(T1,in(robot,R),T2))]).

axiom(initiates(deliver_pack(P,R),in(P,R),T),[holds_at(got(P),T)]).



/* Primitive actions */


axiom(initiates(pick_up(P),got(P),T),
     [diff(P,robot), holds_at(in(P,R),T), holds_at(in(robot,R),T)]).

axiom(releases(pick_up(P),in(P,R),T),
     [diff(P,robot), holds_at(in(P,R),T), holds_at(in(robot,R),T)]).


axiom(initiates(put_down(P),in(P,R),T),
     [diff(P,robot), holds_at(got(P),T), holds_at(in(robot,R),T)]).

axiom(terminates(put_down(P),got(P),T),[]).


axiom(initiates(go_to_room(R),in(robot,R),T),[]).

axiom(terminates(go_to_room(R1),in(robot,R2),T),[diff(R1,R2)]).



/* Domain constraints */


axiom(holds_at(in(P,R),T),
     [diff(P,robot), holds_at(got(P),T), holds_at(in(robot,R),T)]).



/* Narrative */


axiom(initially(in(robot,r1)),[]).

axiom(initially(neg(in(robot,r2))),[]).

axiom(initially(neg(in(robot,r3))),[]).

axiom(initially(in(p1,r2)),[]).

axiom(initially(neg(in(p1,r1))),[]).

axiom(initially(neg(in(p1,r3))),[]).



/* Abduction policy */


abducible(dummy).


executable(pick_up(P)).

executable(put_down(P)).

executable(go_to_room(R)).
