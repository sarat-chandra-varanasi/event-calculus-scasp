#include 'lgs_definitions.lp'.
#include 'requirements.lp'.

initiallyN(closing).
initiallyN(opening).


initiallyP(extending).
initiallyN(retracting).


initiallyN(in_air).
initiallyN(lever_up).
initiallyP(up_and_locked).


%% atomic events, part of narrative, the interesting events are triggers
happens(take_off, 3).
initiates(take_off, in_air, T).

event(take_off).
fluent(in_air).

event(lever_up).
event(lever_down).
fluent(lever_up).
fluent(lever_down).

initiates(lever_up, lever_up, T).

event(start_retract_all_assemblies).
event(stop_retract_all_assemblies).

fluent(assemblies_retracting).


happens(lever_up, 2).
happens(start_retract_all_assemblies, 4).