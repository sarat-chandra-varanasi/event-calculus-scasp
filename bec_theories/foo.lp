#include 'bec_original.lp'.


event(start).

initiates(start, start, _).

max_time(10).

happens(start, 1).

fluent(start).
% fluent(value).

trajectory(start, T, value(V), T2) :- 
                T2 .=. T + D, 
                V .=. D * 2.


