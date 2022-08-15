using GLPK, JuMP

struct Client
    position
    demand
end;
client1 = Client([0,10], 25)

function random_client(pos_range, demande_range)
    position = rand(pos_range, (1, 2))
    demand = rand(demande_range, 1)
    client = Client(position, demand[1])
    return client
end;
client1 = random_client(1:100, 15:30);

struct CVRP_Problem
    clients
    depot
    m
    Q
end;

function random_instance(n_clients, depot, m, Q)
    clients = Dict([(i,random_client(0:100, 10:30)) for i in    1:n_clients])
    problem = CVRP_Problem(clients, depot, m , Q)
    return problem
end;

function display_problem(problem)
    x_pos = [c.position[1] for c in values(problem.clients)]
    y_pos = [c.position[2] for c in values(problem.clients)]
    scatter(x_pos, y_pos, shape = :circle, markersize = 6, label= "Client")
    scatter!([problem.depot[1]], [problem.depot[2]], shape = :square, markersize = 8, label= "Depot")
end;

cvrp = Model(GLPK.Optimizer)
x=@variable(cvrp,x[0:length(problem.clients),0:length(problem.clients)],Bin)
@constraint(cvrp, sum(get_out(x, 0)) <= problem.m)
@constraint(cvrp, sum(get_in(x, 0)) <= problem.m)
for i in 1:length(problem.clients)
    @constraint(cvrp, sum(get_in(x, i)) == 1)
    @constraint(cvrp, sum(get_out(x, i)) == 1)
end;
obj_coef = []
for i in 0:length(problem.clients)
    for j in 0:length(problem.clients)
         append!(obj_coef, [get_cost(problem, i, j) * x[i,j] ] )
    end;
end;
@objective(cvrp,Min,sum(obj_coef))
optimize!(cvrp)
termination_status(cvrp)
objective_value(cvrp)