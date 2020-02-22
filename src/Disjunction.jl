struct Disjunction{N, VT<:AbstractVector{<:Tuple{<:Predicate, <:AbstractVector{Int}}}} <: Predicate{N}
    disjuncts::VT

    function Disjunction(disjuncts::VT; N::Int=maximum([length(v) for (p, v) in disjuncts])
                        ) where {VT<:AbstractVector{<:Tuple{<:Predicate, <:AbstractVector{Int}}}}
        return new{Val{N}, VT}(disjuncts)
    end
end
# constructor for unary disjunction with only unary disjuncts
function Disjunction(disjuncts::AbstractVector{<:Predicate{Val{1}}})
    return Disjunction([(d, [1]) for d in disjuncts])
end

# function-like evaluation
@inline function (d::Disjunction)(args...)
    evaluate(d, args...)
end

function evaluate(d::Disjunction, args...)
    assert_same_length(d, args...)
    for (conjunct, n_args) in d.disjuncts
        if evaluate(conjunct, args[n_args]...)
            return true
        end
    end
    return false
end
