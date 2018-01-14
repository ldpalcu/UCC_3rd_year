%Palcu Liana-Daniela, gr.30238
%Incomplete structures-lists and trees
%(partially instantiated structures)
%Member

% must test explicitly for the end of the list, and fail
member_il(_,L):-var(L),!,fail.
% these 2 clauses are the same as for the member1 predicate
member_il(X,[X|_]):-!.
member_il(X,[_|T]):-member_il(X,T).

%Insert
%found end of list, add element
insert_il(X,L):-var(L),!,L=[X|_].
%found element,stop
insert_il(X,[X|_]):-!.
%traverse input list to reach end/X
insert_il(X,[_|T]):-insert_il(X,T).

%Delete
%reached end, stop
delete_il(_,L,L):-var(L),!.
%found element, remove it and stop
delete_il(X,[X|T],T):-!.
%search for the element
delete_il(X,[H|T],[H|R]):-delete_il(X,T,R).

%Incomplete binary search trees
tree1(t(7, t(5, t(3, _, _), _), t(11, _, _))).

%Search
search_it(_,T):-var(T),!,fail.
search_it(Key,t(Key,_,_)):-!.
search_it(Key,t(K,L,R)):-Key<K,!,search_it(Key,L).
search_it(Key,t(_,_,R)):-search_it(Key,R).

%Insert
insert_it(Key,t(Key,_,_)):-!.
insert_it(Key,t(K,L,R)):-Key<K,!,insert_it(Key,L).
insert_it(Key,t(_,_,R)):-insert_it(Key,R).

%Delete
delete_it(Key,T,T):-var(T),!,write(Key),write(' not in tree\n').
delete_it(Key,t(Key,L,R),L):-var(R),!.
delete_it(Key,t(Key,L,R),R):-var(L),!.
delete_it(Key,t(Key,L,R),t(Pred,NL,R)):-!,get_pred(L,Pred,NL).
delete_it(Key,t(K,L,R),t(K,NL,R)):-Key<K,!,delete_it(Key,L,NL).
delete_it(Key,t(K,L,R),t(K,L,NR)):-delete_it(Key,R,NR).

get_pred(t(Pred,L,R),Pred,L):-var(R),!.
get_pred(t(Key,L,R),Pred,t(Key,L,NR)):-get_pred(R,Pred,NR).

%Quiz exercises
%q9-1. Write a predicate which appends two incomplete lists (the result should be an incomplete list also).

append_il(L1,L2,L2):-var(L1),!.
append_il([H|T],L,[H|R]):-append_il(T,L,R).

%q9-2. Write a predicate which reverses an incomplete list (the result should be an incomplete list also).

reverse_il(L,L):-var(L),!.
reverse_il([H|T],Res):-reverse_il(T,R1),append_il(R1,[H|_],Res).

%q9-3. Write a predicate which transforms an incomplete list into a complete list.

transform(L,[]):-var(L),!.
transform([H|T],[H|CL]):-transform(T,CL).

%q9-4. Write a predicate which performs a preorder traversal on an
%incomplete tree, and collects the keys in an incomplete list.

preorder_il(T,List):-var(T),!.
preorder_il(t(K,L,R),List):-preorder_il(L,LL),
                            preorder_il(R,LR),
                            append_il([K|LL],LR,List).

%q9-5. Write a predicate which computes the height of an incomplete binary tree.

max(A,B,A):-A>B,!.
max(A,B,B).

height_it(T,0):-var(T),!.
height_it(t(_,L,R),H):-height_it(L,H1),
                       height_it(R,H2),
                       max(H1,H2,H3),
                       H is H3 + 1.

%q9-6. Write a predicate which transforms an incomplete tree into a complete tree.

transform_it(T,nil):-var(T),!.
transform_it(t(K,L,R),t(K,T1,T2)):-transform_it(L,T1),
                          transform_it(R,T2).


%Problems
%p9-1. Write a predicate which takes as input a deep incomplete list (i.e. any
%list, at any level, ends in a variable). Write a predicate which flattens such a structure.

flatten_il(L,L):-var(L),!.
flatten_il([H|T],[H|R]):-atomic(H),!,flatten_il(T,R).
flatten_il([H|T],R):-flatten_il(H,R1),flatten_il(T,R2),append_il(R1,R2,R).

%p9-2. (**) Write a predicate which computes the diameter of a binary incomplete tree:
%diam(Root) = max{diam(Left), diam(Right), height(Left) + height(Right) + 2}).

diam_it(T,0):-var(T),!.
diam_it(t(_,L,R),D):-height_it(L,HL),height_it(R,HR),
                     diam_it(L,DL),diam_it(R,DR),
                     H is HL + HR + 2,
                     max(DL,DR,D1),
                     max(H,D1,D).

%p9-3. (**) Write a predicate which determines if an incomplete list is sub-list in another incomplete list.
%sub_il(SL,L).

prefix(SL,_):-var(SL),!.
prefix(_,L):-var(L),!,fail.
prefix([H|T1],[H|T2]):-prefix(T1,T2).

%check if SL is a variable, return succes because we traverse all the sublist
subl_il(SL,_):-var(SL),!.
%check if L is a variable, return fail
subl_il(_,L):-var(L),!,fail.
%if lists SL and L have the same head, check if the tail of SL is a prefix of the tail of list L
subl_il([H|T1],[H|T2]):-prefix(T1,T2).
%if it is not the prefix of the L, then check if it is the sublist of the tail of L
subl_il(SL,[_|T2]):-subl_il(SL,T2).
