event(s1_close).
event(s2_close).
event(s3_close).
event(relay_activate).

event(s1_open).
event(s2_open).
event(s3_open).
event(relay_deactivate).


event(light_on).
event(light_off).

initiates(s1_close, s1(closed), T).
terminates(s1_close, s1(open), T).

initiates(s2_close, s2(closed), T).
terminates(s2_close, s2(open), T).

initiates(s3_close, s3(closed), T).
terminates(s3_close, s3(open), T).


initiates(s1_open, s1(open), T).
terminates(s1_open, s1(closed), T).

initiates(s2_open, s2(open), T).
terminates(s2_open, s2(closed), T).

initiates(s3_open, s3(open), T).
terminates(s3_open, s3(closed), T).

initiates(relay_activate, relay(activated), T).
terminates(relay_activate, relay(deactivated), T).

initiates(relay_deactivate, relay(deactivated), T).
terminates(relay_deactivate, relay(activated), T).

initiates(light_on,  light(on), T).
terminates(light_on, light(off), T).

initiates(light_off, light(off), T).
terminates(light_off, light(on), T).
