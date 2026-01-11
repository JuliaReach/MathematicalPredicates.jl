module LazySetsExt

using MathematicalPredicates

export contains, is_contained_in, is_disjoint_from, intersects

@static if VERSION >= v"1.5"
    import Base: contains
end

@static if isdefined(Base, :get_extension)
    import LazySets: dim, project
    using LazySets: LazySet, ⊆, isdisjoint
else
    import ..LazySets: dim, project
    using ..LazySets: LazySet, ⊆, isdisjoint
end

const SetAtom = CurryAtom{<:Any,<:LazySet}

# ===========================
# Dimension of set predicates
# ===========================

function dim(sa::SetAtom)
    return dim(sa.arg1)
end

# fallback
function dim(p::Predicate)
    throw(ArgumentError("`dim` cannot be applied to a `$(typeof(p))`; use a " *
                        "`CurryAtom` with a set instead"))
end

# ============================
# Projection of set predicates
# ============================

function project(sa::SetAtom, vars::AbstractVector{Int})
    X_proj = project(sa.arg1, vars)
    return CurryAtom(X_proj, sa.p)
end

# fallback
function project(p::Predicate, ::AbstractVector{Int})
    throw(ArgumentError("`project` cannot be applied to a `$(typeof(p))`; " *
                        "use a `CurryAtom` with a set instead"))
end

function project(n::Negation, vars::AbstractVector{Int})
    return Negation(project(n.p, vars))
end

function project(c::Conjunction, vars::AbstractVector{Int})
    conjuncts = similar(c.conjuncts)
    @inbounds for (i, (conjunct, n_args)) in enumerate(c.conjuncts)
        conjuncts[i] = (project(conjunct, vars), n_args)
    end
    return Conjunction(conjuncts)
end

function project(d::Disjunction, vars::AbstractVector{Int})
    disjuncts = similar(d.disjuncts)
    @inbounds for (i, (disjunct, n_args)) in enumerate(d.disjuncts)
        disjuncts[i] = (project(disjunct, vars), n_args)
    end
    return Disjunction(disjuncts)
end

# ==========================================
# Convenience functions to create predicates
# ==========================================

function contains(X::LazySet)
    return CurryAtom(X, Atom(⊆; N=2))
end

function is_contained_in(X::LazySet)
    return CurryAtom(X, Atom((X, Y) -> Y ⊆ X; N=2))
end

function is_disjoint_from(X::LazySet)
    return CurryAtom(X, Atom(isdisjoint; N=2))
end

function intersects(X::LazySet)
    return Negation(is_disjoint_from(X))
end

end  # module
