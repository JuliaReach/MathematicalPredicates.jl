using LazySets

S = Singleton([0.0, 0.0])
B1 = BallInf([0.0, 0.0], 1.0)
B2 = BallInf([1.0, 0.0], 0.5)
S_proj = project(S, [1])
B1_proj = project(B1, [1])
B2_proj = project(B2, [1])

P1 = iscontainedin(B1)
@test P1(S) && P1(B1) && !P1(B2)

@test dim(P1) == 2
P1_proj = project(P1, [1])
@test P1_proj isa SetAtom && dim(P1_proj) == 1 && P1_proj.X == B1_proj
@test P1_proj(S_proj) && P1_proj(B1_proj) && !P1_proj(B2_proj)

P2 = contains(S)
@test P2(S) && P2(B1) && !P2(B2)

Pc = Conjunction([P1, P2])
@test Pc(S) && Pc(B1) && !Pc(B2)

Pd = Disjunction([P1, P2])
@test Pd(S) && Pd(B1) && !Pd(B2)

P1 = isdisjointfrom(S)
P2 = intersects(S)
@test !P1(S) && !P1(B1) && P1(B2)
@test P2(S) && P2(B1) && !P2(B2)
