export SetAtom, is_contained_in, is_disjoint_from, intersects
import .LazySets: dim, project

using .LazySets: LazySet, ⊆, isdisjoint

"""
    SetAtom{S<:LazySet, T} <: Predicate{Val{1}}

A unary atomic predicate defined with respect to a set.

### Fields

- `X` -- set
- `f` -- function that takes the set `X` as first argument
"""
struct SetAtom{S<:LazySet,T} <: Predicate{Val{1}}
    X::S
    f::T

    function SetAtom(X::S, f::T) where {S<:LazySet,T}
        return new{S,T}(X, f)
    end
end

# function-like evaluation
@inline function (sa::SetAtom)(args...)
    return evaluate(sa, args...)
end

function evaluate(sa::SetAtom, args...)
    assert_same_length(sa, args...)
    return sa.f(sa.X, args...)
end

function Base.:(==)(sa1::SetAtom, sa2::SetAtom)
    return sa1.X == sa2.X && sa1.f == sa2.f
end

# ===========================
# Dimension of set predicates
# ===========================

function dim(sa::SetAtom)
    return dim(sa.X)
end

# fallback
function dim(p::Predicate)
    throw(ArgumentError("`dim` cannot be applied to a `$(typeof(p))`; use a " *
                        "`SetAtom` instead"))
end

# ============================
# Projection of set predicates
# ============================

function project(sa::SetAtom, vars::AbstractVector{Int})
    X_proj = project(sa.X, vars)
    return SetAtom(X_proj, sa.f)
end

# fallback
function project(p::Predicate, ::AbstractVector{Int})
    throw(ArgumentError("`project` cannot be applied to a `$(typeof(p))`; " *
                        "use a `SetAtom` instead"))
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

# =====================================================
# Convenience functions to create common set predicates
# =====================================================

function is_contained_in(X::LazySet)
    return SetAtom(X, (X, Y) -> Y ⊆ X)
end

function is_disjoint_from(X::LazySet)
    return SetAtom(X, isdisjoint)
end

function intersects(X::LazySet)
    return Negation(is_disjoint_from(X))
end
