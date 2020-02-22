using LazySets

S = Singleton([0.0, 0.0])
B1 = BallInf([0.0, 0.0], 1.0)
B2 = BallInf([1.0, 0.0], 0.5)

P1 = iscontainedin(B1)
@test P1(S) && P1(B1) && !P1(B2)

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
