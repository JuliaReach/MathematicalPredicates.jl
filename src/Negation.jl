"""
    Negation{N, T<:Predicate{N}} <: Predicate{N}

A negation of a predicate of arity `N`.

### Fields

- `p` -- predicate
"""
struct Negation{N,T<:Predicate{N}} <: Predicate{N}
    p::T

    function Negation(p::T) where {T<:Predicate{N}} where {N}
        return new{N,T}(p)
    end
end

function Base.:(==)(n1::Negation, n2::Negation)
    return n1.p == n2.p
end

# function-like evaluation
@inline function (n::Negation)(args...)
    return evaluate(n, args...)
end

function evaluate(n::Negation, args...)
    assert_same_length(n, args...)
    return !evaluate(n.p, args...)
end
