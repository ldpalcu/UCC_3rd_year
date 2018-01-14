%Palcu Liana-Daniela, gr. 30238
%Sorting Methods
%Direct sorting methods
%Permutation sort
perm_sort(L,R):-perm(L,R),is_ordered(R),!.

perm(L,[H|R]):-append(A,[H|T],L),append(A,T,L1),perm(L1,R).
perm([],[]).

is_ordered([_]).
is_ordered([H1,H2|T]):-H1=<H2,is_ordered([H2|T]).

%Selection Sort
delete1(_,[],[]).
delete1(X,[X|T],T).
delete1(X,[H|T],[H|R]):-delete1(X,T,R).

delete_minimum(L,M,R):-min_list(L,M),delete1(M,L,R),!.
sel_sort(L,[M|R]):-delete_minimum(L,M,L1),write(L1),sel_sort(L1,R).
sel_sort([],[]).
%I used the delete1 version instead of delete because delete1 deletes one occurence at a time, delete deletes all the occurences of the element.

%Insertion sort
ins_sort([H|T],R):-ins_sort(T,R1),write(R1),insert_ord(H,R1,R).
ins_sort([],[]).

insert_ord(X,[H|T],[H|R]):-X>H,!,insert_ord(X,T,R).
insert_ord(X,T,[X|T]).

%Bubble sort
bubble_sort(L,R):-one_pass(L,R1,F),nonvar(F),!,bubble_sort(R1,R).
bubble_sort(L,L).

one_pass([H1,H2|T],[H2|R],F):-H1>H2,!,F=1,one_pass([H1|T],R,F).
one_pass([H1|T],[H1|R],F):-one_pass(T,R,F).
one_pass([],[],_).

%Advanced Sorting Methods
%QuickSort
quick_sort([H|T],R):-partition(H,T,Sm,Lg),quick_sort(Sm,SmS),quick_sort(Lg,LgS),append(SmS,[H|LgS],R).
quick_sort([],[]).

partition(H,[X|T],[X|Sm],Lg):-X<H,!,partition(H,T,Sm,Lg).
partition(H,[X|T],Sm,[X|Lg]):-partition(H,T,Sm,Lg).
partition(_,[],[],[]).

%MergeSort
merge_sort(L,R):-split1(L,L1,L2),merge_sort(L1,R1),merge_sort(L2,R2),merge(R1,R2,R).
merge_sort([H],[H]).
merge_sort([],[]).

split1(L,L1,L2):-length(L,Len),Len>1,K is Len/2,splitK(L,K,L1,L2).

splitK([H|T],K,[H|L1],L2):-K>0,!,K1 is K-1,splitK(T,K1,L1,L2).
splitK(T,_,[],T).

merge([H1|T1],[H2|T2],[H1|R]):-H1<H2,!,merge(T1,[H2|T2],R).
merge([H1|T1],[H2|T2],[H2|R]):-merge([H1|T1],T2,R).
merge([],L,L).
merge(L,[],L).

%Quiz exercises
%q5-1.For the predicate perm, the two calls to append, extract en element from a list
%randomly, and recreate the list without the selected element. Write the
%predicate(s) which perform these operations without using append, then write a
%new predicate, perm1, which generates the permutations of a list, using the new
%predicate(s) for extracting/deleting an element from a list.

select_random(L,X):-length(L,N), N>0, random(0,N,Index), nth0(Index,L,X).

delete_element(X,[X|T],T):-!.
delete_element(X,[H|T],[H|R]):-delete_element(X,T,R).
delete_element(_,[],[]).

perm1(L,[H|R]):-select_random(L,H),delete(L,H,L1),perm1(L1,R).
perm1([],[]).

q5-2. Write a predicate which performs selection sort by selecting, in each step, the
%maximum element from the unsorted part, and not the minimum. Analyze its efficiency.

maximum([],M,M).
maximum([H|T],MP,M):-H>MP,!,maximum(T,H,M).
maximum([H|T],MP,M):-maximum(T,MP,M).
maximum_pretty([H|T],M):-maximum([H|T],H,M).

search_max(L,M,R):-maximum_pretty(L,M),delete1(M,L,R),!.
sel_sort_max(L,[M|R]):-search_max(L,M,L1),sel_sort_max(L1,R).
sel_sort_max([],[]).

%q5-3. Write a forward recursive predicate which performs insertion sort. Analyze its
%efficiency in comparison with the backward recursive version.
ins_sort_fwd([H|T],Acc,R):-insert_ord(H,Acc,Res), ins_sort_fwd(T,Res,R).
ins_sort_fwd([],Acc,Acc).
ins_sort_fwd_pretty(L,R):-ins_sort_fwd(L,[],R).

%q5-4. Implement a predicate which performs bubble sort, using a fixed number of
%passes through the input sequence.

bubble_sort_k(L,0,L):-!.
bubble_sort_k(L,K,R):-K1 is K-1,one_pass(L,R1,_), bubble_sort_k(R1,K1,R).

%Problems
%p5-1. Suppose we have a list of ASCII characters. Sort the list according to their
%ASCII codes.
%transform_chars_to_numbers([H|T],Acc,R):-char_code(H,N),transform_chars_to_numbers(T,[N|Acc],R).
%transform_chars_to_numbers([],Acc,Acc).

sort_chars([H|T],R):-partition_chars(H,T,Sm,Lg),sort_chars(Sm,SmS),sort_chars(Lg,LgS),append(SmS,[H|LgS],R).
sort_chars([],[]).

partition_chars(H,[X|T],[X|Sm],Lg):-char_code(H,C1),char_code(X,C2), C2<C1,!,partition_chars(H,T,Sm,Lg).
partition_chars(H,[X|T],Sm,[X|Lg]):-partition_chars(H,T,Sm,Lg).
partition_chars(_,[],[],[]).

%p5-2. Suppose we have a list whose elements are lists containing atomic elements.
%Write a predicate(s) which sorts such a list according to the length of the sublists.

sort_len([H|T],R):-partition_len(H,T,Sm,Lg),sort_len(Sm,SmS),sort_len(Lg,LgS),append(SmS,[H|LgS],R).
sort_len([],[]).

partition_len(H,[X|T],[X|Sm],Lg):-length(H,N1),
                                  length(X,N2),
                                  N2<N1,!,
                                  partition_len(H,T,Sm,Lg).
partition_len(H,[X|T],Sm,[X|Lg]):-partition_len(H,T,Sm,Lg).
partition_len(_,[],[],[]).





