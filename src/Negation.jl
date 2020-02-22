struct Negation{N, T<:Predicate{N}} <: Predicate{N}
    p::T

    function Negation(p::T) where {T<:Predicate{N}} where {N}
        return new{N, T}(p)
    end
end

# function-like evaluation
@inline function (n::Negation)(args...)
    evaluate(n, args...)
end

function evaluate(n::Negation, args...)
    assert_same_length(n, args...)
    return !evaluate(n.p, args...)
end
