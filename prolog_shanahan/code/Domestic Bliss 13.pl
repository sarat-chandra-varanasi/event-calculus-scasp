/*
   Test queries:

        :- abdemo([holds_at(murray_happy,T)],[],R).
*/


axiom(holds_at(murray_happy,T),
     [holds_at(rona_happy,T),holds_at(kerry_happy,T)]).

axiom(initiates(kiss_rona,rona_happy,T),
     [holds_at(rona_relaxed,T)]).

axiom(initiates(feed_kerry,kerry_happy,T),[]).

axiom(holds_at(rona_relaxed,T),[holds_at(tomorrow_off,T)]).

axiom(holds_at(rona_relaxed,T),[holds_at(in_garden,T)]).


axiom(initiates(cancel_concert,tomorrow_off,T),[]).

axiom(initiates(go_garden,in_garden,T),[]).


abducible(dummy).

executable(cancel_concert).

executable(go_garden).

executable(feed_kerry).

executable(kiss_rona).
