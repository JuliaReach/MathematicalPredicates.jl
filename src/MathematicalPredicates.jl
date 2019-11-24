module MathematicalPredicates

export Atom, Negation, Conjunction, Disjunction,
       evaluate

include("Predicate.jl")
include("Atom.jl")
include("Negation.jl")
include("Conjunction.jl")
include("Disjunction.jl")

end # module
