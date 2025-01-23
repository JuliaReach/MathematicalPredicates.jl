module MathematicalPredicates

export Predicate, Atom, Negation, Conjunction, Disjunction, CurryAtom,
       evaluate

include("Predicate.jl")
include("Atom.jl")
include("Negation.jl")
include("Conjunction.jl")
include("Disjunction.jl")
include("CurryAtom.jl")

# optional dependencies
using Requires
include("init.jl")

end  # module
