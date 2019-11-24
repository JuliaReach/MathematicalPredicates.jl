struct Atom{N, T} <: Predicate{N}
    p::T

    function Atom(p::T; N::Int=1) where {T}
        return new{Val{N}, T}(p)
    end
end

function evaluate(a::Atom{N}, args...) where {N}
    assert_same_length(a, args...)
    return a.p(args...)
end
