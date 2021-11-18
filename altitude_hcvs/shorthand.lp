baro(V, T) :- d_holdsAt(baro(V), T).
value(V, T) :- holdsAt(value(V), T).
error(E, T) :- holdsAt(error(E), T).
d(T) :- departure_trajectory(T).