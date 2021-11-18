/*

   Here's a test query.

   :- abdemo([holds_at(rich,T), holds_at(have(drill),T)],R).

   Should fail. If it fails when we comment out initially(neg(at(home))),
   but succeeds with initially(neg(at(home))) then we've got a problem.
   With Versions 4.0, 1.13 and 3.5, planner finds a faulty plan.

*/

/*
axiom(initially(have(drill)),[]).

axiom(initially(at(hws)),[]).

axiom(initially(neg(at(home))),[]).

axiom(terminates(sell,have(X),T),
     [holds_at(have(X),T), holds_at(at(Y),T), buys(Y,X)]).

axiom(initiates(sell,rich,T),[]).

axiom(buys(hws,drill),[]).

abducible(dummy).

executable(sell).
*/



/*

Here's a version with no variables in bodies of clauses that don't
occur in the head. This still causes problems. Planner still finds
faulty plan.

*/

/*
axiom(initially(have(drill)),[]).

axiom(initially(at(hws)),[]).

axiom(initially(neg(at(home))),[]).

axiom(terminates(sell(X,Y),have(X),T),
     [holds_at(have(X),T), holds_at(at(Y),T), buys(Y,X)]).

axiom(initiates(sell(X,Y),rich,T),[]).

axiom(buys(hws,drill),[]).

abducible(dummy).

executable(sell(X,Y)).
*/


/*

Here's a version with no variables in bodies of clauses that
don't occur in the fluent argument in the head. But it does have
other variables in the action argument of the head. This also
causes problems. The planner is sound but not complete here, because
it fails to find any plans of the form "happens(sell(X),T0)" where
X \= drill.

*/

axiom(initially(have(drill)),[]).

axiom(terminates(sell(X),have(X),T),[]).

axiom(initiates(sell(X),rich,T),[]).

abducible(dummy).

executable(sell(X)).


/*

Conclusion: To guarantee soundness, all variables that occur in the body
of an initiates, terminates or releases clause must occur in the fluent
argument in its head. To guarantee completeness, all variables that occur
anywhere in the clause (apart from the temporal argument) must occur in the
fluent argument in the head.

*/
