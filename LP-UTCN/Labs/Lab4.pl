%Palcu Liana-Daniela, gr. 30238
%The cut
%Using the cut to transform these member and delete predicates into deterministic predicates
member1(X,[X|_]):-!.
member1(X,[_|T]):-member1(X,T).
%It returns the head of the list when you call it with member1(X,[..])
%It returns the first appearance of the element when you call it X=3, member1(X,[3,2,4,3,1,2]).
%Predicate delete from previous lesson removed one occurence of the element at a time.(non-deterministic). 
%This predicate deletes the first and only the first occurence of an element from a list.
delete1(X,[X|T],T):-!.
delete1(X,[H|T],[H|R]):-delete(X,T,R).
delete1(_,[],[]).
%When you call it with delete(X,[..],R) it returns X=R, R=[].

%List Operations
%Length
%This represents a backward recursive approach:the result is built as the recursion returns.The final result is available at the top level.
length1([],0).
length1([H|T],Len):-length1(T,Len1), Len is Len1+1.
%Forward recursive approach-count the elements of the list as the list is decomposed.
%The final result will be available at the bottom level. 
%In order to make it available at the top level, we need to unify the accumulator with a free variable that is available at the top level.
length_fwd([],Acc,Res):-Res = Acc.
length_fwd([H|T],Acc,Res):-Acc1 is Acc+1, length_fwd(T,Acc1,Res).
length_fwd_pretty(L,Len):-length_fwd(L,0,Len).

%Reverse
reverse1([],[]).
reverse1([H|T],Res):-reverse1(T,R1), append(R1,[H],Res).

reverse_fwd([],R,R).
reverse_fwd([H|T],Acc,R):-reverse_fwd(T,[H|Acc],R).
reverse_fwd_pretty(L,R):-reverse_fwd(L,[],R).

%Minimum
minimum([],M,M).
minimum([H|T],MP,M):-H<MP,!,minimum(T,H,M).
minimum([H|T],MP,M):-minimum(T,MP,M).
minimum_pretty([H|T],R):-minimum([H|T],H,R).

minimum_bwd([H],H).
minimum_bwd([H|T],M):-minimum_bwd(T,M),H>=M.
minimum_bwd([H|T],H):-minimum_bwd(T,M),H<M.

minimum_bwd_improved([H|T],M):-minimum_bwd_improved(T,M),H>=M,!.
minimum_bwd_improved([H|T],H).

%Operations on Sets
%Union
union([],L,L).
union([H|T],L2,R):-member(H,L2),!,union(T,L2,R).
union([H|T],L,[H|R]):-union(T,L,R).

%Set intersection
inters([],_,[]).
inters([H|T],L2,[H|R]):-member(H,L2),!,inters(T,L2,R).
inters([H|T],L,R):-inters(T,L,R).

%Set difference
set_diff([],_,[]).
set_diff([H|T],L2,R):-member(H,L2),!,set_diff(T,L2,R).
set_diff([H|T],L,[H|R]):-set_diff(T,L,R).

%Quiz exercises
%q4-1.Write a predicate which finds and deletes the minimum element in a list.
delete_minimum(L,R):-minimum_bwd_improved(L,M),delete(L,M,R),!.

%q4-2.Write a predicate which reverses the elements of a list from
%the K th element onward (suppose K is smaller than the length of the list).
reverse_k(L,K,R):-K is 1,!,reverse(L,R).
reverse_k([H|T],K,R):-K1 is K-1, reverse_k(T,K1,R).

%q4-3.Write a predicate which finds and deletes the maximum element from a list.
maximum([],M,M).
maximum([H|T],MP,M):-H>MP,!,maximum(T,H,M).
maximum([H|T],MP,M):-maximum(T,MP,M).
maximum_pretty([H|T],M):-maximum([H|T],H,M).
delete_maximum(L,R):-maximum_pretty(L,M),delete(L,M,R),!.


%Problems
%p4-1.Write a predicate which performs RLE (Run-length encoding) on the elements of a 
%list, i.e. pack consecutive duplicates of an element in [element, no_occurences] packs.

rle_encode_count([H],N,[[H,N]]):-!.
rle_encode_count([H1,H2|T],N,R):- H1 = H2, N1 is N+1, !, rle_encode_count([H2|T],N1,R).
rle_encode_count([H|T],N,[[H,N]|R]):- rle_encode_count(T,1,R).

rle_encode(L,R):-rle_encode_count(L,1,R).
%p4-2.Write a predicate which rotates a list K positions to the right.
split_at(0,L,[],L).
split_at(K,[H1|L1],[H1|L2],L3):-K>0, K1 is K-1, split_at(K1,L1,L2,L3).

rotate_right(L,0,L).
rotate_right(L,K,R):- length(L,N), S is N-K, split_at(S,L,S1,S2), append(S2,S1,R).

%p4-3. Extract K random elements from a list L, in a new list, R. Hint: use random(MaxVal) function.
%rnd_select(L,K,R).
rnd_select(L,0,[]):-!.
rnd_select(L,K,[X|R]):-K>0, random_member(X,L), 
                       delete(L,X,L1),
                       K1 is K-1,
                       rnd_select(L1,K1,R).

