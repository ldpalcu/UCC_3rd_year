%Palcu Liana-Daniela,gr.30238
%Graphs Search Algorithms

%Graph
edge(a,b).
edge(a,d).
edge(b,c).
edge(b,d).
edge(d,c).
%Depth-first search
%d_search(Start,Path)

d_search(X,_):-df_search(X,_).
d_search(_,L):-collect_v([],L).

df_search(X,L):-asserta(vert(X)),
                edge(X,Y),
                \+(vert(Y)),
                df_search(Y,L).

collect_v(L,P):-retract(vert(X)),!,collect_v([X|L],P).
collect_v(L,L).

%Breadth-first search
%do_bfs(Start,Path)

do_bfs(X,Path):-assertz(q(X)),asserta(vert(X)),bfs(Path).

bfs(Path):-q(X),!,expand(X),bfs(Path).
bfs(Path):-assertz(vert(end)),collect_v([],Path).

expand(X):-edge(X,Y),
          \+(vert(Y)),
          asserta(vert(Y)),
          assertz(q(Y)),
          fail.
expand(X):-retract(q(X)).

%Best-first search
pos_vec(start,0,2,[a,d]).
pos_vec(a,2,0,[start,b]).
pos_vec(b,5,0,[a,c,end]).
pos_vec(c,10,0,[b,end]).
pos_vec(d,3,4,[start,e]).
pos_vec(e,7,4,[d]).
pos_vec(end,7,2,[b,c]).

is_target(end).

dist(Node1,Node2,Dist):-pos_vec(Node1,X1,Y1,_),pos_vec(Node2,X2,Y2,_),
                      Dist is (X1-X2)*(X1-X2)+(Y1-Y2)*(Y1-Y2).

order([Node1|_],[Node2|_]):-is_target(Target),
                            dist(Node1,Target,Dist1),
                            dist(Node2,Target,Dist2),
                            Dist1<Dist2.

best([],[]):-!.
best([[Target|Rest]|_],[Target|Rest]):-is_target(Target),!.
best([[H|T]|Rest],Best):-pos_vec(H,_,_,Vec),
                         expand1(Vec,[H|T],Rest,Exp),
                         q1(Exp,SortExp,[]),
                         best(SortExp,Best).

expand1([],_,Exp,Exp):-!.
expand1([E|R],Path,Rest,Exp):- \+(member(E,Path)),!,
                              expand1(R,Path,[[E|Path]|Rest],Exp).
expand1([_|R],Path,Rest,Exp):-expand1(R,Path,Rest,Exp).

partition(H,[A|X],[A|Y],Z):-order(A,H),!,partition(H,X,Y,Z).
partition(H,[A|X],Y,[A|Z]):-partition(H,X,Y,Z).
partition(_,[],[],[]).

q1([H|T],S,R):-partition(H,T,A,B),
              q1(A,S,[H|Y]),
              q1(B,Y,R),
              q1([],S,S).

%Quiz exercises
%q10-1. Write a predicate which perform DLS – Depth-Limited Search on a graph. Set
%the depth limit via a predicate (e.g. depth_max(2).).

d_search_depth(X,D,_):-df_search_depth(X,0,D,_).
d_search_depth(_,_,L):-collect_v([],L).

df_search_depth(X,PD,D,L):-
                    PD < D,
                    PD1 is PD+1,
                    asserta(vert(X)),
                    edge(X,Y),
                    \+(vert(Y)),
                    df_search_depth(Y,PD1,D,L).

