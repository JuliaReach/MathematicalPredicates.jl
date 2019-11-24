abstract type Predicate{N} end

function assert_same_length(::Predicate{Val{n}}, args...) where {n}
    @assert length(args) == n "incompatible number of arguments " *
        "($(length(args)) vs. $n)"
end
