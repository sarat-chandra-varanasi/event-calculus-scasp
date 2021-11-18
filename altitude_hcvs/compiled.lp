% QUERY:
?- reset,query(T1,T2).

% USER PREDICATES:
initiallyP(capture_alert_off).
initiallyP(departure_alert_off).
initiallyP(altitude_alert_off).

initiallyN(capture_alert_on).
initiallyN(departure_alert_on).
initiallyN(altitude_alert_on).

initiallyP(altitude_adjusting).

initiallyN(altitude_not_adjusting).
initiallyN(value(Var0)) :-
     initiallyP(value(Var1)),
     Var0 \= Var1.

initiallyP(value(32300)).

max_time(100).

precision(0.1000000000145519).

d_holdsAt(baro(Var0),Var1) :-
     Var0 #= 32200+10*Var1,
     Var1 #>= 0,
     max_time(Var2),
     Var1 #=< Var2.

happens(adjust(32300),0,0).

reset :-
     happens(reset,Var0,Var1).

default :-
     not reset.

query(Var0,Var1) :-
     happens(reset,Var0),
     Var1 #>= Var0+5,
     in_alert_zone(Var1),
     holdsAt(altitude_alert_on,Var1).

query2(Var0,Var1) :-
     happens(reset,Var0),
     Var1 #>= Var0+5,
     in_alert_zone(Var1),
     inf(Var1,Var2),
     happens(error_becomes_gt_200,Var2).

d_holdsAt(value(32300),Var0) :-
     Var0 #> 0.

happens(reset,10,10) :-
     not o_happens(reset,10,10),
     abducible(happens(reset,10,10)).

o_happens(reset,10,10) :-
     not happens(reset,10,10).

abducible(happens(reset,10,10)) :-
     not o_abducible(happens(reset,10,10)).

o_abducible(happens(reset,10,10)) :-
     not abducible(happens(reset,10,10)).

holdsAt(Var0,Var1) :-
     Var1 #> 0,
     initiallyP(Var0),
     not_clipped(0,Var0,Var1).
holdsAt(Var0,Var1) :-
     Var1 #> 0,
     initiates(Var2,Var0,Var3),
     happens(Var2,Var3,Var3),
     Var3 #< Var1,
     not_clipped(Var3,Var0,Var1).
holdsAt(Var0,Var1) :-
     Var2 #> 0,
     initiates(Var3,Var0,Var2),
     happens(Var3,Var2,Var4),
     Var2 #=< Var4,
     Var4 #< Var1,
     not_clipped(Var2,Var0,Var1).

clipped(Var0,Var1,Var2) :-
     Var0 #> 0,
     terminates(Var3,Var4),
     happens(Var3,Var4,Var5),
     Var4 #=< Var5,
     Var0 #< Var5,
     Var4 #=< Var2.

not_holdsAt(Var0,Var1) :-
     Var1 #> 0,
     initiallyN(Var0),
     not_declipped(0,Var0,Var1).
not_holdsAt(Var0,Var1) :-
     Var1 #> 0,
     terminates(Var2,Var0,Var3),
     happens(Var2,Var3,Var4),
     Var3 #=< Var4,
     Var4 #=< Var1,
     not_declipped(Var3,Var0,Var1).

declipped(Var0,Var1,Var2) :-
     Var0 #> 0,
     initiates(Var3,Var1,Var0),
     happens(Var3,Var4,Var5),
     Var4 #=< Var5,
     Var0 #< Var5,
     Var4 #< Var2.

cancelled(Var0,Var1,Var2,Var3) :-
     cancels(Var4,Var0,Var1),
     happens(Var4,Var2,Var3).

holdsAt(Var0,Var1) :-
     initiates(Var2,Var3,Var4),
     trajectory(Var3,Var4,Var0,Var5),
     happens(Var2,Var4,Var6),
     Var4 #=< Var6,
     Var6 #< Var1,
     Var1 #= Var6+Var5,
     not_clipped(Var4,Var3,Var1).

term(Var0,Var1,Var2) :-
     terminates(Var0,Var1,Var2),
     happens(Var0,Var2,Var3).

init(Var0,Var1,Var2) :-
     initiates(Var0,Var1,Var2),
     happens(Var0,Var2,Var3).

not_clipped(Var0,Var1,Var2) :-
     findall(Var3,terminates(Var3,Var1,Var4),Var5),
     out(Var0,Var2,Var5).

not_declipped(Var0,Var1,Var2) :-
     findall(Var3,initiates(Var3,Var1,Var4),Var5),
     out(Var0,Var2,Var5).

out_of(Var0,Var1,Var2) :-
     Var2 #< Var0.
out_of(Var0,Var1,Var2) :-
     Var2 #>= Var1.

out(Var0,Var1,[Var2|Var3]) :-
     happens(Var4,Var5),
     out_of(Var0,Var1,Var5),
     out(Var0,Var1,Var3).
out(Var0,Var1,[Var2|Var3]) :-
     not happens(Var4,Var5),
     out(Var0,Var1,Var3).
out(Var0,Var1,[]).

happens(Var0,Var1) :-
     happens(Var0,Var1,Var1).

error_becomes_lt(Var0,Var1) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #> Var0,
     Var4 #=< Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #< Var3+Var6,
     inf(Var5,Var1).

error_becomes_gt(Var0,Var1) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #< Var3+Var6,
     inf(Var5,Var1).

departure_trajectory(Var0) :-
     error_becomes_gt(200,Var1),
     Var0 #> Var1.

in_alert_zone(Var0) :-
     error_becomes_gt(200,Var1),
     Var0 #> Var1.
in_alert_zone(Var0) :-
     error_becomes_lt(1000,Var1),
     Var0 #> Var1.

event(error_becomes_lt_1000).
event(error_becomes_gt_200).
event(error_outside_180_1020).
event(adjust(Var0)).
event(stop_adjust).
event(reset).
event(not_5).

fluent(altitude_not_adjusting).
fluent(altitude_adjusting).
fluent(value(Var0)).
fluent(baro(Var0)).
fluent(error(Var0)).
fluent(departure_alert_on).
fluent(departure_alert_off).
fluent(capture_alert_on).
fluent(capture_alert_off).
fluent(altitude_alert_on).
fluent(altitude_alert_off).
fluent(not_5).

initiates(error_becomes_lt_1000,capture_alert_on,Var0).

terminates(error_becomes_lt_1000,capture_alert_off,Var0).

initiates(error_becomes_gt_200,departure_alert_on,Var0).

terminates(error_becomes_gt_200,departure_alert_off,Var0).

initiates(error_becomes_lt_1000,altitude_alert_on,Var0).

terminates(error_becomes_lt_1000,altitude_alert_off,Var0).

initiates(error_becomes_gt_200,altitude_alert_on,Var0).

terminates(error_becomes_gt_200,altitude_alert_off,Var0).

initiates(error_outside_180_1020,capture_alert_off,Var0).
initiates(error_outside_180_1020,departure_alert_off,Var0).
initiates(error_outside_180_1020,altitude_alert_off,Var0).

terminates(error_outside_180_1020,capture_alert_on,Var0).
terminates(error_outside_180_1020,departure_alert_on,Var0).
terminates(error_outside_180_1020,altitude_alert_on,Var0).

initiates(adjust(Var0),altitude_adjusting,Var1).

terminates(adjust(Var0),altitude_not_adjusting,Var1).
terminates(adjust(Var0),not_5,Var1).

initiates(stop_adjust,altitude_not_adjusting,Var0).

terminates(stop_adjust,altitude_adjusting,Var0).

initiates(not_5,not_5,Var0).

terminates(not_5,altitude_adjusting,Var0).

initiates(reset,altitude_adjusting,Var0).

terminates(reset,altitude_not_adjusting,Var0).
terminates(reset,departure_alert_on,Var0).
terminates(reset,capture_alert_on,Var0).
terminates(reset,altitude_alert_on,Var0).

initiates(reset,departure_alert_off,Var0).
initiates(reset,capture_alert_off,Var0).
initiates(reset,altitude_alert_off,Var0).

terminates(reset,not_5,Var0).

trajectory(altitude_adjusting,Var0,error(0),Var1) :-
     Var1 #=< 5,
     Var1 #> 0.
trajectory(not_5,Var0,error(Var1),Var2) :-
     Var2 #>= 0,
     max_time(Var3),
     Var2 #=< 5,
     Var4 #= Var0+Var2,
     Var0 #> 0,
     d_holdsAt(baro(Var5),Var2),
     d_holdsAt(value(Var6),Var2),
     abs_diff(Var5,Var6,Var1).

happens(error_becomes_lt_1000,Var0,Var1) :-
     error_becomes_lt(1000,Var0),
     Var1 #=< Var0+1.
happens(error_becomes_gt_200,Var0,Var1) :-
     error_becomes_gt(200,Var0),
     Var1 #=< Var0+1.
happens(error_outside_180_1020,Var0,Var1) :-
     error_becomes_lt(180,Var0),
     Var1 #=< Var0+1.
happens(error_outside_180_1020,Var0,Var1) :-
     error_becomes_gt(1020,Var0),
     Var1 #=< Var0+1.
happens(stop_adjust,Var0,Var0) :-
     Var1 #= Var2-5,
     Var2-5 #> 0,
     not_happensIn(adjust(Var3),Var1,Var2),
     inf(Var2,Var0).
happens(not_5,Var0,Var0) :-
     Var1 #= Var0-5,
     Var0-5 #>= 0,
     happens(adjust(Var2),Var1,Var1),
     not_happensIn(adjust(Var3),Var1,Var0).
happens(not_5,Var0,Var0) :-
     Var1 #= Var0-5,
     Var0-5 #>= 0,
     happens(reset,Var1,Var1),
     not_happensIn(adjust(Var2),Var1,Var0),
     not_happensIn(reset,Var1,Var0).

happensIn(Var0,Var1,Var2) :-
     happens(Var0,Var3),
     Var1 #=< Var3,
     Var3 #=< Var2.

not_happensIn(Var0,Var1,Var2) :-
     findall(Var3,happens(Var0,Var3),Var4),
     outside(Var4,Var1,Var2).

outside([Var0|Var1],Var2,Var3) :-
     Var0 #=< Var2,
     outside(Var1,Var2,Var3).
outside([Var0|Var1],Var2,Var3) :-
     Var0 #>= Var3,
     outside(Var1,Var2,Var3).
outside([],Var0,Var1).

abs_diff(Var0,Var1,Var2) :-
     Var0 #< Var1,
     Var2 #= Var1-Var0.
abs_diff(Var0,Var1,Var2) :-
     Var0 #>= Var1,
     Var2 #= Var0-Var1.

holdsIn(Var0,Var1,Var2) :-
     holdsAt(Var0,Var3),
     Var1 #=< Var3,
     Var3 #=< Var2.

not_holdsIn(Var0,Var1,Var2) :-
     findall(Var3,holdsAt(Var0,Var3),Var4),
     outside(Var4,Var1,Var2).

baro(Var0,Var1) :-
     d_holdsAt(baro(Var0),Var1).

value(Var0,Var1) :-
     holdsAt(value(Var0),Var1).

error(Var0,Var1) :-
     holdsAt(error(Var0),Var1).

d(Var0) :-
     departure_trajectory(Var0).

global_constraints :-
     global_constraint.


% DUAL RULES:
not o_d_d_1(Var0) :-
     not departure_trajectory(Var0).

not d(Var0) :-
     not o_d_d_1(Var0).

not o_error_1(Var0,Var1) :-
     not holdsAt(error(Var0),Var1).

not error(Var0,Var1) :-
     not o_error_1(Var0,Var1).

not o_value_1(Var0,Var1) :-
     not holdsAt(value(Var0),Var1).

not value(Var0,Var1) :-
     not o_value_1(Var0,Var1).

not o_baro_1(Var0,Var1) :-
     not d_holdsAt(baro(Var0),Var1).

not baro(Var0,Var1) :-
     not o_baro_1(Var0,Var1).

not o_not_holdsIn_1(Var0,Var1,Var2,Var3,Var4) :-
     not findall(Var3,holdsAt(Var0,Var3),Var4).
not o_not_holdsIn_1(Var0,Var1,Var2,Var3,Var4) :-
     findall(Var3,holdsAt(Var0,Var3),Var4),
     not outside(Var4,Var1,Var2).

not o_not_holdsIn_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,not o_not_holdsIn_1(Var0,Var1,Var2,Var3,Var4))).

not not_holdsIn(Var0,Var1,Var2) :-
     not o_not_holdsIn_1(Var0,Var1,Var2).

not o_holdsIn_1(Var0,Var1,Var2,Var3) :-
     not holdsAt(Var0,Var3).
not o_holdsIn_1(Var0,Var1,Var2,Var3) :-
     holdsAt(Var0,Var3),
     Var1 #> Var3.
not o_holdsIn_1(Var0,Var1,Var2,Var3) :-
     holdsAt(Var0,Var3),
     Var1 #=< Var3,
     Var3 #> Var2.

not o_holdsIn_1(Var0,Var1,Var2) :-
     forall(Var3,not o_holdsIn_1(Var0,Var1,Var2,Var3)).

not holdsIn(Var0,Var1,Var2) :-
     not o_holdsIn_1(Var0,Var1,Var2).

not o_outside_1(Var0,Var1,Var2,Var3,Var4) :-
     Var0 \= [Var3|Var4].
not o_outside_1(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = [Var3|Var4],
     Var3 #> Var1.
not o_outside_1(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = [Var3|Var4],
     Var3 #=< Var1,
     not outside(Var4,Var1,Var2).

not o_outside_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,not o_outside_1(Var0,Var1,Var2,Var3,Var4))).

not o_outside_2(Var0,Var1,Var2,Var3,Var4) :-
     Var0 \= [Var3|Var4].
not o_outside_2(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = [Var3|Var4],
     Var3 #< Var2.
not o_outside_2(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = [Var3|Var4],
     Var3 #>= Var2,
     not outside(Var4,Var1,Var2).

not o_outside_2(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,not o_outside_2(Var0,Var1,Var2,Var3,Var4))).

not o_outside_3(Var0,Var1,Var2) :-
     Var0 \= [].

not outside(Var0,Var1,Var2) :-
     not o_outside_1(Var0,Var1,Var2),
     not o_outside_2(Var0,Var1,Var2),
     not o_outside_3(Var0,Var1,Var2).

not o_happensIn_1(Var0,Var1,Var2,Var3) :-
     not happens(Var0,Var3).
not o_happensIn_1(Var0,Var1,Var2,Var3) :-
     happens(Var0,Var3),
     Var1 #> Var3.
not o_happensIn_1(Var0,Var1,Var2,Var3) :-
     happens(Var0,Var3),
     Var1 #=< Var3,
     Var3 #> Var2.

not o_happensIn_1(Var0,Var1,Var2) :-
     forall(Var3,not o_happensIn_1(Var0,Var1,Var2,Var3)).

not happensIn(Var0,Var1,Var2) :-
     not o_happensIn_1(Var0,Var1,Var2).

not o_not_happensIn_1(Var0,Var1,Var2,Var3,Var4) :-
     not findall(Var3,happens(Var0,Var3),Var4).
not o_not_happensIn_1(Var0,Var1,Var2,Var3,Var4) :-
     findall(Var3,happens(Var0,Var3),Var4),
     not outside(Var4,Var1,Var2).

not o_not_happensIn_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,not o_not_happensIn_1(Var0,Var1,Var2,Var3,Var4))).

not not_happensIn(Var0,Var1,Var2) :-
     not o_not_happensIn_1(Var0,Var1,Var2).

not o_abs_diff_1(Var0,Var1,Var2) :-
     Var0 #>= Var1.
not o_abs_diff_1(Var0,Var1,Var2) :-
     Var0 #< Var1,
     Var2 #<> Var1-Var0.

not o_abs_diff_2(Var0,Var1,Var2) :-
     Var0 #< Var1.
not o_abs_diff_2(Var0,Var1,Var2) :-
     Var0 #>= Var1,
     Var2 #<> Var0-Var1.

not abs_diff(Var0,Var1,Var2) :-
     not o_abs_diff_1(Var0,Var1,Var2),
     not o_abs_diff_2(Var0,Var1,Var2).

not o_fluent_1(Var0) :-
     Var0 \= altitude_not_adjusting.

not o_fluent_2(Var0) :-
     Var0 \= altitude_adjusting.

not o_fluent_3(Var0,Var1) :-
     Var0 \= value(Var1).

not o_fluent_3(Var0) :-
     forall(Var1,not o_fluent_3(Var0,Var1)).

not o_fluent_4(Var0,Var1) :-
     Var0 \= baro(Var1).

not o_fluent_4(Var0) :-
     forall(Var1,not o_fluent_4(Var0,Var1)).

not o_fluent_5(Var0,Var1) :-
     Var0 \= error(Var1).

not o_fluent_5(Var0) :-
     forall(Var1,not o_fluent_5(Var0,Var1)).

not o_fluent_6(Var0) :-
     Var0 \= departure_alert_on.

not o_fluent_7(Var0) :-
     Var0 \= departure_alert_off.

not o_fluent_8(Var0) :-
     Var0 \= capture_alert_on.

not o_fluent_9(Var0) :-
     Var0 \= capture_alert_off.

not o_fluent_10(Var0) :-
     Var0 \= altitude_alert_on.

not o_fluent_11(Var0) :-
     Var0 \= altitude_alert_off.

not o_fluent_12(Var0) :-
     Var0 \= not_5.

not fluent(Var0) :-
     not o_fluent_1(Var0),
     not o_fluent_2(Var0),
     not o_fluent_3(Var0),
     not o_fluent_4(Var0),
     not o_fluent_5(Var0),
     not o_fluent_6(Var0),
     not o_fluent_7(Var0),
     not o_fluent_8(Var0),
     not o_fluent_9(Var0),
     not o_fluent_10(Var0),
     not o_fluent_11(Var0),
     not o_fluent_12(Var0).

not o_event_1(Var0) :-
     Var0 \= error_becomes_lt_1000.

not o_event_2(Var0) :-
     Var0 \= error_becomes_gt_200.

not o_event_3(Var0) :-
     Var0 \= error_outside_180_1020.

not o_event_4(Var0,Var1) :-
     Var0 \= adjust(Var1).

not o_event_4(Var0) :-
     forall(Var1,not o_event_4(Var0,Var1)).

not o_event_5(Var0) :-
     Var0 \= stop_adjust.

not o_event_6(Var0) :-
     Var0 \= reset.

not o_event_7(Var0) :-
     Var0 \= not_5.

not event(Var0) :-
     not o_event_1(Var0),
     not o_event_2(Var0),
     not o_event_3(Var0),
     not o_event_4(Var0),
     not o_event_5(Var0),
     not o_event_6(Var0),
     not o_event_7(Var0).

not o_departure_trajectory_1(Var0,Var1) :-
     not error_becomes_gt(200,Var1).
not o_departure_trajectory_1(Var0,Var1) :-
     error_becomes_gt(200,Var1),
     Var0 #=< Var1.

not o_departure_trajectory_1(Var0) :-
     forall(Var1,not o_departure_trajectory_1(Var0,Var1)).

not departure_trajectory(Var0) :-
     not o_departure_trajectory_1(Var0).

not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     not holdsAt(error(Var2),Var3).
not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     not holdsAt(error(Var4),Var5).
not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #>= Var0.
not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #< Var0.
not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     not precision(Var6).
not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     precision(Var6),
     Var5 #=< Var3.
not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #>= Var3+Var6.
not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #< Var3+Var6,
     not inf(Var5,Var1).

not o_error_becomes_gt_1(Var0,Var1) :-
     forall(Var2,forall(Var3,forall(Var4,forall(Var5,forall(Var6,not o_error_becomes_gt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6)))))).

not error_becomes_gt(Var0,Var1) :-
     not o_error_becomes_gt_1(Var0,Var1).

not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     not holdsAt(error(Var2),Var3).
not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     not holdsAt(error(Var4),Var5).
not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #=< Var0.
not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #> Var0,
     Var4 #> Var0.
not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #> Var0,
     Var4 #=< Var0,
     not precision(Var6).
not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #> Var0,
     Var4 #=< Var0,
     precision(Var6),
     Var5 #=< Var3.
not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #> Var0,
     Var4 #=< Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #>= Var3+Var6.
not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #> Var0,
     Var4 #=< Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #< Var3+Var6,
     not inf(Var5,Var1).

not o_error_becomes_lt_1(Var0,Var1) :-
     forall(Var2,forall(Var3,forall(Var4,forall(Var5,forall(Var6,not o_error_becomes_lt_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6)))))).

not error_becomes_lt(Var0,Var1) :-
     not o_error_becomes_lt_1(Var0,Var1).

not o_out_of_1(Var0,Var1,Var2) :-
     Var2 #>= Var0.

not o_out_of_2(Var0,Var1,Var2) :-
     Var2 #< Var1.

not out_of(Var0,Var1,Var2) :-
     not o_out_of_1(Var0,Var1,Var2),
     not o_out_of_2(Var0,Var1,Var2).

not o_out_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 \= [Var3|Var4].
not o_out_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 = [Var3|Var4],
     not happens(Var5,Var6).
not o_out_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 = [Var3|Var4],
     happens(Var5,Var6),
     not out_of(Var0,Var1,Var6).
not o_out_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 = [Var3|Var4],
     happens(Var5,Var6),
     out_of(Var0,Var1,Var6),
     not out(Var0,Var1,Var4).

not o_out_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,forall(Var6,not o_out_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6))))).

not o_out_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 \= [Var3|Var4].
not o_out_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 = [Var3|Var4],
     happens(Var5,Var6).
not o_out_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 = [Var3|Var4],
     not happens(Var5,Var6),
     not out(Var0,Var1,Var4).

not o_out_2(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,forall(Var6,not o_out_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6))))).

not o_out_3(Var0,Var1,Var2) :-
     Var2 \= [].

not out(Var0,Var1,Var2) :-
     not o_out_1(Var0,Var1,Var2),
     not o_out_2(Var0,Var1,Var2),
     not o_out_3(Var0,Var1,Var2).

not o_init_1(Var0,Var1,Var2,Var3) :-
     not initiates(Var0,Var1,Var2).
not o_init_1(Var0,Var1,Var2,Var3) :-
     initiates(Var0,Var1,Var2),
     not happens(Var0,Var2,Var3).

not o_init_1(Var0,Var1,Var2) :-
     forall(Var3,not o_init_1(Var0,Var1,Var2,Var3)).

not init(Var0,Var1,Var2) :-
     not o_init_1(Var0,Var1,Var2).

not o_term_1(Var0,Var1,Var2,Var3) :-
     not terminates(Var0,Var1,Var2).
not o_term_1(Var0,Var1,Var2,Var3) :-
     terminates(Var0,Var1,Var2),
     not happens(Var0,Var2,Var3).

not o_term_1(Var0,Var1,Var2) :-
     forall(Var3,not o_term_1(Var0,Var1,Var2,Var3)).

not term(Var0,Var1,Var2) :-
     not o_term_1(Var0,Var1,Var2).

not o_trajectory_1(Var0,Var1,Var2,Var3) :-
     Var0 \= altitude_adjusting.
not o_trajectory_1(Var0,Var1,Var2,Var3) :-
     Var0 = altitude_adjusting,
     Var2 \= error(0).
not o_trajectory_1(Var0,Var1,Var2,Var3) :-
     Var0 = altitude_adjusting,
     Var2 = error(0),
     Var3 #> 5.
not o_trajectory_1(Var0,Var1,Var2,Var3) :-
     Var0 = altitude_adjusting,
     Var2 = error(0),
     Var3 #=< 5,
     Var3 #=< 0.

not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 \= not_5.
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 \= error(Var4).
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 = error(Var4),
     Var3 #< 0.
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 = error(Var4),
     Var3 #>= 0,
     not max_time(Var5).
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 = error(Var4),
     Var3 #>= 0,
     max_time(Var5),
     Var3 #> 5.
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 = error(Var4),
     Var3 #>= 0,
     max_time(Var5),
     Var3 #=< 5,
     Var6 #<> Var1+Var3.
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 = error(Var4),
     Var3 #>= 0,
     max_time(Var5),
     Var3 #=< 5,
     Var6 #= Var1+Var3,
     Var1 #=< 0.
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 = error(Var4),
     Var3 #>= 0,
     max_time(Var5),
     Var3 #=< 5,
     Var6 #= Var1+Var3,
     Var1 #> 0,
     not d_holdsAt(baro(Var7),Var3).
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 = error(Var4),
     Var3 #>= 0,
     max_time(Var5),
     Var3 #=< 5,
     Var6 #= Var1+Var3,
     Var1 #> 0,
     d_holdsAt(baro(Var7),Var3),
     not d_holdsAt(value(Var8),Var3).
not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8) :-
     Var0 = not_5,
     Var2 = error(Var4),
     Var3 #>= 0,
     max_time(Var5),
     Var3 #=< 5,
     Var6 #= Var1+Var3,
     Var1 #> 0,
     d_holdsAt(baro(Var7),Var3),
     d_holdsAt(value(Var8),Var3),
     not abs_diff(Var7,Var8,Var4).

not o_trajectory_2(Var0,Var1,Var2,Var3) :-
     forall(Var4,forall(Var5,forall(Var6,forall(Var7,forall(Var8,not o_trajectory_2(Var0,Var1,Var2,Var3,Var4,Var5,Var6,Var7,Var8)))))).

not trajectory(Var0,Var1,Var2,Var3) :-
     not o_trajectory_1(Var0,Var1,Var2,Var3),
     not o_trajectory_2(Var0,Var1,Var2,Var3).

not cancels(Var0,Var1,Var2).

not o_cancelled_1(Var0,Var1,Var2,Var3,Var4) :-
     not cancels(Var4,Var0,Var1).
not o_cancelled_1(Var0,Var1,Var2,Var3,Var4) :-
     cancels(Var4,Var0,Var1),
     not happens(Var4,Var2,Var3).

not o_cancelled_1(Var0,Var1,Var2,Var3) :-
     forall(Var4,not o_cancelled_1(Var0,Var1,Var2,Var3,Var4)).

not cancelled(Var0,Var1,Var2,Var3) :-
     not o_cancelled_1(Var0,Var1,Var2,Var3).

not o_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #=< 0.
not o_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     not initiates(Var3,Var1,Var0).
not o_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     initiates(Var3,Var1,Var0),
     not happens(Var3,Var4,Var5).
not o_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     initiates(Var3,Var1,Var0),
     happens(Var3,Var4,Var5),
     Var4 #> Var5.
not o_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     initiates(Var3,Var1,Var0),
     happens(Var3,Var4,Var5),
     Var4 #=< Var5,
     Var0 #>= Var5.
not o_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     initiates(Var3,Var1,Var0),
     happens(Var3,Var4,Var5),
     Var4 #=< Var5,
     Var0 #< Var5,
     Var4 #>= Var2.

not o_declipped_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,not o_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5)))).

not declipped(Var0,Var1,Var2) :-
     not o_declipped_1(Var0,Var1,Var2).

not o_terminates_1(Var0,Var1,Var2) :-
     Var0 \= error_becomes_lt_1000.
not o_terminates_1(Var0,Var1,Var2) :-
     Var0 = error_becomes_lt_1000,
     Var1 \= capture_alert_off.

not o_terminates_2(Var0,Var1,Var2) :-
     Var0 \= error_becomes_gt_200.
not o_terminates_2(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     Var1 \= departure_alert_off.

not o_terminates_3(Var0,Var1,Var2) :-
     Var0 \= error_becomes_lt_1000.
not o_terminates_3(Var0,Var1,Var2) :-
     Var0 = error_becomes_lt_1000,
     Var1 \= altitude_alert_off.

not o_terminates_4(Var0,Var1,Var2) :-
     Var0 \= error_becomes_gt_200.
not o_terminates_4(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     Var1 \= altitude_alert_off.

not o_terminates_5(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o_terminates_5(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     Var1 \= capture_alert_on.

not o_terminates_6(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o_terminates_6(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     Var1 \= departure_alert_on.

not o_terminates_7(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o_terminates_7(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     Var1 \= altitude_alert_on.

not o_terminates_8(Var0,Var1,Var2,Var3) :-
     Var1 \= altitude_not_adjusting.
not o_terminates_8(Var0,Var1,Var2,Var3) :-
     Var1 = altitude_not_adjusting,
     Var0 \= adjust(Var3).

not o_terminates_8(Var0,Var1,Var2) :-
     forall(Var3,not o_terminates_8(Var0,Var1,Var2,Var3)).

not o_terminates_9(Var0,Var1,Var2,Var3) :-
     Var1 \= not_5.
not o_terminates_9(Var0,Var1,Var2,Var3) :-
     Var1 = not_5,
     Var0 \= adjust(Var3).

not o_terminates_9(Var0,Var1,Var2) :-
     forall(Var3,not o_terminates_9(Var0,Var1,Var2,Var3)).

not o_terminates_10(Var0,Var1,Var2) :-
     Var0 \= stop_adjust.
not o_terminates_10(Var0,Var1,Var2) :-
     Var0 = stop_adjust,
     Var1 \= altitude_adjusting.

not o_terminates_11(Var0,Var1,Var2) :-
     Var0 \= not_5.
not o_terminates_11(Var0,Var1,Var2) :-
     Var0 = not_5,
     Var1 \= altitude_adjusting.

not o_terminates_12(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_terminates_12(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= altitude_not_adjusting.

not o_terminates_13(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_terminates_13(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= departure_alert_on.

not o_terminates_14(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_terminates_14(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= capture_alert_on.

not o_terminates_15(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_terminates_15(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= altitude_alert_on.

not o_terminates_16(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_terminates_16(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= not_5.

not terminates(Var0,Var1,Var2) :-
     not o_terminates_1(Var0,Var1,Var2),
     not o_terminates_2(Var0,Var1,Var2),
     not o_terminates_3(Var0,Var1,Var2),
     not o_terminates_4(Var0,Var1,Var2),
     not o_terminates_5(Var0,Var1,Var2),
     not o_terminates_6(Var0,Var1,Var2),
     not o_terminates_7(Var0,Var1,Var2),
     not o_terminates_8(Var0,Var1,Var2),
     not o_terminates_9(Var0,Var1,Var2),
     not o_terminates_10(Var0,Var1,Var2),
     not o_terminates_11(Var0,Var1,Var2),
     not o_terminates_12(Var0,Var1,Var2),
     not o_terminates_13(Var0,Var1,Var2),
     not o_terminates_14(Var0,Var1,Var2),
     not o_terminates_15(Var0,Var1,Var2),
     not o_terminates_16(Var0,Var1,Var2).

not o_not_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     not findall(Var3,initiates(Var3,Var1,Var4),Var5).
not o_not_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     findall(Var3,initiates(Var3,Var1,Var4),Var5),
     not out(Var0,Var2,Var5).

not o_not_declipped_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,not o_not_declipped_1(Var0,Var1,Var2,Var3,Var4,Var5)))).

not not_declipped(Var0,Var1,Var2) :-
     not o_not_declipped_1(Var0,Var1,Var2).

not o_not_holdsAt_1(Var0,Var1) :-
     Var1 #=< 0.
not o_not_holdsAt_1(Var0,Var1) :-
     Var1 #> 0,
     not initiallyN(Var0).
not o_not_holdsAt_1(Var0,Var1) :-
     Var1 #> 0,
     initiallyN(Var0),
     not not_declipped(0,Var0,Var1).

not o_not_holdsAt_2(Var0,Var1,Var2,Var3,Var4) :-
     Var1 #=< 0.
not o_not_holdsAt_2(Var0,Var1,Var2,Var3,Var4) :-
     Var1 #> 0,
     not terminates(Var2,Var0,Var3).
not o_not_holdsAt_2(Var0,Var1,Var2,Var3,Var4) :-
     Var1 #> 0,
     terminates(Var2,Var0,Var3),
     not happens(Var2,Var3,Var4).
not o_not_holdsAt_2(Var0,Var1,Var2,Var3,Var4) :-
     Var1 #> 0,
     terminates(Var2,Var0,Var3),
     happens(Var2,Var3,Var4),
     Var3 #> Var4.
not o_not_holdsAt_2(Var0,Var1,Var2,Var3,Var4) :-
     Var1 #> 0,
     terminates(Var2,Var0,Var3),
     happens(Var2,Var3,Var4),
     Var3 #=< Var4,
     Var4 #> Var1.
not o_not_holdsAt_2(Var0,Var1,Var2,Var3,Var4) :-
     Var1 #> 0,
     terminates(Var2,Var0,Var3),
     happens(Var2,Var3,Var4),
     Var3 #=< Var4,
     Var4 #=< Var1,
     not not_declipped(Var3,Var0,Var1).

not o_not_holdsAt_2(Var0,Var1) :-
     forall(Var2,forall(Var3,forall(Var4,not o_not_holdsAt_2(Var0,Var1,Var2,Var3,Var4)))).

not not_holdsAt(Var0,Var1) :-
     not o_not_holdsAt_1(Var0,Var1),
     not o_not_holdsAt_2(Var0,Var1).

not terminates(Var0,Var1).

not o_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #=< 0.
not o_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     not terminates(Var3,Var4).
not o_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     terminates(Var3,Var4),
     not happens(Var3,Var4,Var5).
not o_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     terminates(Var3,Var4),
     happens(Var3,Var4,Var5),
     Var4 #> Var5.
not o_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     terminates(Var3,Var4),
     happens(Var3,Var4,Var5),
     Var4 #=< Var5,
     Var0 #>= Var5.
not o_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 #> 0,
     terminates(Var3,Var4),
     happens(Var3,Var4,Var5),
     Var4 #=< Var5,
     Var0 #< Var5,
     Var4 #> Var2.

not o_clipped_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,not o_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5)))).

not clipped(Var0,Var1,Var2) :-
     not o_clipped_1(Var0,Var1,Var2).

not o_initiates_1(Var0,Var1,Var2) :-
     Var0 \= error_becomes_lt_1000.
not o_initiates_1(Var0,Var1,Var2) :-
     Var0 = error_becomes_lt_1000,
     Var1 \= capture_alert_on.

not o_initiates_2(Var0,Var1,Var2) :-
     Var0 \= error_becomes_gt_200.
not o_initiates_2(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     Var1 \= departure_alert_on.

not o_initiates_3(Var0,Var1,Var2) :-
     Var0 \= error_becomes_lt_1000.
not o_initiates_3(Var0,Var1,Var2) :-
     Var0 = error_becomes_lt_1000,
     Var1 \= altitude_alert_on.

not o_initiates_4(Var0,Var1,Var2) :-
     Var0 \= error_becomes_gt_200.
not o_initiates_4(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     Var1 \= altitude_alert_on.

not o_initiates_5(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o_initiates_5(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     Var1 \= capture_alert_off.

not o_initiates_6(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o_initiates_6(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     Var1 \= departure_alert_off.

not o_initiates_7(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o_initiates_7(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     Var1 \= altitude_alert_off.

not o_initiates_8(Var0,Var1,Var2,Var3) :-
     Var1 \= altitude_adjusting.
not o_initiates_8(Var0,Var1,Var2,Var3) :-
     Var1 = altitude_adjusting,
     Var0 \= adjust(Var3).

not o_initiates_8(Var0,Var1,Var2) :-
     forall(Var3,not o_initiates_8(Var0,Var1,Var2,Var3)).

not o_initiates_9(Var0,Var1,Var2) :-
     Var0 \= stop_adjust.
not o_initiates_9(Var0,Var1,Var2) :-
     Var0 = stop_adjust,
     Var1 \= altitude_not_adjusting.

not o_initiates_10(Var0,Var1,Var2) :-
     Var0 \= not_5.
not o_initiates_10(Var0,Var1,Var2) :-
     Var0 = not_5,
     Var1 \= not_5.

not o_initiates_11(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_initiates_11(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= altitude_adjusting.

not o_initiates_12(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_initiates_12(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= departure_alert_off.

not o_initiates_13(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_initiates_13(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= capture_alert_off.

not o_initiates_14(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_initiates_14(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= altitude_alert_off.

not initiates(Var0,Var1,Var2) :-
     not o_initiates_1(Var0,Var1,Var2),
     not o_initiates_2(Var0,Var1,Var2),
     not o_initiates_3(Var0,Var1,Var2),
     not o_initiates_4(Var0,Var1,Var2),
     not o_initiates_5(Var0,Var1,Var2),
     not o_initiates_6(Var0,Var1,Var2),
     not o_initiates_7(Var0,Var1,Var2),
     not o_initiates_8(Var0,Var1,Var2),
     not o_initiates_9(Var0,Var1,Var2),
     not o_initiates_10(Var0,Var1,Var2),
     not o_initiates_11(Var0,Var1,Var2),
     not o_initiates_12(Var0,Var1,Var2),
     not o_initiates_13(Var0,Var1,Var2),
     not o_initiates_14(Var0,Var1,Var2).

not o_not_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     not findall(Var3,terminates(Var3,Var1,Var4),Var5).
not o_not_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     findall(Var3,terminates(Var3,Var1,Var4),Var5),
     not out(Var0,Var2,Var5).

not o_not_clipped_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,not o_not_clipped_1(Var0,Var1,Var2,Var3,Var4,Var5)))).

not not_clipped(Var0,Var1,Var2) :-
     not o_not_clipped_1(Var0,Var1,Var2).

not o__abducible_1(Var0) :-
     Var0 \= happens(reset,10,10).
not o__abducible_1(Var0) :-
     Var0 = happens(reset,10,10),
     abducible(happens(reset,10,10)).

not o_abducible(Var0) :-
     not o__abducible_1(Var0).

not o_abducible_1(Var0) :-
     Var0 \= happens(reset,10,10).
not o_abducible_1(Var0) :-
     Var0 = happens(reset,10,10),
     o_abducible(happens(reset,10,10)).

not abducible(Var0) :-
     not o_abducible_1(Var0).

not o__happens_1(Var0,Var1,Var2) :-
     Var0 \= reset.
not o__happens_1(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= 10.
not o__happens_1(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 = 10,
     Var2 \= 10.
not o__happens_1(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 = 10,
     Var2 = 10,
     happens(reset,10,10).

not o_happens(Var0,Var1,Var2) :-
     not o__happens_1(Var0,Var1,Var2).

not inf(Var0,Var1).

not o_query2_1(Var0,Var1,Var2) :-
     not happens(reset,Var0).
not o_query2_1(Var0,Var1,Var2) :-
     happens(reset,Var0),
     Var1 #< Var0+5.
not o_query2_1(Var0,Var1,Var2) :-
     happens(reset,Var0),
     Var1 #>= Var0+5,
     not in_alert_zone(Var1).
not o_query2_1(Var0,Var1,Var2) :-
     happens(reset,Var0),
     Var1 #>= Var0+5,
     in_alert_zone(Var1),
     not inf(Var1,Var2).
not o_query2_1(Var0,Var1,Var2) :-
     happens(reset,Var0),
     Var1 #>= Var0+5,
     in_alert_zone(Var1),
     inf(Var1,Var2),
     not happens(error_becomes_gt_200,Var2).

not o_query2_1(Var0,Var1) :-
     forall(Var2,not o_query2_1(Var0,Var1,Var2)).

not query2(Var0,Var1) :-
     not o_query2_1(Var0,Var1).

not o_holdsAt_1(Var0,Var1) :-
     Var1 #=< 0.
not o_holdsAt_1(Var0,Var1) :-
     Var1 #> 0,
     not initiallyP(Var0).
not o_holdsAt_1(Var0,Var1) :-
     Var1 #> 0,
     initiallyP(Var0),
     not not_clipped(0,Var0,Var1).

not o_holdsAt_2(Var0,Var1,Var2,Var3) :-
     Var1 #=< 0.
not o_holdsAt_2(Var0,Var1,Var2,Var3) :-
     Var1 #> 0,
     not initiates(Var2,Var0,Var3).
not o_holdsAt_2(Var0,Var1,Var2,Var3) :-
     Var1 #> 0,
     initiates(Var2,Var0,Var3),
     not happens(Var2,Var3,Var3).
not o_holdsAt_2(Var0,Var1,Var2,Var3) :-
     Var1 #> 0,
     initiates(Var2,Var0,Var3),
     happens(Var2,Var3,Var3),
     Var3 #>= Var1.
not o_holdsAt_2(Var0,Var1,Var2,Var3) :-
     Var1 #> 0,
     initiates(Var2,Var0,Var3),
     happens(Var2,Var3,Var3),
     Var3 #< Var1,
     not not_clipped(Var3,Var0,Var1).

not o_holdsAt_2(Var0,Var1) :-
     forall(Var2,forall(Var3,not o_holdsAt_2(Var0,Var1,Var2,Var3))).

not o_holdsAt_3(Var0,Var1,Var2,Var3,Var4) :-
     Var2 #=< 0.
not o_holdsAt_3(Var0,Var1,Var2,Var3,Var4) :-
     Var2 #> 0,
     not initiates(Var3,Var0,Var2).
not o_holdsAt_3(Var0,Var1,Var2,Var3,Var4) :-
     Var2 #> 0,
     initiates(Var3,Var0,Var2),
     not happens(Var3,Var2,Var4).
not o_holdsAt_3(Var0,Var1,Var2,Var3,Var4) :-
     Var2 #> 0,
     initiates(Var3,Var0,Var2),
     happens(Var3,Var2,Var4),
     Var2 #> Var4.
not o_holdsAt_3(Var0,Var1,Var2,Var3,Var4) :-
     Var2 #> 0,
     initiates(Var3,Var0,Var2),
     happens(Var3,Var2,Var4),
     Var2 #=< Var4,
     Var4 #>= Var1.
not o_holdsAt_3(Var0,Var1,Var2,Var3,Var4) :-
     Var2 #> 0,
     initiates(Var3,Var0,Var2),
     happens(Var3,Var2,Var4),
     Var2 #=< Var4,
     Var4 #< Var1,
     not not_clipped(Var2,Var0,Var1).

not o_holdsAt_3(Var0,Var1) :-
     forall(Var2,forall(Var3,forall(Var4,not o_holdsAt_3(Var0,Var1,Var2,Var3,Var4)))).

not o_holdsAt_4(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     not initiates(Var2,Var3,Var4).
not o_holdsAt_4(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     initiates(Var2,Var3,Var4),
     not trajectory(Var3,Var4,Var0,Var5).
not o_holdsAt_4(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     initiates(Var2,Var3,Var4),
     trajectory(Var3,Var4,Var0,Var5),
     not happens(Var2,Var4,Var6).
not o_holdsAt_4(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     initiates(Var2,Var3,Var4),
     trajectory(Var3,Var4,Var0,Var5),
     happens(Var2,Var4,Var6),
     Var4 #> Var6.
not o_holdsAt_4(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     initiates(Var2,Var3,Var4),
     trajectory(Var3,Var4,Var0,Var5),
     happens(Var2,Var4,Var6),
     Var4 #=< Var6,
     Var6 #>= Var1.
not o_holdsAt_4(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     initiates(Var2,Var3,Var4),
     trajectory(Var3,Var4,Var0,Var5),
     happens(Var2,Var4,Var6),
     Var4 #=< Var6,
     Var6 #< Var1,
     Var1 #<> Var6+Var5.
not o_holdsAt_4(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     initiates(Var2,Var3,Var4),
     trajectory(Var3,Var4,Var0,Var5),
     happens(Var2,Var4,Var6),
     Var4 #=< Var6,
     Var6 #< Var1,
     Var1 #= Var6+Var5,
     not not_clipped(Var4,Var3,Var1).

not o_holdsAt_4(Var0,Var1) :-
     forall(Var2,forall(Var3,forall(Var4,forall(Var5,forall(Var6,not o_holdsAt_4(Var0,Var1,Var2,Var3,Var4,Var5,Var6)))))).

not holdsAt(Var0,Var1) :-
     not o_holdsAt_1(Var0,Var1),
     not o_holdsAt_2(Var0,Var1),
     not o_holdsAt_3(Var0,Var1),
     not o_holdsAt_4(Var0,Var1).

not o_in_alert_zone_1(Var0,Var1) :-
     not error_becomes_gt(200,Var1).
not o_in_alert_zone_1(Var0,Var1) :-
     error_becomes_gt(200,Var1),
     Var0 #=< Var1.

not o_in_alert_zone_1(Var0) :-
     forall(Var1,not o_in_alert_zone_1(Var0,Var1)).

not o_in_alert_zone_2(Var0,Var1) :-
     not error_becomes_lt(1000,Var1).
not o_in_alert_zone_2(Var0,Var1) :-
     error_becomes_lt(1000,Var1),
     Var0 #=< Var1.

not o_in_alert_zone_2(Var0) :-
     forall(Var1,not o_in_alert_zone_2(Var0,Var1)).

not in_alert_zone(Var0) :-
     not o_in_alert_zone_1(Var0),
     not o_in_alert_zone_2(Var0).

not o_happens_1(Var0,Var1) :-
     not happens(Var0,Var1,Var1).

not happens(Var0,Var1) :-
     not o_happens_1(Var0,Var1).

not o_query_1(Var0,Var1) :-
     not happens(reset,Var0).
not o_query_1(Var0,Var1) :-
     happens(reset,Var0),
     Var1 #< Var0+5.
not o_query_1(Var0,Var1) :-
     happens(reset,Var0),
     Var1 #>= Var0+5,
     not in_alert_zone(Var1).
not o_query_1(Var0,Var1) :-
     happens(reset,Var0),
     Var1 #>= Var0+5,
     in_alert_zone(Var1),
     not holdsAt(altitude_alert_on,Var1).

not query(Var0,Var1) :-
     not o_query_1(Var0,Var1).

not o_default_1 :-
     reset.

not default :-
     not o_default_1.

not o_reset_1(Var0,Var1) :-
     not happens(reset,Var0,Var1).

not o_reset_1 :-
     forall(Var0,forall(Var1,not o_reset_1(Var0,Var1))).

not reset :-
     not o_reset_1.

not o_happens_1(Var0,Var1,Var2) :-
     Var1 \= 0.
not o_happens_1(Var0,Var1,Var2) :-
     Var1 = 0,
     Var2 \= 0.
not o_happens_1(Var0,Var1,Var2) :-
     Var1 = 0,
     Var2 = 0,
     Var0 \= adjust(32300).

not o_happens_2(Var0,Var1,Var2) :-
     Var0 \= reset.
not o_happens_2(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 \= 10.
not o_happens_2(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 = 10,
     Var2 \= 10.
not o_happens_2(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 = 10,
     Var2 = 10,
     o_happens(reset,10,10).
not o_happens_2(Var0,Var1,Var2) :-
     Var0 = reset,
     Var1 = 10,
     Var2 = 10,
     not o_happens(reset,10,10),
     not abducible(happens(reset,10,10)).

not o_happens_3(Var0,Var1,Var2) :-
     Var0 \= error_becomes_lt_1000.
not o_happens_3(Var0,Var1,Var2) :-
     Var0 = error_becomes_lt_1000,
     not error_becomes_lt(1000,Var1).
not o_happens_3(Var0,Var1,Var2) :-
     Var0 = error_becomes_lt_1000,
     error_becomes_lt(1000,Var1),
     Var2 #> Var1+1.

not o_happens_4(Var0,Var1,Var2) :-
     Var0 \= error_becomes_gt_200.
not o_happens_4(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     not error_becomes_gt(200,Var1).
not o_happens_4(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     error_becomes_gt(200,Var1),
     Var2 #> Var1+1.

not o_happens_5(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o_happens_5(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     not error_becomes_lt(180,Var1).
not o_happens_5(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     error_becomes_lt(180,Var1),
     Var2 #> Var1+1.

not o_happens_6(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o_happens_6(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     not error_becomes_gt(1020,Var1).
not o_happens_6(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     error_becomes_gt(1020,Var1),
     Var2 #> Var1+1.

not o_happens_7(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 \= stop_adjust.
not o_happens_7(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = stop_adjust,
     Var2 \= Var1.
not o_happens_7(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = stop_adjust,
     Var2 = Var1,
     Var3 #<> Var4-5.
not o_happens_7(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = stop_adjust,
     Var2 = Var1,
     Var3 #= Var4-5,
     Var4-5 #=< 0.
not o_happens_7(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = stop_adjust,
     Var2 = Var1,
     Var3 #= Var4-5,
     Var4-5 #> 0,
     not not_happensIn(adjust(Var5),Var3,Var4).
not o_happens_7(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = stop_adjust,
     Var2 = Var1,
     Var3 #= Var4-5,
     Var4-5 #> 0,
     not_happensIn(adjust(Var5),Var3,Var4),
     not inf(Var4,Var1).

not o_happens_7(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,not o_happens_7(Var0,Var1,Var2,Var3,Var4,Var5)))).

not o_happens_8(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 \= not_5.
not o_happens_8(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = not_5,
     Var2 \= Var1.
not o_happens_8(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #<> Var1-5.
not o_happens_8(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #= Var1-5,
     Var1-5 #< 0.
not o_happens_8(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #= Var1-5,
     Var1-5 #>= 0,
     not happens(adjust(Var4),Var3,Var3).
not o_happens_8(Var0,Var1,Var2,Var3,Var4,Var5) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #= Var1-5,
     Var1-5 #>= 0,
     happens(adjust(Var4),Var3,Var3),
     not not_happensIn(adjust(Var5),Var3,Var1).

not o_happens_8(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,not o_happens_8(Var0,Var1,Var2,Var3,Var4,Var5)))).

not o_happens_9(Var0,Var1,Var2,Var3,Var4) :-
     Var0 \= not_5.
not o_happens_9(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = not_5,
     Var2 \= Var1.
not o_happens_9(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #<> Var1-5.
not o_happens_9(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #= Var1-5,
     Var1-5 #< 0.
not o_happens_9(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #= Var1-5,
     Var1-5 #>= 0,
     not happens(reset,Var3,Var3).
not o_happens_9(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #= Var1-5,
     Var1-5 #>= 0,
     happens(reset,Var3,Var3),
     not not_happensIn(adjust(Var4),Var3,Var1).
not o_happens_9(Var0,Var1,Var2,Var3,Var4) :-
     Var0 = not_5,
     Var2 = Var1,
     Var3 #= Var1-5,
     Var1-5 #>= 0,
     happens(reset,Var3,Var3),
     not_happensIn(adjust(Var4),Var3,Var1),
     not not_happensIn(reset,Var3,Var1).

not o_happens_9(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,not o_happens_9(Var0,Var1,Var2,Var3,Var4))).

not happens(Var0,Var1,Var2) :-
     not o_happens_1(Var0,Var1,Var2),
     not o_happens_2(Var0,Var1,Var2),
     not o_happens_3(Var0,Var1,Var2),
     not o_happens_4(Var0,Var1,Var2),
     not o_happens_5(Var0,Var1,Var2),
     not o_happens_6(Var0,Var1,Var2),
     not o_happens_7(Var0,Var1,Var2),
     not o_happens_8(Var0,Var1,Var2),
     not o_happens_9(Var0,Var1,Var2).

not o_d_d_holdsAt_1(Var0,Var1,Var2,Var3) :-
     Var0 \= baro(Var2).
not o_d_d_holdsAt_1(Var0,Var1,Var2,Var3) :-
     Var0 = baro(Var2),
     Var2 #<> 32200+10*Var1.
not o_d_d_holdsAt_1(Var0,Var1,Var2,Var3) :-
     Var0 = baro(Var2),
     Var2 #= 32200+10*Var1,
     Var1 #< 0.
not o_d_d_holdsAt_1(Var0,Var1,Var2,Var3) :-
     Var0 = baro(Var2),
     Var2 #= 32200+10*Var1,
     Var1 #>= 0,
     not max_time(Var3).
not o_d_d_holdsAt_1(Var0,Var1,Var2,Var3) :-
     Var0 = baro(Var2),
     Var2 #= 32200+10*Var1,
     Var1 #>= 0,
     max_time(Var3),
     Var1 #> Var3.

not o_d_d_holdsAt_1(Var0,Var1) :-
     forall(Var2,forall(Var3,not o_d_d_holdsAt_1(Var0,Var1,Var2,Var3))).

not o_d_d_holdsAt_2(Var0,Var1) :-
     Var0 \= value(32300).
not o_d_d_holdsAt_2(Var0,Var1) :-
     Var0 = value(32300),
     Var1 #=< 0.

not d_holdsAt(Var0,Var1) :-
     not o_d_d_holdsAt_1(Var0,Var1),
     not o_d_d_holdsAt_2(Var0,Var1).

not o_precision_1(Var0) :-
     Var0 \= 0.1000000000145519.

not precision(Var0) :-
     not o_precision_1(Var0).

not o_max_time_1(Var0) :-
     Var0 \= 100.

not max_time(Var0) :-
     not o_max_time_1(Var0).

not o_initiallyN_1(Var0) :-
     Var0 \= capture_alert_on.

not o_initiallyN_2(Var0) :-
     Var0 \= departure_alert_on.

not o_initiallyN_3(Var0) :-
     Var0 \= altitude_alert_on.

not o_initiallyN_4(Var0) :-
     Var0 \= altitude_not_adjusting.

not o_initiallyN_5(Var0,Var1,Var2) :-
     Var0 \= value(Var1).
not o_initiallyN_5(Var0,Var1,Var2) :-
     Var0 = value(Var1),
     not initiallyP(value(Var2)).
not o_initiallyN_5(Var0,Var1,Var2) :-
     Var0 = value(Var1),
     initiallyP(value(Var2)),
     Var1 = Var2.

not o_initiallyN_5(Var0) :-
     forall(Var1,forall(Var2,not o_initiallyN_5(Var0,Var1,Var2))).

not initiallyN(Var0) :-
     not o_initiallyN_1(Var0),
     not o_initiallyN_2(Var0),
     not o_initiallyN_3(Var0),
     not o_initiallyN_4(Var0),
     not o_initiallyN_5(Var0).

not o_initiallyP_1(Var0) :-
     Var0 \= capture_alert_off.

not o_initiallyP_2(Var0) :-
     Var0 \= departure_alert_off.

not o_initiallyP_3(Var0) :-
     Var0 \= altitude_alert_off.

not o_initiallyP_4(Var0) :-
     Var0 \= altitude_adjusting.

not o_initiallyP_5(Var0) :-
     Var0 \= value(32300).

not initiallyP(Var0) :-
     not o_initiallyP_1(Var0),
     not o_initiallyP_2(Var0),
     not o_initiallyP_3(Var0),
     not o_initiallyP_4(Var0),
     not o_initiallyP_5(Var0).

not o_false.


% INTEGRITY CONSTRAINTS:
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     not holdsAt(error(Var2),Var3).
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     not holdsAt(error(Var4),Var5).
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #>= Var0.
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #< Var0.
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     not precision(Var6).
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     precision(Var6),
     Var5 #=< Var3.
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #>= Var3+Var6.
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #< Var3+Var6,
     not inf(Var5,Var1).
not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     holdsAt(error(Var2),Var3),
     holdsAt(error(Var4),Var5),
     Var2 #< Var0,
     Var4 #>= Var0,
     precision(Var6),
     Var5 #> Var3,
     Var5 #< Var3+Var6,
     inf(Var5,Var1),
     error_becomes_gt(Var0,Var1).

not o__chk_1_1(Var0,Var1) :-
     forall(Var2,forall(Var3,forall(Var4,forall(Var5,forall(Var6,not o__chk_1_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6)))))).

not o_chk_1(Var0,Var1) :-
     not o__chk_1_1(Var0,Var1).

not o__chk_2_1(Var0,Var1) :-
     not happens(Var0,Var1,Var1).
not o__chk_2_1(Var0,Var1) :-
     happens(Var0,Var1,Var1),
     happens(Var0,Var1).

not o_chk_2(Var0,Var1) :-
     not o__chk_2_1(Var0,Var1).

not o__chk_3_1(Var0,Var1) :-
     Var1 #=< 0.
not o__chk_3_1(Var0,Var1) :-
     Var1 #> 0,
     not initiallyP(Var0).
not o__chk_3_1(Var0,Var1) :-
     Var1 #> 0,
     initiallyP(Var0),
     not not_clipped(0,Var0,Var1).
not o__chk_3_1(Var0,Var1) :-
     Var1 #> 0,
     initiallyP(Var0),
     not_clipped(0,Var0,Var1),
     holdsAt(Var0,Var1).

not o_chk_3(Var0,Var1) :-
     not o__chk_3_1(Var0,Var1).

not o__chk_4_1(Var0,Var1,Var2) :-
     Var0 \= error_becomes_gt_200.
not o__chk_4_1(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     not error_becomes_gt(200,Var1).
not o__chk_4_1(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     error_becomes_gt(200,Var1),
     Var2 #> Var1+1.
not o__chk_4_1(Var0,Var1,Var2) :-
     Var0 = error_becomes_gt_200,
     error_becomes_gt(200,Var1),
     Var2 #=< Var1+1,
     happens(error_becomes_gt_200,Var1,Var2).

not o_chk_4(Var0,Var1,Var2) :-
     not o__chk_4_1(Var0,Var1,Var2).

not o__chk_5_1(Var0,Var1,Var2) :-
     Var0 \= error_outside_180_1020.
not o__chk_5_1(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     not error_becomes_gt(1020,Var1).
not o__chk_5_1(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     error_becomes_gt(1020,Var1),
     Var2 #> Var1+1.
not o__chk_5_1(Var0,Var1,Var2) :-
     Var0 = error_outside_180_1020,
     error_becomes_gt(1020,Var1),
     Var2 #=< Var1+1,
     happens(error_outside_180_1020,Var1,Var2).

not o_chk_5(Var0,Var1,Var2) :-
     not o__chk_5_1(Var0,Var1,Var2).

not o__chk_6_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     not findall(Var3,terminates(Var3,Var1,Var4),Var5).
not o__chk_6_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     findall(Var3,terminates(Var3,Var1,Var4),Var5),
     not out(Var0,Var2,Var5).
not o__chk_6_1(Var0,Var1,Var2,Var3,Var4,Var5) :-
     findall(Var3,terminates(Var3,Var1,Var4),Var5),
     out(Var0,Var2,Var5),
     not_clipped(Var0,Var1,Var2).

not o__chk_6_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,not o__chk_6_1(Var0,Var1,Var2,Var3,Var4,Var5)))).

not o_chk_6(Var0,Var1,Var2) :-
     not o__chk_6_1(Var0,Var1,Var2).

not o__chk_7_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 \= [Var3|Var4].
not o__chk_7_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 = [Var3|Var4],
     happens(Var5,Var6).
not o__chk_7_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 = [Var3|Var4],
     not happens(Var5,Var6),
     not out(Var0,Var1,Var4).
not o__chk_7_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6) :-
     Var2 = [Var3|Var4],
     not happens(Var5,Var6),
     out(Var0,Var1,Var4),
     out(Var0,Var1,[Var3|Var4]).

not o__chk_7_1(Var0,Var1,Var2) :-
     forall(Var3,forall(Var4,forall(Var5,forall(Var6,not o__chk_7_1(Var0,Var1,Var2,Var3,Var4,Var5,Var6))))).

not o_chk_7(Var0,Var1,Var2) :-
     not o__chk_7_1(Var0,Var1,Var2).

global_constraint :-
     forall(Var0,forall(Var1,not o_chk_1(Var0,Var1))),
     forall(Var0,forall(Var1,not o_chk_2(Var0,Var1))),
     forall(Var0,forall(Var1,not o_chk_3(Var0,Var1))),
     forall(Var0,forall(Var1,forall(Var2,not o_chk_4(Var0,Var1,Var2)))),
     forall(Var0,forall(Var1,forall(Var2,not o_chk_5(Var0,Var1,Var2)))),
     forall(Var0,forall(Var1,forall(Var2,not o_chk_6(Var0,Var1,Var2)))),
     forall(Var0,forall(Var1,forall(Var2,not o_chk_7(Var0,Var1,Var2)))).

