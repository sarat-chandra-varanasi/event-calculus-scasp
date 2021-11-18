% #include '../bec_sarat.lp'.

event(a).
event(b).

fluent(fa).
fluent(fb).

initiates(a, fa, T) :- time(T).
terminates(b, fa, T) :- time(T).

initiates(b, fb, T) :- time(T).
terminates(a, fb, T) :- time(T).

happens(a, 2).
happens(b, X) :- time(X), happens(a, X2), X = X2 + 2.
happens(a, X) :- time(X), happens(b, X2), X2 > 2, X = X2 + 2.

time(1..10).

max_time(30).

#show happens/2.
