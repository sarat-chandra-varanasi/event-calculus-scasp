happens(e, 2) :- holds(f).

happens(e1, 3). 

holds(f) :- findall(E, event(E), List), hap(List).

event(e). event(e1).


hap([X|_]) :- happens(X, T).
hap([_|X]) :- hap(X).
