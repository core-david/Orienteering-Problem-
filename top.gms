option optcr = 0.0001

* Here the size of the set represents the number of nodes of our graph or in this
* particular case it represents the places available to visit.
set
i /1*5/;

Alias
(i,j,k);

* Table with the time it takes to go from one place to other, the table is symmetrical,
* meaning that we consider that the time it takes from A to B is the same as if we go from B to A.
* The last 
Table
t(i,j)
    1   2   3   4   5
1   999 170 200 100 0
2   170 999 170 90  170
3   200 170 999 80  200
4   100 90  80  999 100      
5   0   170 200 100 999;

* This is the variable we want to maximize.
Variable
z;

* Position of vertex 'i' in the path.
positive variable
u(i);

* x_ij = 1 if a visit to vertex 'i' is followed by a visit to vertex j,
* x_ij = 0 otherwise
binary variable
x(i,j);

* The score of each of the nodes.
parameter
s(i)/
1 0
2 1
3 7
4 5
5 0/;

* The cost in mexican pesos of visiting each node.
parameter
c(i)/
1 0
2 200
3 300
4 250
5 0
/;

Equations
obj
r1
r2
r3
r3
r4
r5
r6
r7
r8
r9
r10;


* The function to maximize, it sums all the scores of the places visited. 
obj..z=E= sum((i,j)$(ord(i) > 1 and ord(j) > 1 and ord(i) < card(i) and ord(j) <= card(j)),s(i) * x(i,j));

* Restriction 1 -> Starts at node 1 and ends at node N, that in this case the N node is a dummy node representing the first node
* converting from an orienteering problem to a tour orienteering problem.
r1.. sum(j$(ord(j) > 1), x('1',j)) =E=  1;
r2.. sum(i$(ord(i) < card(i)), x(i,'5')) =E= 1;

* Restriction 2 -> Every node is visited at least one and it ensures connectivity between all nodes.
r3(k)$(ord(k) > 1 and ord(k) < card(k)).. sum(i$(ord(i) < card(i)),x(i,k)) - sum(j$(ord(j) > 1 and ord(j) <= card(j)),x(k,j)) =E= 0;
r4(k)$(ord(k) > 1 and ord(k) < card(k)).. sum(i$(ord(i) < card(i)),x(i,k)) =L= 1;
r5(k)$(ord(k) > 1 and ord(k) < card(k)).. sum(j$(ord(j) > 1 and ord(j) < card(j)),x(k,j)) =L= 1;

* Restriction 3 -> Time limit
r6.. sum((i,j)$(ord(i) < card(i) and ord(j) > 1 and ord(j) <= card(j)),t(i,j) * x(i,j)) =L= 900;

* Restrictions 4 y 5 -> Prevents subtours. These subtour elimination constraints
* are formulated according to the Miller–Tucker–Zemlin (MTZ) formulation of the TSP.
r7(i)$(ord(i) > 1).. u(i) =G= 2;
r8(i)$(ord(i) > 1).. u(i) =L= 5;
r9(i,j)$(ord(i) > 1 and ord(j) > 1 and ord(i) <> ord(j)).. u(i) - u(j) + 1 =L= (card(i)- 1) * (1 - x(i,j));


* New Restriction -> Money limit, it only considers the cost of visiting each node.
r10.. sum((i,j)$(ord(i) < card(i) and ord(j) > 1 and ord(j) <= card(j)),c(i) * x(i,j)) =L= 800;


    
model op /all/;
solve op using MIP max z;
