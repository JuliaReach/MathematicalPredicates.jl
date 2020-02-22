using Test, MathematicalPredicates

@time @testset "Basic functionality" begin include("basic.jl") end
@time @testset "LazySets support" begin include("LazySets.jl") end
