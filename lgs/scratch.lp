p(X) :- less_than(X, Y), p(Y).

% less_than(t1, t2).
less_than(X, Y) :- X .<>. Y, less_than(X, Z), less_than(Z, Y).

% less_than(X, Y) :- X .<>. Y.
