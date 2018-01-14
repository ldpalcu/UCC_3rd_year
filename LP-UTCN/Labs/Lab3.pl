%Lab3 Lists.List Operations(I)

%Member - Determine membership
member(X,[X|_]). %member(X,[H|T]):-H=X.
member(X,[_|T]):-member(X,T). %member(X,[H|T]):-member(X,T).
%If we change the order of the two clauses the unification will hapen only
%at the return from the function call

%Append - Concatenation of two lists
append([],L,L). %append([],L2,Res):-L2=Res.
append([H|T],L,[H|R]):-append(T,L,R). %append([H|T],L2,Res):-append(T,L2,R),Res=[H|R].
%If we reverse the order of the two clauses the unifications step will hapen 
%at the return from the function call.

%Delete-Remove an element from a list
%This predicate removes one occurrence of the element at a time.
%When the question is repeated, it will remove the next occurence etc.
delete(X,[X|T],T).
delete(X,[H|T],[H|R]):-delete(X,T,R).
delete(_,[],[]).
%This predicate removes all the occurenced of a given element from a list.
delete_all(X,[X|T],R):-delete_all(X,T,R).
delete_all(X,[H|T],[H|R]):-delete_all(X,T,R).
delete_all(_,[],[]).

%Quiz exercises
%3.2.1. Concatenation of 3 lists.
%append3(L1,L2,L3,R).
append3([],[],L3,L3).
append3([],[H|T],L3,[H|R]):-append3([],T,L3,R).
append3([H|T],L2,L3,[H|R]):-append3(T,L2,L3,R).

%3.2.2. Insert en element at the beginning of a list.
insertFirst(X,L,[X|L]).


%3.2.3 Compute the sum of the elements of a list of integers.
sumList([],S,S).
sumList([H|T],S,SF):-Si is S+H, sumList(T,Si,SF).

%3.3 Problems
%3.3.1 A predicate which produces two lists: one contains even elements and
%the other the odd elements from L
%separate_parity(L,E,O).
separate_parity([],[],[]).
separate_parity([H|T],E,[H|O]):-1 is mod(H,2), separate_parity(T,E,O).
separate_parity([H|T],[H|E],O):-0 is mod(H,2), separate_parity(T,E,O).

%3.3.2 A predicate which removes all the duplicate elements in a list.
%remove_duplicates(L,R).
remove_duplicates([],[]).
remove_duplicates([H|T],R):- member(H,T),remove_duplicates(T,R).
remove_duplicates([H|T],[H|R]):- \+member(H,T),remove_duplicates(T,R).

%3.3.3 A predicate which replaces all the occurences of element K with NewK
%replace_all(X,Y,L,R).
replace_all(X,Y,[X|T],[Y|R]):-replace_all(X,Y,T,R).
replace_all(X,Y,[H|T],[H|R]):-replace_all(X,Y,T,R).
replace_all(_,_,[],[]).

%3.3.4 A predicate which deletes every kth element
%drop_k(L,K,R).
drop_k2([],_,[],_).
drop_k2([H|T],K,R,I):- I=K, I1 is 1, drop_k2(T,K,R,I1).
drop_k2([H|T],K,[H|R],I):- I < K, I1 is I+1, drop_k2(T,K,R,I1).
drop_k(L,K,R):-K > 0, drop_k2(L,K,R,1).
