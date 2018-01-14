%Palcu Liana-Daniela, gr.30238
%Graphs.Paths in Graphs 
%Four representations of graphs
/*As a set of edges, stored as predicate facts(edge-clause form):
edge(a, b).
edge(b, a).
edge(b, c).
edge(c, b).
->Avoid having to write the edges in both directions:*/
is_edge(X,Y):- edge(X,Y); edge(Y,X).

/*As a set of vertices and associated neighbor lists, stored as predicate facts (neighbor list-clause form):
neighbor(a,[b,d]).
neighbor(b, [a, c, d]).
neighbor(c, [b, d]).

As a set of vertices and associated neighbor lists, stored as a data object(neighbor list-list form):
Graph = [n(a, [b,d]), n(b, [a,c,d]), n(c, [b,d]), n(d, [a,b,c]), n(e, [f,g]), n(f, [e]), n(g,[e]), n(h, [])].

As the set of vertices and the set of edges, stored as a data object(graph-term form):
Graph = graph([a,b,c,d,e,f,g,h], [e(a,b), e(b,a), … ]).*/

%An example of conversion from the neighbor list-clause form to the edge-clause form
neighbor(a,[b,d]).
neighbor(b,[a,c,d]).
neighbor(c,[b,d]).

neighb_to_edge:-neighbor(Node,List),
                process(Node,List),
                fail.
neighb_to_edge.

process(Node,[H|T]):-assertz(edge(Node,H)),
                     process(Node,T).
process(_,[]).

%Paths in Graphs
%Simple path
%edge-clause form
%path(Source,Target,Path)

path(X,Y,Path):-path(X,Y,[X],Path).

path(X,Y,PPath,FPath):-is_edge(X,Z),
                       \+(member(Z,PPath)),
                       path(Z,Y,[Z|PPath],FPath).
path(X,X,PPath,PPath).

%Here it is used forward recursion.
%Exercise 9.1: Represent a graph using the edge-clause form and trace the
%execution of the path predicate on different queries.
%What happens when you repeat the question?
edge(a,b).
edge(a,d).
edge(b,c).
edge(b,d).
edge(c,d).
%it gives you another answer

%Restricted path
%a predicate which searches for a restricted path between
%two nodes in a graph, i.e. the path must pass through certain nodes, in a certain order
%(these nodes are specified in a list).
%restricted_path(Source,Target,RestrictionsList,Path)
%check_restrictions(RestrictionsList,Path)

restricted_path(X,Y,LR,P):-path(X,Y,P),
                           check_restrictions(LR,P).

check_restrictions([],_):-!.
check_restrictions([H|T],[H|R]):-!,check_restrictions(T,R).
check_restrictions(T,[H|L]):-check_restrictions(T,L).
%check_restrictions([],_).
%If we moved the stopping condition as last clause we obtain the same result many times.If we do this we don't need anymore the "!".
%The order of nodes in the list of restrictions should be the order which we established before.(for example, lexicographical order).

%Optimal path
%We consider the optimal path between the source and the target node in a graph
%as the path containing the minimum number of nodes.

%optimal_path(Source,Target,Path)

optimal_path(X,Y,_):-asserta(sol_part([],100)),
                     path1(X,Y,[X],1).
optimal_path(_,_,Path):-retract(sol_part(Path,_)).

path1(X,X,Path,LPath):-retract(sol_part(_,_)),!,
                       asserta(sol_part(Path,LPath)),
                       fail.
path1(X,Y,PPath,LPath):-is_edge(X,Z),
                        \+(member(Z,PPath)),
                        LPath1 is LPath + 1,
                        sol_part(_,Lopt),
                        LPath1<Lopt,
                        path1(Z,Y,[Z|PPath],LPath1).

%Hamiltonian Cycle
%A Hamiltonian cycle is a closed path in a graph which passes exactly once
%through all nodes (except for the first node, which is the source and the target of the path). 
%hamiltonian(NbNodes,Source,Path)

hamiltonian(NN,X,Path):-NN1 is NN-1,hamiltonian_path(NN1,X,X,[X],Path).

hamiltonian_path(0,X,Y,AccPath,AccPath):-is_edge(X,Y).
hamiltonian_path(NN,X,Y,AccPath,Path):-NN>0,
                                       NN1 is NN-1,
                                       is_edge(X,Z),
                                       \+(member(Z,PPath)),
                                       hamiltonian_path(NN1,Z,Y,[Z|PPath],Path).


%Quiz exercises 
%q9-1. Write the predicate(s) which perform the conversion between the edge-clause
%representation (A1B2) to the neighbor list-list representation (A2B1).
%example:the edge-clause form is defined above
%the neighbor list-list form should be for our example:
%Graph=[n(a,[b,d]),n(b,[a,c,d]),n(c,[b,d]),n(d,[a,b,c]).

edge_to_neighb:-edge(X,_),\+n(X,_),
                findall(Y,edge(X,Y),N),
                assertz(n(X,N)),
                fail.
edge_to_neighb.
                                
%q9-2. The restricted_path predicate computes a path between the source and the
%destination node, and then checks whether the path found contains the nodes
%in the restriction list. Since predicate path used forward recursion, the order
%of the nodes must be inversed in both lists – path and restrictions list. Try to
%motivate why this strategy is not efficient (use trace to see what happens).
%Write a more efficient predicate which searches for the restricted path between a source and a target node.
%restricted_path is inefficient because we continue to go on that path even if
%it does not contain any of the nodes. To improve this solution we
%can find a solution from the start node which can go throgh the nodes from the restricted path.

%using the path predicate, find a solution from the current node to the node of the restricted list

restricted_path_optimized(_,[],Path,Path).
restricted_path_optimized(N,[H|T],PPath,Path):-
                        path(N,H,PPath,FPath),
                        restricted_path_optimized(H,T,FPath,Path).

restricted_path_optimized_pretty(N,RList,Path):-
                restricted_path_optimized(N,RList,[N],Path).

%q9-3. Rewrite the optimal_path/3 predicate such that it operates on weighted
%graphs: attach a weight to each edge on the graph and compute the minimum
%cost path from a source node to a destination node.
edge_w(a,b,1).
edge_w(a,d,6).
edge_w(b,c,2).
edge_w(b,d,3).
edge_w(c,d,3).

is_edge_w(X,Y,W):-edge_w(X,Y,W);edge_w(Y,X,W).

%:-dynamic sol_part/2
optimal_path_w(X,Y,_,_):-asserta(sol_part_w([],100)),
                         path_w(X,Y,[X],0).
optimal_path_w(_,_,Path,W):-retract(sol_part_w(Path,W)).

path_w(X,X,Path,LPath):-retract(sol_part_w(_,_)),!,
                      asserta(sol_part_w(Path,LPath)),
                      fail.
path_w(X,Y,PPath,LPath):-is_edge_w(X,Z,W),
                      \+(member(Z,PPath)),
                      LPath1 is LPath+W,
                      sol_part_w(_,Lopt),
                      LPath1<Lopt,
                      path_w(Z,Y,[Z|PPath],LPath1).


%Problems
%p9-1. Write a predicate cycle(A,P) to find a closed path (cycle) P starting at a
%given node A in the graph G (use any graph representation for G). The predicate should return all cycles via backtracking.
%cycle(A,Path).
%the same predicate as path

cycle(A,Path):-cycle(A,A,[A],Path).

cycle(X,A,PPath,[A|PPath]):-is_edge(X,A).
cycle(X,A,PPath,FPath):-is_edge(X,Z),
                        \+(member(Z,PPath)),
                        cycle(Z,A,[Z|PPath],FPath).

/*p9-2. (**) Write a set of Prolog predicates to solve the Wolf-Goat-Cabbage
problem: “A farmer and his goat, wolf, and cabbage are on the North
bank of a river. They need to cross to the South bank. They have a
boat, with a capacity of two; the farmer is the only one that can row. If
the goat and the cabbage are left alone without the farmer, the goat
will eat the cabbage. Similarly, if the wolf and the goat are together
without the farmer, the goat will be eaten.”
Hints:
- you may choose to encode the state space as instances of the
configuration of the 4 objects (Farmer, Wolf, Goat, Cabbage),
represented either as a list (i.e. [F,W,G,C]), or as a complex
structure(e.g. F-W-G-C, or state(F,W,G,C)).
- the initial state would be [n,n,n,n], the final state [s,s,s,s], for the
list representation of states (e.g. if Farmer takes Wolf across ->
[s,s,n,n] (and the goat eats the cabbage), so this state should not be valid).*/

