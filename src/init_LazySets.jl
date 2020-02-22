export contains, iscontainedin, isdisjointfrom, intersects

using .LazySets: LazySet, ⊆, isdisjoint

function contains(X::LazySet)
    return Atom(Y -> X ⊆ Y; N=1)
end

function iscontainedin(X::LazySet)
    return Atom(Y -> Y ⊆ X; N=1)
end

function isdisjointfrom(X::LazySet)
    return Atom(Y -> isdisjoint(X, Y); N=1)
end

function intersects(X::LazySet)
    return Negation(isdisjointfrom(X))
end
