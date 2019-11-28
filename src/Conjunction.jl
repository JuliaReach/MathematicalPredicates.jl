struct Conjunction{N, VT<:AbstractVector{<:Tuple{<:Predicate, <:AbstractVector{Int}}}} <: Predicate{N}
    conjuncts::VT

    function Conjunction(conjuncts::VT; N::Int=maximum([length(v) for (p, v) in conjuncts])
                        ) where {VT<:AbstractVector{<:Tuple{<:Predicate, <:AbstractVector{Int}}}}
        return new{Val{N}, VT}(conjuncts)
    end

    # constructor for unary conjunction with only unary conjuncts
    function Conjunction(conjuncts::AbstractVector{<:Predicate{Val{1}}})
        return Conjunction([(c, [1]) for c in conjuncts])
    end
end

function evaluate(c::Conjunction{N}, args...) where {N}
    assert_same_length(c, args...)
    for (conjunct, n_args) in c.conjuncts
        if !evaluate(conjunct, args[n_args]...)
            return false
        end
    end
    return true
end
