/* The UCPOP flat tyre benchmark */

/*
   Example queries:

   :- abdemo([holds_at(have(wrench),T)],[[],[]],R)

   :- abdemo([holds_at(loose(nut(nuts1),hub(hub1)), T)], [[],[]], R)

   :- abdemo([holds_at(neg(on_ground(hub(hub1))),T)], [[],[]], R)

   :- abdemo([holds_at(loose(nut(nuts1),hub(hub1)), T),
        holds_at(neg(on_ground(hub(hub1))),T)], [[],[]], R)

   :- abdemo([holds_at(loose(nuts(nuts1),hub(hub1)), T),
        holds_at(have(jack),T),
        holds_at(neg(on_ground(hub(hub1))),T)], [[],[]], R)

   :- abdemo([holds_at(loose(nut(nuts1),hub(hub1)), T1),
        holds_at(have(jack),T1)], [[],[]], R1),
        abdemo([holds_at(neg(on_ground(hub(hub1))),T2)],R1,R2).

   :- abdemo([holds_at(unfastened(hub(hub1)),T)],[[],[]],R)

   :- abdemo([holds_at(neg(on(wheel(wheel1),hub(hub1))),T)],[[],[]],R)

   :- abdemo([holds_at(neg(on(wheel(wheel1),hub(hub1))),T),
        holds_at(on(wheel(wheel2),hub(hub1)),T)],[[],[]],R)

   :- abdemo([holds_at(in(wheel(wheel1),container(boot)),T),
        holds_at(on(wheel(wheel2),hub(hub1)),T)],[[],[]],R)

   :- abdemo([holds_at(in(wheel(wheel1),container(boot)),T),
        holds_at(on(wheel(wheel2),hub(hub1)),T),
        holds_at(in(jack,container(boot)),T)],[[],[]],R)

   :- abdemo([holds_at(in(jack,container(boot)),T),
        holds_at(in(wheel(wheel1),container(boot)),T),
        holds_at(on(wheel(wheel2),hub(hub1)),T)],[[],[]],R)
*/


axiom(initiates(open(container(X)),is_open(container(X)),T),
     [holds_at(neg(locked(container(X))),T)]).

axiom(terminates(close(container(X)),is_open(container(X)),T),[]).

axiom(initiates(fetch(X,container(Y)),have(X),T),
     [holds_at(in(X,container(Y)),T),holds_at(is_open(container(Y)),T)]).

axiom(terminates(fetch(X,container(Y)),in(X,container(Y)),T),
     [holds_at(is_open(container(Y)),T)]).

axiom(initiates(put_away(X,container(Y)),in(X,container(Y)),T),
     [holds_at(have(X),T),holds_at(is_open(container(Y)),T)]).

axiom(terminates(put_away(X,container(Y)),have(X),T),
     [holds_at(is_open(container(Y)),T)]).

axiom(initiates(loosen(nut(X),hub(Y)),loose(nut(X),hub(Y)),T),
     [holds_at(have(wrench),T),holds_at(on_ground(hub(Y)),T)]).

axiom(terminates(loosen(nut(X),hub(Y)),tight(nut(X),hub(Y)),T),
     [holds_at(have(wrench),T),holds_at(on_ground(hub(Y)),T)]).

axiom(initiates(tighten(nut(X),hub(Y)),tight(nut(X),hub(Y)),T),
     [holds_at(have(wrench),T),holds_at(on_ground(hub(Y)),T)]).

axiom(terminates(tighten(nut(X),hub(Y)),loose(nut(X),hub(Y)),T),
     [holds_at(have(wrench),T),holds_at(on_ground(hub(Y)),T)]).

axiom(terminates(jack_up(hub(X)),on_ground(hub(X)),T),
     [holds_at(have(jack),T)]).

axiom(terminates(jack_up(hub(X)),have(jack),T),
     [holds_at(on_ground(hub(X)),T)]).

axiom(initiates(jack_down(hub(X)),on_ground(hub(X)),T),[]).

axiom(initiates(jack_down(hub(X)),have(jack),T),
     [holds_at(neg(on_ground(hub(X))),T)]).

axiom(initiates(undo(nut(X),hub(Y)),have(nut(X)),T),
     [holds_at(neg(on_ground(hub(Y))),T),
     holds_at(neg(unfastened(hub(Y))),T),
     holds_at(have(wrench),T),holds_at(loose(nut(X),hub(Y)),T)]).

axiom(initiates(undo(nut(X),hub(Y)),unfastened(hub(Y)),T),
     [holds_at(neg(on_ground(hub(Y))),T),holds_at(have(wrench),T),
     holds_at(loose(nut(X),hub(Y)),T)]).

axiom(terminates(undo(nut(X),hub(Y)),on(nut(X),hub(Y)),T),
     [holds_at(neg(on_ground(hub(Y))),T),
     holds_at(neg(unfastened(hub(Y))),T),
     holds_at(have(wrench),T),holds_at(loose(nut(X),hub(Y)),T)]).

axiom(terminates(undo(nut(X),hub(Y)),loose(nut(X),hub(Y)),T),
     [holds_at(neg(on_ground(hub(Y))),T),
     holds_at(neg(unfastened(hub(Y))),T),
     holds_at(have(wrench),T)]).

axiom(initiates(do_up(nut(X),hub(Y)),loose(nut(X),hub(Y)),T),
     [holds_at(have(wrench),T),holds_at(unfastened(hub(Y)),T),
     holds_at(neg(on_ground(hub(Y))),T),holds_at(have(nut(X)),T)]).

axiom(terminates(do_up(nut(X),hub(Y)),unfastened(hub(Y)),T),
     [holds_at(have(wrench),T),holds_at(neg(on_ground(hub(Y))),T),
     holds_at(have(nut(X)),T)]).

axiom(terminates(do_up(nut(X),hub(Y)),have(nut(X)),T),
     [holds_at(have(wrench),T),holds_at(unfastened(hub(Y)),T),
     holds_at(neg(on_ground(hub(Y))),T),holds_at(have(nut(X)),T)]).

axiom(initiates(remove_wheel(wheel(X),hub(Y)),have(wheel(X)),T),
     [holds_at(neg(on_ground(hub(Y))),T),holds_at(on(wheel(X),hub(Y)),T),
     holds_at(unfastened(hub(Y)),T)]).

axiom(initiates(remove_wheel(wheel(X),hub(Y)),free(hub(Y)),T),
     [holds_at(neg(on_ground(hub(Y))),T),holds_at(on(wheel(X),hub(Y)),T),
     holds_at(unfastened(hub(Y)),T)]).

axiom(terminates(remove_wheel(wheel(X),hub(Y)),on(wheel(X),hub(Y)),T),
     [holds_at(neg(on_ground(hub(Y))),T),holds_at(unfastened(hub(Y)),T)]).

axiom(initiates(put_on_wheel(wheel(X),hub(Y)),on(wheel(X),hub(Y)),T),
     [holds_at(have(wheel(X)),T),holds_at(free(hub(Y)),T),
     holds_at(unfastened(hub(Y)),T),holds_at(neg(on_ground(hub(Y))),T)]).

axiom(terminates(put_on_wheel(wheel(X),hub(Y)),have(wheel(X)),T),
     [holds_at(free(hub(Y)),T),holds_at(unfastened(hub(Y)),T),
     holds_at(neg(on_ground(hub(Y))),T)]).

axiom(terminates(put_on_wheel(wheel(X),hub(Y)),free(hub(Y)),T),
     [holds_at(have(wheel(X)),T),holds_at(unfastened(hub(Y)),T),
     holds_at(neg(on_ground(hub(Y))),T)]).



/* Initial situation */

axiom(initially(neg(locked(container(boot)))),[]).

axiom(initially(intact(wheel(wheel1))),[]).

axiom(initially(in(jack,container(boot))),[]).

axiom(initially(in(pump,container(boot))),[]).

axiom(initially(in(wheel(wheel2),container(boot))),[]).

axiom(initially(in(wrench,container(boot))),[]).

axiom(initially(on(wheel(wheel1),hub(hub1))),[]).

axiom(initially(on_ground(hub(hub1))),[]).

axiom(initially(tight(nut(nuts1),hub(hub1))),[]).



/* Abduction policy */

abducible(dummy).

executable(open(X)).

executable(close(X)).

executable(fetch(X,Y)).

executable(put_away(X,Y)).

executable(loosen(X,Y)).

executable(tighten(X,Y)).

executable(jack_up(X)).

executable(jack_down(X)).

executable(undo(X,Y)).

executable(do_up(X,Y)).

executable(remove_wheel(X,Y)).

executable(put_on_wheel(X,Y)).

executable(inflate(X)).


