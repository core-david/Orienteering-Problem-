Implementation of the tour orienteering problem (OP) mathematical model into GAMS an algebraic modeling language.

# Orienteering Problem 
The Orienting Problem (OP) is a complex issue that involves selecting vertices and determining the shortest Hamiltonian path between them. This can be seen as a combination of the Knapsack Problem (KP) and the Travelling Salesperson Problem (TSP). However, the goals of the OP and TSP differ, as the former aims to maximise the total score collected, while the latter seeks to minimise travel time or distance. Furthermore, it's not necessary to visit all vertices in the OP (Vansteenwegen, Souffriau, & Van Oudheusden, 2010).

# Tour Orienteering Problem
The OP starts at vertex 1 and ends at vertex N, but in this modeling is implemented a dummy vertex in order to turn the OP into a Tour OP, meaning that it starts at vertex 1 and ends at this same vertex. 

# Mathematical Model of the TOP
The mathematical model used is almost completely based on the mathematical model presented in the paper _"The orienteering problem: A survey"_, in this modeling is added a restriction that considers a money budget, and also is added a dummy vertex, mentioned in the section before. 


$x_{ij} = 1$, If a visit to vertex $i$ is followed by a visit to vertex $j$. 

$x_{ij} = 0$, Otherwise.

$S_i$, Score given to each vertice.

$u_i$, The position of vertex $i$ in the path.

$c_i$, Cost of visiting the vertx $i$.


The function to maximize, it sums all the scores of the places visited:

$$ {Max} \sum_{i=2}^{N-1} \sum_{j=2}^N S_i x_{i j} $$ 


**Restriction 1** -> Starts at node 1 and ends at node N, that in this case the N node is a dummy node representing the first node converting from an orienteering problem to a tour orienteering problem:

$$ \sum_{j=2}^N x_{1 j}=\sum_{i=1}^{N-1} x_{i N}=1 $$

**Restriction 2 **-> Every node is visited at least one and it ensures connectivity between all nodes:

$$ \sum_{i=1}^{N-1} x_{i k}=\sum_{j=2}^N x_{k j} \leqslant 1 ; \quad \forall k=2, \ldots, N-1, $$


**Restriction 3** -> Time limit:

$$ \sum_{i=1}^{N-1} \sum_{j=2}^N t_{i j} x_{i j} \leqslant T_{\max }, $$


**Restrictions 4 y 5**-> Prevents subtours. These subtour elimination constraints are formulated according to the Miller–Tucker–Zemlin (MTZ) formulation of the TSP:

$$ 2 \leqslant u_i \leqslant N ; \quad \forall i=2, \ldots, N, $$

$$ u_i-u_j+1 \leqslant(N-1)\left(1-x_{i j}\right) ; \quad \forall i, j=2, \ldots, N $$


**Restriction 6** -> Indicates that $x_{i,j}$ is a binary variable:

$$ x_{i j} \in\{0,1\} ; \quad \forall i, j=1, \ldots, N $$


**New Restriction** -> Money limit, it only considers the cost of visiting each node:

$$ \sum_{i=1}^{N-1} \sum_{j=2}^N c_{i} x_{i j} \leqslant \textit{Money Budget} $$



# Bibliography 
Vansteenwegen, P., Souffriau, W., & Van Oudheusden, D. (2010). The orienteering problem: A survey. European Journal of Operational Research, 209(1), 1–10. https://doi.org/10.1016/j.ejor.2010.03.045
