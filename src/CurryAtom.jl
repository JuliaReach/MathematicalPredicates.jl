
"""
    CurryAtom{N,A,T} <: Predicate{N}

An atomic predicate of arity `N` defined via a fixed first argument and an
`N+1`-ary predicate.

### Fields

- `arg1` -- first argument
- `p`    -- `N+1`-ary predicate that takes `arg1` as first argument
"""
struct CurryAtom{N,A,T<:Predicate} <: Predicate{N}
    arg1::A
    p::T

    function CurryAtom(arg1::A, p::T; N::Int=1) where {A,T<:Predicate}
        return new{Val{N},A,T}(arg1, p)
    end
end

# function-like evaluation
@inline function (ca::CurryAtom)(args...)
    return evaluate(ca, args...)
end

function evaluate(ca::CurryAtom, args...)
    assert_same_length(ca, args...)
    return evaluate(ca.p, ca.arg1, args...)
end

function Base.:(==)(ca1::CurryAtom, ca2::CurryAtom)
    return ca1.arg1 == ca2.arg1 && ca1.p == ca2.p
end
