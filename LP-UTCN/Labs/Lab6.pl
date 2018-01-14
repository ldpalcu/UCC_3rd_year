%Palcu Liana-Daniela, gr.30238
%Deep Lists.
%Simple operations with deep lists
%L1 = [1,2,3,[4]].
%L2 = [[1],[2],[3],[4,5]]
%L3 = [[],2,3,4,[5,[6]],[7]].
%L4 = [[[[1]]],1, [1]].
%L5 = [1,[2],[[3]],[[[4]]],[5,[6,[7,[8,[9],10],11],12],13]].
%L6= [alpha, 2,[beta],[gamma,[8]]]

%7.1 Using the list L5 defined above try to give the result of the following queries:
%a.?-member(2,L5). -> false, because in L5 2 is in a list.(is an atom)
%b.?-member([2],L5). -> true.
%c.?-member(X,L5). -> X=1; X=[2], X=[[3]], X=[[[4]]], X=[5,[6,[7,[8,[9],10],11],12],13].
%d.?-append(L1,R,L2). -> false.
%e.?-append(L4,L5,R). -> R = [[[[1]]], 1, [1], 1, [2], [[3]], [[[...]]], [5|...]].
%f.?-delete(1,L4,R). -> R = [[[[1]]], [1]].
%g.?-delete(13,L5,R). -> R = [1, [2], [[3]], [[[4]]], [5, [6, [...|...]|...], 13]], 
%it won't delete it because 13 is in a list.(is an atom).

%Advanced operations with deep lists
%The atomic predicate
%a. ?-atomic(apple). -> true
%b. ? – atomic(4). -> true
%c. ? – atomic(X). -> false, it is a variable
%d. ? – atomic( apple(2)). -> false, it is a complex term
%e. ? – atomic( [1,2,3]). -> false, it is a list
%f. ? – atomic( []). -> true

%The depth of a deep list
max(X,Y,Z):- X=<Y,!,Y=Z.
max(X,Y,X).

depth([],1).
depth([H|T],R):-atomic(H),!,depth(T,R).
depth([H|T],R):-depth(H,R1),depth(T,R2), R3 is R1+1, max(R3,R2,R).

%Flattening a deep list
%This operation means obtaining an equivalent shallow list from a deep list,
%containing all the elements, but with nesting level 1.
flatten([],[]).
flatten([H|T],[H|R]):-atomic(H),!,flatten(T,R).
flatten([H|T],R):-flatten(H,R1),flatten(T,R2),append(R1,R2,R).

%List Heads
%Returns all atomic elements which are at the head of a shallow list.
%It uses a flag to determine if we are at the first element of a list
heads3([],[],_).
heads3([H|T],[H|R],1):-atomic(H),!,heads3(T,R,0).
heads3([H|T],R,0):-atomic(H),!,heads3(T,R,0).
heads3([H|T],R,_):-heads3(H,R1,1),heads3(T,R2,0),append(R1,R2,R).
heads_pretty(L,R):-heads3(L,R,1).

%The nested member function
%It considers as member all elements appearing in the list, atomic or not, at any level.
member1(H,[H|_]).
member1(X,[H|_]):-member1(X,H).
member1(X,[_|T]):-member1(X,T).

%Observation: If we want our nested function to find only atomic elements we can use the
%flattening of the list to obtain a short solution:
member2(X,L):- flatten(L,L1), member(X,L1).

%If we ask member1(X,L) it will give us all the decompositions of every deep list.

%Quiz exercises
%7.3.1. Define a predicate which computes the number of atomic elements in a deep list.
number_of_atomic_elements([],0).
number_of_atomic_elements([H|T],R):-number_of_atomic_elements(T,R1),
                                    atomic(H),
                                    R is R1+1.
number_of_atomic_elements([H|T],R):-number_of_atomic_elements(T,R).

%7.3.2. Define a predicate computing the sum of atomic elements from a deep list.
sum_atomic_elems([],0).
sum_atomic_elems([H|T],R):-sum_atomic_elems(T,R1),
                           atomic(H),H\=[],!,
                           R is R1 + H.
sum_atomic_elems([H|T],R):-sum_atomic_elems(T,R).

%7.3.3. Define the deterministic version of the member predicate.
member_deterministic(H,[H|_]):-!.
member_deterministic(X,[H|_]):-member_deterministic(X,H).
member_deterministic(X,[_|T]):-member_deterministic(X,T).

%Problems
%7.4.1. Define a predicate returning the elements from a deep lists, which are at
%the end of a shallow list (immediately before a ‘]’).
tails3([],[],_).
%tails3([H|T],R,_):-T==[],tails3(H,R,1).
tails3([H|T],[H|R],1):-T==[],atomic(H),!,tails3(T,R,0).
tails3([H|T],R,0):-atomic(H),!,tails3(T,R,0).
tails3([H|T],R,_):-tails3(H,R1,0),tails3(T,R2,1),append(R1,R2,R).
tails_pretty(L,R):-tails3(L,R,0).

%7.4.2. Write a predicate which replaces an element/list/deep list in a deep list with another expression.
replace1(_,[],_,[]).
replace1(X,[H|T],E,[E|R]):-X==H,!,replace1(X,T,E,R).
replace1(X,[H|T],E,[H|R]):-replace1(X,T,E,R).

%7.4.3.** Define a predicate ordering the elements of a deep list by depth (when 2
%sublists have the same depth, order them in lexicographic order – after the order of elements).
%order_deep_list(L,R).-using quick sort

order_deep_list([H|T],R):-partition(H,T,Sm,Lg),
                          order_deep_list(Sm,SmS),
                          order_deep_list(Lg,LgS),
                          append(SmS,[H|LgS],R).
order_deep_list([],[]).

%X is smaller than H
partition(H,[X|T],[X|Sm],Lg):-compare_elems(X,H),!,partition(H,T,Sm,Lg).
%X is higher than H
partition(H,[X|T],Sm,[X|Lg]):-partition(H,T,Sm,Lg).
partition(_,[],[],[]).

%compare elements-choose which is smaller
%X and Y are atomic elements
compare_elems(X,Y):-atomic(X),atomic(Y),!,X<Y.
%X or Y are atomic elements
compare_elems(X,Y):-atomic(X),!,depth(Y,DY), 0<DY.
compare_elems(X,Y):-atomic(Y),!,depth(X,DX), DX<0.
%compare lists by their depth
compare_elems(X,Y):-depth(X,DX),depth(Y,DY), DX < DY.
%compare lists which have the same depth by the order of their elems
compare_elems(X,Y):-depth(X,DX),depth(Y,DY), DX == DY, compare_lexicographic(X,Y).

%compare their heads
compare_lexicographic([H1|_],[H2|_]):-compare_elems(H1,H2),!.
%if the heads are the same compare their tails
compare_lexicographic([H1|T1],[H2|T2]):-H1==H2,compare_lexicographic(T1,T2).








