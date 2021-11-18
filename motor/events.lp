event(motor_engage).
event(motor_disengage).
event(reset).
event(normal_operation).
event(request_automation).
event(undo_request_automation).

initiates(motor_engage, motor(engage), T).
terminates(motor_engage, motor(disengage), T).


initiates(motor_disengage, motor(disengage), T).
terminates(motor_disengage, motor(engage), T).


initiates(reset, reset, T).
terminates(reset, no_reset, T).


initiates(normal_operation, no_reset, T).
terminates(normal_operation, reset, T).

initiates(request_automation, pilot(req), T).
terminates(request_automation, pilot(not_req), T).


initiates(undo_request_automation, pilot(not_req), T).
terminates(undo_request_automation, pilot(req), T).
