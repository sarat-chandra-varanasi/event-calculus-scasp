

%% REQ 102
initiates(init_retract_all_assemblies, assemblies_retracting, T) :-
             holdsAt(in_air, T),
             holdsAt(lever_up, T),
             holdsAt(all_doors_open, T),
             not holdsAt(up_and_locked, T).


%% REQ 103  (disjunctive conditions)

terminates(term_retract_all_assemblies, assemblies_retracting, T) :-
            holdsAt(in_air, T),
            holdsAt(lever_down, T).

terminates(term_retract_all_assemblies, assemblies_retracting, T) :-
            holdsAt(in_air, T),
            not holdsAt(all_doors_opened, T).

terminates(term_retract_all_assemblies, assemblies_retracting, T) :-
            holdsAt(in_air, T),
            holdsAt(up_and_locked, T).


