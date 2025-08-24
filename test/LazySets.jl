using LazySets

S = Singleton([0.0, 0.0])
B1 = BallInf([0.0, 0.0], 1.0)
B2 = BallInf([1.0, 0.0], 0.5)
S_proj = project(S, [1])
B1_proj = project(B1, [1])
B2_proj = project(B2, [1])

P1 = X_subset_of(B1)
@test P1(S) && P1(B1) && !P1(B2)

P2 = X_superset_of(S)
@test P2(S) && P2(B1) && !P2(B2)

# dim is only available for SetAtom types
A1 = Atom(x -> x > 1)
@test_throws ArgumentError dim(A1)

# project is only available for SetAtom (and their Negation) types
@test_throws ArgumentError project(A1, [1])

@test project(Negation(P1), [1]) == Negation(project(P1, [1]))

@test dim(P1) == dim(P2) == 2
P1_proj = project(P1, [1])
P2_proj = project(P2, [1])
@test P1_proj isa SetAtom && dim(P1_proj) == 1 && P1_proj.X == B1_proj
@test P1_proj(S_proj) && P1_proj(B1_proj) && !P1_proj(B2_proj)
@test P2_proj isa SetAtom && dim(P2_proj) == 1 && P2_proj.X == S_proj
@test P2_proj(S_proj) && P2_proj(B1_proj) && !P2_proj(B2_proj)

Pc = Conjunction([P1, P2])
@test Pc(S) && Pc(B1) && !Pc(B2)

Pd = Disjunction([P1, P2])
@test Pd(S) && Pd(B1) && !Pd(B2)

@test project(Pc, [1]) == Conjunction([P1_proj, P2_proj])
@test project(Pd, [1]) == Disjunction([P1_proj, P2_proj])

P1 = X_disjoint_from(S)
P2 = X_intersects_with(S)
@test !P1(S) && !P1(B1) && P1(B2)
@test P2(S) && P2(B1) && !P2(B2)
