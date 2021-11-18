

% #include 'bec_sarat.lp'.

%EARS:
%Ubiquitous: The <system name> shall <system response>.
%State Driven: WHILE <in a specific state> the <system name> shall <system response>
%Event Driven: WHEN <trigger> the <system name> shall <system response>
%Optional Feature: WHERE <feature is included> the <system name> shall <system response>
%Unwanted Behavior: IF <trigger>, THEN the <system name> shall <system response>
%Complex Behavior: While <precondition(s)> when < trigger> the <system name> shall <system response>

max_time(20).

%Requirements:
%1. When a train approaches, the system shall signal arrival at gate area at least 2 minutes prior and within 4 minutes
happens(in, T2) :- happens(approach, T1), holdsAt(approaching, T2), {T2 - T1 >= 2}.

% :- happens(in, T), T .>. 3.

 % in == arrival at gate area 

%2. When a train approaches, system shall signal gate to lower exactly after 1 minute 
	happens(lower, T2) :- happens(approach, T1), {T2 = T1 + 1}, holdsAt(open, T2). 

%3. When the gate receives lower signal, system shall close the gate down in less than 1 minute
	happens(closegate, T2) :- happens(lower, T1), {T2 - T1 < 1, T2 > T1}, holdsAt(lowering, T2).

%4. Train shall exit gate area within 5 minutes of train's approach.
%        :- happens(approach, T1), happens(exit, T2), T2 - T1 .>. 5. 
        happens(exit, T2) :-  happens(approach, T1), {T2 - T1 < 5, T2 > T1}, holdsAt(passing, T2).

%5. When train exits gate area, the system shall signal the gate to rise within 1 minute
        happens(raise, T2) :- happens(exit, T1), {T2 - T1 < 1, T2 > T1}, holdsAt(closed, T2).

% :- happens(raise, T1), happens(exit, T2), T1 .<. T2.

%6. When the gate receives raise signal, system shall raise the gate after 1 and before 2 minutes
        happens(opengate, T2) :- happens(raise, T1), {T2 > T1 + 1, T2 < T1 + 2}, holdsAt(rising, T2).

%7. While the train is in gate area, gate must be down.
    %    :- holdsAt(passing, T),  holdsAt(open, T). 
    %    :- holdsAt(passing, T),  holdsAt(rising, T). 
    %    :- holdsAt(passing, T),  holdsAt(lowering, T). 
    %     :- holdsAt(passing, T), not holdsAt(down, T).
%8. The gate shall not be indefinitely down.
%        :- not holdsAt(open, T). 
  % :- not open. 
  % open :- holdsAt(open, T).
  
 % open(T, T1) :- T1 .>. T, holdsAt(open, T). 
 % :- holdsAt(closed, T), not open(T, T1).

%events: in, approach, lower, gateclosed, exit, raise, gateopen

% train
event(approach).
event(in).
event(exit).
initiates(approach, approaching, T).
terminates(in, approaching, T).
initiates(in, passing, T).
terminates(exit, passing, T).
initiates(exit, leaving, T).

% gate
event(raise).
event(lower).
event(opengate).         %denotes gate completely open event
event(closegate).        %denotes gate completely closed event
terminates(lower, open, T).               %*****
initiates(lower, lowering, T).             
terminates(closegate, lowering, T).
initiates(closegate, closed, T).
terminates(raise, closed, T).
initiates(raise, rising, T).
terminates(opengate, rising, T).
initiates(opengate, open, T).        %the corresponding terminates is the one marked with ***** above



fluent(approaching).
fluent(passing).
fluent(leaving).
fluent(rising).       %gate is going up/rising
fluent(open).           %gate is straight up and continues to stay up
fluent(lowering).     %gate is lowering
fluent(closed).         %gate is down and continues to stay down


initiallyP(open).
initiallyN(approaching).
initiallyN(passing).
initiallyN(leaving).
initiallyN(rising).
initiallyN(closed).
initiallyN(lowering).

% happens(in, 1.5).

%?- holdsAt(closed, T). 


% :- holdsAt(passing, T), holdsAt(lowering, T). 
% :- holdsAt(passing, T), holdsAt(rising, T). 
% :- holdsAt(passing, T), holdsAt(opengate, T). 

% :- happens(in, T2), happens(approach, T1), T2 - T1 .<. 2.

happens(approach, 1).
% happens(exit, 6).

