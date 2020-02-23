"""
    Atom{N, T} <: Predicate{N}

An atomic predicate of arity `N`.

### Fields

- `p` -- Julia predicate
"""
struct Atom{N, T} <: Predicate{N}
    p::T

    function Atom(p::T; N::Int=1) where {T}
        return new{Val{N}, T}(p)
    end
end

function Base.:(==)(a1::Atom, a2::Atom)
    return a1.p == a2.p
end

# function-like evaluation
@inline function (a::Atom)(args...)
    evaluate(a, args...)
end

function evaluate(a::Atom, args...)
    assert_same_length(a, args...)
    return a.p(args...)
end
