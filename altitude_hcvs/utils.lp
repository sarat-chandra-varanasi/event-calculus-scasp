happensIn(E, T1, T2) :-
         happens(E, T), 
         T1 .=<. T, T .=<. T2.

not_happensIn(E, T1, T2) :-  
        %T1 .>. 0,
        %T1 .<. T2,
        findall(T, happens(E, T), List),
        outside(List, T1, T2).

 outside([H|T], T1, T2) :- 
              H .=<. T1,  
              outside(T, T1, T2).

outside([H|T], T1, T2) :-
              H .>=. T2, 
              outside(T, T1, T2).

outside([], _, _).          

abs_diff(A, B, C) :-
         A .<. B, C .=. B - A.

abs_diff(A, B, C) :-
         A .>=. B, C .=. A - B.

holdsIn(F, T1, T2) :-
         holdsAt(F, T),
         T1 .=<. T, T .=<. T2.


not_holdsIn(F, T1, T2) :-
         findall(T, holdsAt(F, T), List),
         outside(List, T1, T2). 
