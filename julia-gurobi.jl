using JuMP, Gurobi

m = Model(Gurobi.Optimizer)
@variable(m, x <= 5)
@variable(m, y <= 45)
@objective(m, Max, x + y)
@constraint(m, 50x + 24y <= 2400)
@constraint(m, 30x + 33y <= 2100)

JuMP.optimize!(m)
println("Objective value: ", JuMP.objective_value(m))
println("x = ", JuMP.value(x))
println("y = ", JuMP.value(y))