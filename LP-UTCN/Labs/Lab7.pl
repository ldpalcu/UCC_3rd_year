%Palcu Liana-Daniela, gr. 30238
%Trees.Operations on trees.
%Binary Search Trees
tree1(t(6, t(4, t(2, nil, nil), t(5, nil, nil)), t(9, t(7, nil, nil), nil))). 
tree2(t(8, t(5, nil, t(7, nil, nil)), t(9, nil, t(11, nil, nil)))).

%Tree traversal-preorder,inorder,postorder
inorder(t(K,L,R),List):-inorder(L,LL),inorder(R,LR),
                        append(LL,[K|LR],List).
inorder(nil,[]).

preorder(t(K,L,R),List):-preorder(L,LL),preorder(R,LR),
                        append([K|LL],LR,List).
preorder(nil,[]).

postorder(t(K,L,R),List):-postorder(L,LL),postorder(R,LR),
                        append(LL,LR,R1),append(R1,[K],List).
postorder(nil,[]).

%Pretty print
pretty_print(nil,_).
pretty_print(t(K,L,R),D):-D1 is D+1,pretty_print(L,D1),print_key(K,D),pretty_print(R,D1).

print_key(K,D):-D>0,!,D1 is D-1, write('\t'),print_key(K,D1).
print_key(K,_):-write(K),nl.

%Searching for a key
search_key(Key,t(Key,_,_)):-!.
search_key(Key,t(K,L,_)):-Key<K,!,search_key(Key,L).
search_key(Key,t(_,_,R)):-search_key(Key,R).

%Inserting a key
%the key was inserted
insert_key(Key,nil,t(Key,nil,nil)):-write('Inserted'),write(Key),nl.
%the key already exists
insert_key(Key,t(Key,L,R),t(Key,L,R)):-!,write('Key already in tree\n').
insert_key(Key,t(K,L,R),t(K,NL,R)):-Key<K,!,insert_key(Key,L,NL).
insert_key(Key,t(K,L,R),t(K,L,NR)):-insert_key(Key,R,NR).

%Deleting a key
delete_key(Key,nil,nil):-write(Key),write('not in tree\n').
%this clause covers also case for leaf.(L=nil)
%In these cases we have to delete a leaf node or a node with one child.
delete_key(Key,t(Key,L,nil),L):-!.
delete_key(Key,t(Key,nil,R),R):-!.
delete_key(Key,t(Key,L,R),t(Pred,NL,R)):-!,get_pred(L,Pred,NL).
delete_key(Key,t(K,L,R),t(K,NL,R)):-Key<K,!,delete_key(Key,L,NL).
delete_key(Key,t(K,L,R),t(K,L,NR)):-delete_key(Key,R,NR).

get_pred(t(Pred,L,nil),Pred,L):-!.
get_pred(t(Key,L,R),Pred,t(Key,L,NR)):-get_pred(R,Pred,NR).

%Height of a binary tree
%predicate which computes the maximum between 2 numbers 
max(A,B,A):-A>B,!.
max(_,B,B).

% predicate which computes the height of a binary tree
height(nil,0).
height(t(_,L,R),H):-height(L,H1),height(R,H2),max(H1,H2,H3),H is H3+1.

%Ternary Trees
ternary_tree1(t(6, t(4, t(2, nil, nil,nil),nil,t(7, nil, nil,nil)), t(5,nil,nil,nil), t(9, nil,nil,t(3, nil, nil,nil)))).
%Pretty print
%Implement pretty printing for a ternary tree. Study the execution of
%one or two queries for your predicate.
pretty_print_ternary(nil,_).
pretty_print_ternary(t(K,L,M,R),D):-D1 is D+1,print_key(K,D),
                                    pretty_print_ternary(L,D1),
                                    pretty_print_ternary(M,D1),
                                    pretty_print_ternary(R,D1).

%Tree Traversal
%inorder:Left->Root->Middle->Right
inorder_ternary(t(K,L,M,R),List):-inorder_ternary(L,LL),
                                  inorder_ternary(M,LM),
                                  inorder_ternary(R,LR),
                                  append(LL,[K|LM],R1),
                                  append(R1,LR,List).
inorder_ternary(nil,[]).

%preorder:Root->Left->Middle->Right
preorder_ternary(t(K,L,M,R),List):-preorder_ternary(L,LL),
                                   preorder_ternary(M,LM),
                                   preorder_ternary(R,LR),
                                   append([K|LL],LM,R1),
                                   append(R1,LR,List).
preorder_ternary(nil,[]).

%postorder:Left->Middle->Right->Root
postorder_ternary(t(K,L,M,R),List):-postorder_ternary(L,LL),
                                    postorder_ternary(M,LM),
                                    postorder_ternary(R,LR),
                                    append(LL,LM,R1),
                                    append(R1,LR,R2),
                                    append(R2,[K],List).
postorder_ternary(nil,[]).

%Tree height
height_ternary(nil,0).
height_ternary(t(_,L,M,R),H):-height_ternary(L,HL),
                              height_ternary(M,HM),
                              height_ternary(R,HR),
                              max(HL,HM,H1),
                              max(H1,HR,H2),
                              H is H2+1.

%Quiz exercises
%q8-1. Alter the predicate for the inorder traversal of a binary search tree such
%that the keys are printed on the screen instead of collecting them in a list.

inorder_screen(t(K,L,R)):-inorder_screen(L),
                          write(K),write(' '),
                          inorder_screen(R).
inorder_screen(nil).

%q8-2. Alter the delete_key predicate for deleting a key from a binary search
%tree, such that when the key is in a node with two children you apply the
%second solution: “hang” the left sub-tree to the right sub-tree, or viceversa.

delete_key2(Key, nil, nil):-write(Key), write(' not in tree\n').
delete_key2(Key, t(Key, L, nil), L):-!.
delete_key2(Key, t(Key, nil, R), R):-!.
%The key will be replaced with the root of the right subtree
%I get the left subtree of the right subtree so that I can hang the left subtree 
%of the old key to it.
delete_key2(Key, t(Key, L, R), t(NK,NL,NR)):-!,
                                            get_right_subtree(R,NR),
                                            get_key(R,NK),
                                            get_left_subtree(R,LR),
                                            hang_left_subtree(LR,L,NL).
delete_key2(Key, t(K, L, R), t(K, NL, R)):-Key<K, !, delete_key2(Key, L, NL).
delete_key2(Key, t(K, L, R), t(K, L, NR)):- delete_key2(Key, R, NR).

get_right_subtree(t(_,_,R),R).
get_key(t(K,_,_),K).
get_left_subtree(t(_,L,_),L).

%it puts the old subtree in place of the nil of the leftmost element of the new left subtree
hang_left_subtree(t(K,L,R),LOld,t(K,LNew,R)):-
                                hang_left_subtree(L,LOld,LNew).
hang_left_subtree(nil,LOld,LOld):-!.


%q8-3. Write a predicate which collects, in a list, all the keys found in leaf
%nodes of a binary search tree.
collect_keys(nil,[]).
collect_keys(t(K,nil,nil),[K]):-!.
collect_keys(t(_,L,R),List):-collect_keys(L,L1),collect_keys(R,L2),append(L1,L2,List),!.

%Problems
%p8-1. Write a predicate which computes the diameter of a binary tree
%(diam(Root) = max{diam(Left), diam(Right), height(Left)+height(Right)+1}).
diam(nil,0).
diam(t(K,L,R),D):-height(L,HL),height(R,HR),
                  diam(L,DL),diam(L,DR),
                  H is HL + HR + 1,
                  max(DL,DR,D1),
                  max(D1,H,D).

%p8-2. (**) Write a predicate which collects, in a list, all the nodes at the same depth in a ternary tree.
%collect_nodes_same_depth(T,D,List).

collect_nodes_same_depth(nil,_,_,[]).
collect_nodes_same_depth(t(K,_,_,_),D,D,[K]):-!.
collect_nodes_same_depth(t(_,L,M,R),D,PD,List):-PD < D,
                PD1 is PD + 1,
                collect_nodes_same_depth(L,D,PD1,RL),
                collect_nodes_same_depth(M,D,PD1,RM),
                collect_nodes_same_depth(R,D,PD1,RR),
                append(RL,RM,RP),
                append(RP,RR,List).



collect_nodes_same_depth_pretty(T,D,List):-
                    collect_nodes_same_depth(T,D,0,List).


%p8-3. (**) Let us call a binary tree symmetric if you can draw a vertical line
%through the root node and then the right sub-tree is the mirror image of the
%left sub-tree. Write a predicate symmetric(T) to check whether a given
%binary tree T is symmetric. We are only interested in the structure, not in the contents of the nodes.
%Hint: Write a predicate mirror(T1, T2) first to check whether one tree is the mirror image of another. 
%symmetric(T)
symmetric(nil):-!.
symmetric(t(_,L,R)):-mirror(L,R).

mirror(nil,nil).
mirror(t(_,L1,R1),t(_,L2,R2)):-mirror(R1,L2),mirror(R2,L1).


