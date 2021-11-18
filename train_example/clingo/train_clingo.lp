
% #include 'bec_original.lp'.

%% BASIC EVENT CALCULUS (BEC) THEORY

%% BEC1 - StoppedIn(t1,f,t2)
stoppedIn(T1, Fluent, T2) :-
    time(T1), time(T2), time(T),
    event(Event), fluent(Fluent),
    terminates(Event, Fluent, T),
    happens(Event, T),
    T1 < T, T < T2.
    

stoppedIn(T1, Fluent, T2) :-
    time(T1), time(T2), time(T),
     event(Event), fluent(Fluent),
    releases(Event, Fluent, T),
    happens(Event, T),
    T1 < T, T < T2.
    

%% BEC2 - StartedIn(t1,f,t2)
startedIn(T1, Fluent, T2) :-
    time(T1), time(T2), time(T),
     event(Event), fluent(Fluent),
    initiates(Event, Fluent, T),
    happens(Event, T),
    T1 < T, T < T2.
 

startedIn(T1, Fluent, T2) :-
    time(T1), time(T2), time(T),
     event(Event), fluent(Fluent),
    releases(Event, Fluent, T),
    happens(Event, T),
    T1 < T, T < T2.
    

%% BEC4 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    0 < T,
    time(T),
    initiallyP(Fluent),
    fluent(Fluent),
    not stoppedIn(0, Fluent, T).

%% BEC3 - holdsAt(f,t)
holdsAt(Fluent2, T2) :-
    time(T1), time(T2), time(T),
     event(Event), fluent(Fluent1),
     fluent(Fluent2),
    initiates(Event, Fluent1, T1),
    happens(Event, T1),
    trajectory(Fluent1, T1, Fluent2, T2),
    not stoppedIn(T1, Fluent1, T2).

%% BEC5 - not holdsAt(f,t)
-holdsAt(Fluent, T) :-
    time(T),
    0 < T,
    fluent(Fluent),
    initiallyN(Fluent),
    not startedIn(0, Fluent, T).

%% BEC6 - holdsAt(f,t)
holdsAt(Fluent, T) :-
    time(T1), time(T),
    initiates(Event, Fluent, T1),
     event(Event), fluent(Fluent),
    happens(Event, T1),
    precision(P),
     T1 + P < T ,
    not stoppedIn(T1, Fluent, T).

%% BEC7 - not holdsAt(f,t)
-holdsAt(Fluent, T) :-
    time(T), time(T1),
   event(Event),
    fluent(Fluent),
    terminates(Event, Fluent, T1),
    happens(Event, T1),
    precision(P),
    T1 + P < T,
   not startedIn(T1, Fluent, T).

precision(1).

%EARS:
%Ubiquitous: The <system name> shall <system response>.
%State Driven: WHILE <in a specific state> the <system name> shall <system response>
%Event Driven: WHEN <trigger> the <system name> shall <system response>
%Optional Feature: WHERE <feature is included> the <system name> shall <system response>
%Unwanted Behavior: IF <trigger>, THEN the <system name> shall <system response>
%Complex Behavior: While <precondition(s)> when < trigger> the <system name> shall <system response>

max_time(20).

time(0..12).

%Requirements:
%1. When a train approaches, the system shall signal arrival at gate area at least 2 minutes prior.
 happens(in, T2) :- happens(approach, T1), time(T1), time(T2), T2 - T1 >= 2, holdsAt(approaching, T2).

 % in == arrival at gate area   

%2. When a train approaches, system shall signal gate to lower exactly after 1 minute 
  happens(lower, T2) :- happens(approach, T1), time(T1), time(T2), T2 = T1 + 1, holdsAt(open, T2).

%3. When the gate receives lower signal, system shall close the gate down in less than 1 minute
  happens(closegate, T2) :- happens(lower, T1), time(T1), time(T2), T2 - T1 < 1, T2 > T1, holdsAt(lowering, T2). 

%4. Train shall exit gate area within 5 minutes of train's approach.
%        :- time(T1), time(T2),  happens(approach, T1), happens(exit, T2), T2 - T1 > 5. 
         happens(exit, T2) :-  happens(approach, T1), time(T1), time(T2),  T2 - T1 < 5, T2 > T1, holdsAt(passing, T2).

%5. When train exits gate area, the system shall signal the gate to rise within 1 minute
        happens(raise, T2) :- happens(exit, T1),  time(T1), time(T2), T2 - T1 < 1, T2 > T1, holdsAt(closed, T2).

% :- time(T1), time(T2), happens(raise, T1), happens(exit, T2), T1 < T2.

%6. When the gate receives raise signal, system shall raise the gate after 1 and before 2 minutes
        happens(opengate, T2) :- happens(raise, T1), time(T1), time(T2),  T2 > T1 + 1, T2 < T1 + 2,
        holdsAt(rising, T2).

%7. While the train is in gate area, gate must be down.
    %    :- holdsAt(passing, T),  holdsAt(open, T). 
    %    :- holdsAt(passing, T),  holdsAt(rising, T). 
    %    :- holdsAt(passing, T),  holdsAt(lowering, T). 
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
initiates(approach, approaching, T) :- time(T).
terminates(in, approaching, T) :- time(T).
initiates(in, passing, T) :- time(T).
terminates(exit, passing, T) :- time(T).
initiates(exit, leaving, T) :- time(T).

% gate
event(raise).
event(lower).
event(opengate).        
event(closegate).        
terminates(lower, open, T) :- time(T).               
initiates(lower, lowering, T) :- time(T).             
terminates(closegate, lowering, T) :- time(T).
initiates(closegate, closed, T) :- time(T).
terminates(raise, closed, T) :- time(T).
initiates(raise, rising, T) :- time(T).
terminates(opengate, rising, T) :- time(T).
initiates(opengate, open, T) :- time(T).        

fluent(approaching).
fluent(passing).
fluent(leaving).
fluent(rising).      
fluent(open).        
fluent(lowering).    
fluent(closed).       

initiallyP(open).
initiallyN(approaching).
initiallyN(passing).
initiallyN(leaving).
initiallyN(rising).
initiallyN(closed).
initiallyN(lowering).

happens(approach, 1).



#show happens/2.