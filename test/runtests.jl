using Test, MathematicalPredicates

@testset "Basic functionality" begin
    include("basic.jl")
end
@testset "LazySets support" begin
    include("LazySets.jl")
end

include("Aqua.jl")
