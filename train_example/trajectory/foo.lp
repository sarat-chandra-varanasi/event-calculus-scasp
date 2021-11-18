#include '../bec_sarat.lp'.

event(a).
event(b).

fluent(fa).
fluent(fb).

initiates(a, fa, T).
terminates(b, fa, T).

initiates(b, fb, T).
terminates(a, fb, T).

happens(a, 2).
%happens(b, X) :- happens(a, X2), X .=. X2 + 2.
%happens(a, X) :- happens(b, X2), X2 .>. 2, X .=. X2 + 2.

happens(b, 4).

happens(a, 6).

happens(b, 8).


max_time(30).
