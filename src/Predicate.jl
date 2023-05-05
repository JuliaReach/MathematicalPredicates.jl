"""
    Predicate{N}

The abstract supertype of predicates.
"""
abstract type Predicate{N} end

"""
    evaluate(p::Predicate, args...)

Evaluate a predicate for given arguments.

### Input

- `p`    -- predicate
- `args` -- argument list

### Output

A `Bool` corresponding to the evaluation of `p(args)`.

### Notes

We offer `p(args)` as a short-hand version of `evaluate(p, args)`.
"""
function evaluate end

function assert_same_length(::Predicate{Val{n}}, args...) where {n}
    @assert length(args) == n "incompatible number of arguments " *
                              "($(length(args)) vs. $n)"
end
