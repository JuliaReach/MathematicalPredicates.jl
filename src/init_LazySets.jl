export SetAtom, contains, iscontainedin, isdisjointfrom, intersects

using .LazySets: LazySet, ⊆, isdisjoint
import .LazySets: dim, project

"""
    SetAtom{S<:LazySet, T} <: Predicate{Val{1}}

A unary atomic predicate defined with respect to a set.

### Fields

- `X` -- set
- `f` -- function that takes the set `X` as first argument
"""
struct SetAtom{S<:LazySet, T} <: Predicate{Val{1}}
    X::S
    f::T

    function SetAtom(X::S, f::T) where {S<:LazySet, T}
        return new{S, T}(X, f)
    end
end

# function-like evaluation
@inline function (sa::SetAtom)(args...)
    evaluate(sa, args...)
end

function evaluate(sa::SetAtom, args...)
    assert_same_length(sa, args...)
    return sa.f(sa.X, args...)
end

function dim(sa::SetAtom)
    return dim(sa.X)
end

function project(sa::SetAtom, vars::AbstractVector{Int})
    X_proj = project(sa.X, vars)
    return SetAtom(X_proj, sa.f)
end

# ==========================================
# Convenience functions to create predicates
# ==========================================

function contains(X::LazySet)
    return SetAtom(X, ⊆)
end

function iscontainedin(X::LazySet)
    return SetAtom(X, (X, Y) -> Y ⊆ X)
end

function isdisjointfrom(X::LazySet)
    return SetAtom(X, isdisjoint)
end

function intersects(X::LazySet)
    return Negation(isdisjointfrom(X))
end
