
:- use_module(library(clpr)).

happens(in,Var0, Ein, Eout) :-
     add(approach, Ein, E1),
     happens(approach,Var1,E1, E2),
     {Var0-Var1 >= 2},
     holdsAt(approaching,Var0, E2, Eout).
happens(lower,Var0, Ein, Eout) :-
     add(approach, Ein, E1),
     happens(approach,Var1, E1, E2),
     {Var0 = Var1+1},
     holdsAt(open,Var0, E2, Eout).
happens(closegate,Var0, Ein, Eout) :-
     add(lower, Ein, E1),
     happens(lower,Var1, E1, E2),
     {Var0-Var1 < 1},
     {Var0 > Var1},
     holdsAt(lowering,Var0, E2, Eout).
happens(exit,Var0, Ein, Eout) :-
     add(approach, Ein, E1),
     happens(approach,Var1, E1, E2),
     Var0-Var1 #< 5,
     Var0 #> Var1,
     holdsAt(passing,Var0, E2, Eout).
happens(raise,Var0, Ein, Eout) :-
     add(exit, Ein, E1),
     happens(exit,Var1, E1, E2),
     {Var0-Var1 < 1,
     Var0 > Var1},
     holdsAt(closed,Var0, E2, Eout).
happens(opengate,Var0, Ein, Eout) :-
     add(raise, Ein, E1),
     happens(raise,Var1, Ein, E1), 
     {Var0 > Var1+1,
     Var0 < Var1+2},
     holdsAt(rising,Var0, E1, Eout).

event(approach).
event(in).
event(lower).
event(exit).
event(raise).
event(opengate).
event(closegate).

initiates(approach,approaching,Var0).

terminates(in,approaching,Var0).
initiates(in,passing,Var0).

terminates(exit,passing,Var0).

initiates(exit,leaving,Var0).

terminates(lower,open,Var0).

initiates(lower,lowering,Var0).

terminates(closegate,lowering,Var0).

initiates(closegate,closed,Var0).

terminates(raise,closed,Var0).

initiates(raise,rising,Var0).

terminates(opengate,rising,Var0).

initiates(opengate,open,Var0).

fluent(approaching).
fluent(passing).
fluent(leaving).
fluent(rising).
fluent(open).
fluent(lowering).
fluent(closed).

initiallyP(open).

initiallyN(approaching).
initiallyN(passing).
initiallyN(leaving).
initiallyN(rising).
initiallyN(closed).
initiallyN(lowering).

happens(approach, 1, E, E).


trajectory(dummy, _, _, _).
releases(dummy, _, _).