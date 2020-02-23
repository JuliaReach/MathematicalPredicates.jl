__precompile__(true)

module MathematicalPredicates

export Predicate, Atom, Negation, Conjunction, Disjunction,
       evaluate

include("Predicate.jl")
include("Atom.jl")
include("Negation.jl")
include("Conjunction.jl")
include("Disjunction.jl")

# external functionality using 'Requires'
using Requires
include("init.jl")

end  # module
