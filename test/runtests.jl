using Test, MathematicalPredicates

# atom
a0 = Atom(() -> true; N=0)
a1 = Atom(x -> x > 1)
a2 = Atom((x, y) -> x > y; N=2)

@test evaluate(a0)
@test evaluate(a1, 4)
@test !evaluate(a2, 4, 5)
@test evaluate(a2, 6, 5)

# negation
n0 = Negation(a0)
n1 = Negation(a1)
n2 = Negation(a2)

@test !evaluate(n0)
@test !evaluate(n1, 4)
@test evaluate(n2, 4, 5)
@test !evaluate(n2, 6, 5)

# conjunction
c0 = Conjunction([(n0, Int[]), (a0, Int[])]; N=0)
c0_3 = Conjunction([(a0, Int[]), (a0, Int[]), (a0, Int[])]; N=0)
c1 = Conjunction([(a0, Int[]), (a1, Int[1])]; N=1)
c1_3 = Conjunction([(a0, Int[]), (a1, Int[1]), (a1, Int[1])]; N=1)
c2 = Conjunction([(a2, Int[2, 1]), (a2, Int[1, 2])]; N=2)
c2_3 = Conjunction([(a0, Int[]), (a1, Int[2]), (a2, Int[2, 1])]; N=2)

@test !evaluate(c0)
@test evaluate(c0_3)
@test evaluate(c1, 4)
@test evaluate(c1_3, 4)
@test !evaluate(c2, 4, 5)
@test evaluate(c2_3, 4, 5)

# disjunction
d0 = Disjunction([(n0, Int[]), (a0, Int[])]; N=0)
d0_3 = Disjunction([(n0, Int[]), (n0, Int[]), (n0, Int[])]; N=0)
d1 = Disjunction([(c0, Int[]), (a1, Int[1])]; N=1)
d1_3 = Disjunction([(a0, Int[]), (a1, Int[1]), (a1, Int[1])]; N=1)
d2 = Disjunction([(a2, Int[2, 1]), (a2, Int[1, 2])]; N=2)
d2_3 = Disjunction([(a0, Int[]), (a1, Int[2]), (a2, Int[2, 1])]; N=2)

@test evaluate(d0)
@test !evaluate(d0_3)
@test evaluate(d1, 4)
@test evaluate(d1_3, 4)
@test evaluate(d2, 4, 5)
@test evaluate(d2_3, 4, 5)

# unary conjunction
cu = Conjunction([n1, a1])
cu_3 = Conjunction([c1, a1, d1])

@test !evaluate(cu, 5)
@test evaluate(cu_3, 5)

# unary disjunction
du = Disjunction([n1, a1])
du_1 = Disjunction([n1])

@test evaluate(du, 5)
@test !evaluate(du_1, 5)
