%Palcu Liana-Daniela, gr.30238
%Difference Lists. Side Effects

tree1(t(6, t(4, t(2, nil, nil), t(5, nil, nil)), t(9, t(7, nil, nil), nil))).

%Insert 
%add an element at the end of a list
add(X,[H|T],[H|R]):-add(X,T,R).
add(X,[],[X]).

%add predicate with difference lists
add(X,LS,LE,RS,RE):-RS=LS,LE=[X|RE].

%Tree traversal
%explicit unifications
/* when we reached the end of the tree we unify the beggining and end of the partial result list –
representing an empty list as a difference list */
%inorder_dl(nil,L,L).
%inorder_dl(t(K,L,R),LS,LE):-
/* obtain the start and end of the lists for the left and right subtrees */
%inorder_dl(L,LSL,LEL),
%inorder_dl(R,LSR,LER),
/* the start of the result list is the start of the left subtree list */
%LS=LSL,
/* insert the key between the end of the left subtree list and start of the right subtree list */
%LEL=[K|LSR],
/* the end of the result list is the end of the right subtree list */
%LE=LER

%implicit unifications
inorder_dl(nil,L,L).
inorder_dl(t(K,L,R),LS,LE):-inorder_dl(L,LS,[K|LT]),inorder_dl(R,LT,LE).

%Exercise 10.2: Implement the preorder_dl tree traversal predicate using difference lists.

preorder_dl(nil,L,L).
preorder_dl(t(K,L,R),[K|LS],LE):-preorder_dl(L,LS,LT),
                             preorder_dl(R,LT,LE).

%Exercise 10.3: Implement the postorder_dl tree traversal predicate using difference lists

postorder_dl(nil,L,L).
postorder_dl(t(K,L,R),LS,LE):-postorder_dl(L,LS,LT),
                              postorder_dl(R,LT,[K|LE]).

%Sorting-quicksort
quicksort_dl([H|T],S,E):-partition1(H,T,Sm,Lg),
                         quicksort_dl(Sm,S,[H|L]),
                         quicksort_dl(Lg,L,E).
quicksort_dl([],L,L).

partition1(H, [X|T], [X|Sm], Lg):-X<H, !, partition1(H, T, Sm, Lg).
partition1(H, [X|T], Sm, [X|Lg]):-partition1(H, T, Sm, Lg).
partition1(_, [], [], []).

%?- quicksort([4,2,5,1,3],L,[]). -> the result is a complete list
%?- quicksort([4,2,5,1,3],L,_). -> the result is an incomplete list

%Side effects
%using assert/1 or assertz/1; asserta/1; retract/1
%assert/1 (or assertz/1) - adds the predicate clause given as argument as last clause.
%asserta/1 - adds the predicate clause given as argument as first clause
%retract/1 - tries to unify the argument with the first unifying fact or clause in the
%database. The matching fact or clause is then removed from the database

%An example of memoisation with side effects is the following predicate which computes
%the nth number in the fibonacci sequence

fib(N,F):-memo_fib(N,F),!.
fib(N,F):- N>1, 
           N1 is N-1,
           N2 is N-2,
           fib(N1,F1),
           fib(N2,F2),
           F is F1+F2,
           assertz(memo_fib(N,F)).
fib(0,1).
fib(1,1).

%Failure-driven loops
print_all:-memo_fib(N,F),
            write(N),
            write(‘ - ‘),
            write(F),
            nl,
            fail.
print_all.

%Question 10.1: Can you collect all the values in a list, instead of writing them on the
%screen? How? Can you do that without modifying the predicate base? (After you answer these
%questions, search for findall/3 in the SWI manual).

%Yes, you can collect all the values in a list by modifying print_all
%such that it wil receive a list as a parameter which contains N and F.[N,F].
%findall(Obj,Goal,List)-produces a list of objects Obj that satisfy the goal Goal.(collecting solutions).

%a predicate which computes all the permutations of a list and returns them in a separate list
perm(L,[H|R]):-append(A,[H|T],L),append(A,T,L1),perm(L1,R).
perm([],[]).

all_perm(L,_):-perm(L,L1),
               assertz(p(L1)),
               fail.
all_perm(_,R):-collect_perms(R).

collect_perms([L1|R]):-retract(p(L1)),
                       !,
                       collect_perms(R).
collect_perms([]).

/*Questions:
10.2: Why do I need a retractall call before calling all_perm/2?
A:To be sure that you didn't compute before all the permutations.
10.3: Why do I need a ! after the retract call in the first clause of collect_perms/1?
A:You do not want to backtrack again.
10.4: What kind of recursion is used on collect_perms/1? Can you do the collect using
the other type of recursion? Which is the order of the permutations in that case?
A:For this predicate it was used the backward recursion.
Also, you can use forward recursion by adding a new argument which will play
the role of an acculumator.
The order is the reverse of now.
10.5: Does collect_perms/1 destroy the results stored on the predicate base, or does it
only read them?
A:It will distroy the results.*/

%Quiz exercises
%10.4.1 Write a predicate which transforms an incomplete list into a difference list (and
%one which makes the opposite transformation).

transform_il_dl(L,S,S):-var(L),!.
transform_il_dl([H|T],[H|S],E):-transform_il_dl(T,S,E).

transform_dl_il(S,_,_):-var(S),!.
transform_dl_il([H|T],LE,[H|R]):-transform_dl_il(T,LE,R).

%10.4.2. Write a predicate which transforms a complete list into a difference list (and one
%which makes the opposite transformation).

transform_cl_dl([],S,S).
transform_cl_dl([H|T],[H|S],E):-transform_cl_dl(T,S,E).

transform_dl_cl(E,E,[]):-var(E),!.
transform_dl_cl([H|T],LE,[H|R]):-transform_dl_cl(T,LE,R).

%10.4.3. Write a predicate which generates a list with all the possible decompositions of a 
%list into 2 lists, without using findall.
all_decompositions(L,_):-append(X,Y,L),
                         assertz(lists(X,Y)),
                         fail.
all_decompositions(_,R):-collect_decomps(R).

collect_decomps([[X,Y]|R]):-retract(lists(X,Y)),
                            !,
                            collect_decomps(R).
collect_decomps([]).

%Problems
%10.5.1 Write a predicate which flattens a deep list using difference lists instead of append.

%flatten_dl(DL,LS,LE).
flatten_dl([H|T],[H|LS],LE):-atomic(H),!,flatten_dl(T,LS,LE).
flatten_dl([H|T],LS,LE):-flatten_dl(H,LS,LTS),
                         flatten_dl(T,LTS,LE).
flatten_dl([],L,L).
                         
                            
%10.5.2 Write a predicate which collects all even keys in a binary tree, using difference lists.
%collect_even_keys(T,LS,LE).
tree2(t(5,t(1,t(9,nil,nil),t(6,nil,t(4,t(3,nil,nil),t(10,nil,nil)))),t(8,t(2,nil,nil),nil))).

collect_even_keys(t(Key,L,R),LS,LE):-
                0 is Key mod 2,!,
                collect_even_keys(L,LS,[Key|LT]),
                collect_even_keys(R,LT,LE).
collect_even_keys(t(_,L,R),LS,LE):-
                collect_even_keys(L,LS,LT),
                collect_even_keys(R,LT,LE).
collect_even_keys(nil,L,L).

%10.5.3. Write a predicate which collects, from a binary incomplete search tree, all keys
%between K1 and K2, using difference lists.
%collect_keys(T,K1,K2,LS,LE).
tree_il1(t(6, t(4, t(2, _, _), t(5, _, _)), t(9, t(7, _,
     _), _))).
collect_keys(T,_,_,L,L):-var(T),!.
collect_keys(t(Key,L,R),K1,K2,LS,LE):-
                        Key > K1, Key < K2, !,
                        collect_keys(L,K1,K2,LS,[Key|LT]),
                        collect_keys(R,K1,K2,LT,LE).
collect_keys(t(_,L,R),K1,K2,LS,LE):-
                        collect_keys(L,K1,K2,LS,LT),
                        collect_keys(R,K1,K2,LT,LE).

                        

