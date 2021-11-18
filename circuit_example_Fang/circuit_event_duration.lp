%#include 'BEC_shanahan.lp'.
#include 'bec_fang.lp'.

max(A, B, A) :- A >= B.
max(A, B, B) :- B >= A.

happens3(light_on, T_low, T4) :-
    %not holdsAt(light, T),
    happens3(close(s1), T1, T2),
    happens3(close(s2), T3, T4),
    T4 .=<. T2,
    T4 .>=. T1,
    max(T1, T3, T_low).

happens3(light_on, T_low, T2) :-
    %not holdsAt(light, T),
    happens3(close(s1), T1, T2),
    happens3(close(s2), T3, T4),
    T2 .=<. T4,
    T2 .>=. T3,
    max(T1, T3, T_low).

happens3(relay_on, T_low, T4) :-
    %not holdsAt(light, T),
    happens3(close(s1), T1, T2),
    happens3(close(s3), T3, T4),
    T4 .=<. T2,
    T4 .>=. T1,
    max(T1, T3, T_low).

happens3(relay_on, T_low, T2) :-
    %not holdsAt(light, T),
    happens3(close(s1), T1, T2),
    happens3(close(s3), T3, T4),
    T2 .=<. T4,
    T2 .>=. T3,
    max(T1, T3, T_low).

deHappens(light_on, T) :-
    happens3(relay_on, T1, T2),
    T .>=. T1,
    T .=<. T2,
    happens3(light_on, T3, T4),
    T .>=. T3,
    T .=<. T4.

initiates(light_on, light, T).

%happens3(close(s1), 4, 5).
%happens3(close(s2), 0, 8).
%happens3(close(s3), 0, 8).

happens3(close(s1), 0, 10).
happens3(close(s2), 3, 8).
happens3(close(s3), 4, 5).
?- holdsAt(light, T).
