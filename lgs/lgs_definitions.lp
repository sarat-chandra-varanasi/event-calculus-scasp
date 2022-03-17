#include '../bec_theories/bec_sarat.lp'.

max_time(15).

fluent(opening). fluent(closing). fluent(retracting). fluent(extending).


fluent(all_doors_closed).  fluent(all_doors_opened). 

fluent(down_and_locked). fluent(up_and_locked).
      
event(signal_all_closed).
event(signal_neg_all_closed).
%event(signal_up_and_locked).
%event(signal_neg_up_and_locked).
%event(signal_down_and_locked).
%event(signal_neg_down_and_locked).

initiates(signal_all_closed, all_doors_closed, T).
terminates(signal_neg_all_closed, all_doors_closed, T).


initiates(signal_all_opened, all_doors_opened, T).
terminates(signal_neg_all_opened, all_doors_opened, T).


initiates(signal_down_and_locked, down_and_locked, T).
terminates(signal_neg_down_and_locked, down_and_locked, T).

initiates(signal_up_and_locked, up_and_locked, T).
terminates(signal_neg_up_and_locked, up_and_locked, T).


happens(signal_down_and_locked, T2) :-
                T1 .=<. T - 6,
                holdsAt(extending, T1),
                holdsAt(extending, T),
                not_holdsIn(T1, retracting, T),
                inf(T, T2).


happens(signal_neg_down_and_locked, T2) :-
                T1 .=<. T - 0.1,
                holdsAt(retracting, T1),
                holdsAt(retracting, T),
                not_holdsIn(extending, T1, T),
                inf(T, T2).


happens(signal_up_and_locked, T2) :-
                T1 .=<. T - 6,
                holdsAt(retracting, T1),
                holdsAt(retracting, T),
                not_holdsIn(T1, extending, T), 
                inf(T, T2).


happens(signal_neg_up_and_locked, T2) :-
                T1 .=<. T - 0.1,
                holdsAt(extending, T1),
                holdsAt(extending, T),
                not_holdsIn(retracting, T1, T),
                inf(T, T2). 



happens(signal_all_closed, T2) :-
          T1 .=<. T - 6,  
          holdsAt(closing, T1), 
          holdsAt(closing, T), 
	  not_holdsIn(opening, T1, T),
    inif(T, T2).


happens(signal_neg_all_closed, T2) :- 
			T1 .=<. T - 0.1,
			holdsAt(opening, T1),
			holdsAt(opening, T),
			not_holdsIn(closing, T1, T),
      inf(T,T2).

happens(signal_all_opened, T2) :-
          T1 .=<. T - 6,  
          holdsAt(opening, T1), 
          holdsAt(opening, T), 
    not_holdsIn(closing, T1, T),
    inf(T, T2).


happens(signal_neg_all_opened, T2) :- 
      T1 .=<. T - 0.1,
      holdsAt(closing, T1),
      holdsAt(closing, T),
      not_holdsIn(opening, T1, T),
      inf(T, T2).


holdsIn(F, T1, T2) :-
        not_stoppedIn(T1, F, T2).

not_holdsIn(F, T1, T2) :- 
        stoppedIn(T1, F, T2).

not_holdsIn(F, T1, T2) :-
       not_holdsAt(F, T1).

not_holdsIn(F, T1, T2) :-
       not_holdsAt(F, T2).

not_holdsIn(F, T1, T2) :-
       T1 .<. T, T .<. T2,
       not_holdsAt(F, T).




