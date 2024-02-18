% Define the graph connections
connected('Warehouse', Consumer, Weight) :-
    member(Consumer, ['C1', 'C2', 'C3', 'C4', 'C5']),
    random_weight(Weight).

connected(Consumer1, Consumer2, Weight) :-
    member(Consumer1, ['C6', 'C7', 'C8', 'C9', 'C10']),
    member(Consumer2, ['C1', 'C2', 'C3', 'C4', 'C5']),
    Consumer1 \= Consumer2,
    random_weight(Weight).

% Generate a random weight between 1 and 10
random_weight(Weight) :-
    Weight is random(10) + 1.

% Define the optimal path using Dijkstra's algorithm
dijkstra_path(Graph, Start, End, Cost, Path) :-
    dijkstra_path(Graph, Start, End, [], Cost, Path).

dijkstra_path(_, Node, Node, Visited, 0, [Node|Visited]) :-
    reverse([Node|Visited], Path),
    length(Path, Length),
    Length > 1.

dijkstra_path(Graph, Start, End, Visited, Cost, Path) :-
    connected(Start, Next, Weight),
    \+ member(Next, Visited),
    dijkstra_path(Graph, Next, End, [Start|Visited], RestCost, RestPath),
    Cost is Weight + RestCost,
    Path = [Start|RestPath].

% Define the delivery rules
deliver_orders(Graph, Orders) :-
    deliver_orders(Graph, 'Warehouse', 50, Orders).

deliver_orders(_, _, _, []) :-
    writeln('All orders delivered successfully!').

deliver_orders(_, CurrentLocation, TruckCapacity, [order(Consumer, Quantity)|RestOrders]) :-
    dijkstra_path(Graph, CurrentLocation, Consumer, Cost, Path),
    (   member('Warehouse', Path)
    ->  writeln('Delivering order with refill'),
        deliver_with_refill(Graph, Path, Quantity, RestCapacity),
        deliver_orders(Graph, Consumer, RestCapacity, RestOrders)
    ;   deliver_without_refill(Path, Quantity, RestCapacity),
        deliver_orders(Graph, Consumer, RestCapacity, RestOrders)
    ),
    % Use TruckCapacity and Cost in the body
    writeln('TruckCapacity: '),
    writeln(TruckCapacity),
    writeln('Cost: '),
    writeln(Cost).

deliver_without_refill(Path, Quantity, RestCapacity) :-
    (   Quantity > 0
    ->  writeln('Delivering order without refill'),
        writeln(Path),
        writeln(Quantity)
    ;   true
    ),
    RestCapacity is 50 - Quantity.

deliver_with_refill(Graph, Path, Quantity, RestCapacity) :-
    writeln('Refilling at the warehouse'),
    % Only call deliver_without_refill once
    deliver_without_refill(Path, 50, _),
    deliver_without_refill(Path, Quantity, RestCapacity).

% Example usage
:- initialization(main).

main :-
    create_graph(Graph),
    print_graph(Graph),
    get_orders(Orders),
    deliver_orders(Graph, Orders).

% Utility predicates for user input

create_graph(Graph) :-
    findall(connected(X, Y, W), connected(X, Y, W), Edges),
    list_to_set(Edges, Graph).

print_graph(Graph) :-
    writeln('Graph Edges:'),
    forall(member(Edge, Graph), writeln(Edge)).

get_orders(Orders) :-
    writeln('Enter the number of orders: '),
    read(NumOrders),
    get_orders(NumOrders, Orders).

get_orders(0, []) :- !.
get_orders(N, [Order|RestOrders]) :-
    N > 0,
    writeln('Enter consumer: '),
    read(Consumer),
    writeln('Enter quantity (1 to 50): '),
    read(Quantity),
    Order = order(Consumer, Quantity),
    NextN is N - 1,
    get_orders(NextN, RestOrders).
