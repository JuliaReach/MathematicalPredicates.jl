export SetAtom, contains, iscontainedin, isdisjointfrom, intersects

using .LazySets: LazySet, ⊆, isdisjoint

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
