"""
    Conjunction{N, VT<:AbstractVector{<:Tuple{<:Predicate, <:AbstractVector{Int}}}} <: Predicate{N}

A conjunction of predicates of arity `N`.

### Fields

- `conjuncts` -- vector of conjuncts
"""
struct Conjunction{N,VT<:AbstractVector{<:Tuple{<:Predicate,<:AbstractVector{Int}}}} <: Predicate{N}
    conjuncts::VT

    function Conjunction(conjuncts::VT;
                         N::Int=maximum([length(v) for (p, v) in conjuncts])) where {VT<:AbstractVector{<:Tuple{<:Predicate,
                                                                                                                <:AbstractVector{Int}}}}
        return new{Val{N},VT}(conjuncts)
    end
end

# constructor for unary conjunction with only unary conjuncts
function Conjunction(conjuncts::AbstractVector{<:Predicate{Val{1}}})
    return Conjunction([(c, [1]) for c in conjuncts])
end

function Base.:(==)(c1::Conjunction, c2::Conjunction)
    return c1.conjuncts == c2.conjuncts
end

# function-like evaluation
@inline function (c::Conjunction)(args...)
    return evaluate(c, args...)
end

function evaluate(c::Conjunction, args...)
    assert_same_length(c, args...)
    @inbounds for (conjunct, n_args) in c.conjuncts
        if !evaluate(conjunct, args[n_args]...)
            return false
        end
    end
    return true
end
