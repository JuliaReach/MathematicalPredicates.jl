using MathematicalPredicates, Test
import Aqua

import Pkg
@static if VERSION >= v"1.6"  # TODO make explicit test requirement
    Pkg.add("ExplicitImports")
    import ExplicitImports

    @testset "ExplicitImports tests" begin
        ignores = (:isdisjoint,)  # due to workaround with old version
        @test isnothing(ExplicitImports.check_all_explicit_imports_are_public(MathematicalPredicates;
                                                                              ignore=ignores))
        @test isnothing(ExplicitImports.check_all_explicit_imports_via_owners(MathematicalPredicates;
                                                                              ignore=ignores))
        @test isnothing(ExplicitImports.check_all_qualified_accesses_are_public(MathematicalPredicates))
        @test isnothing(ExplicitImports.check_all_qualified_accesses_via_owners(MathematicalPredicates))
        @test isnothing(ExplicitImports.check_no_implicit_imports(MathematicalPredicates))
        @test isnothing(ExplicitImports.check_no_self_qualified_accesses(MathematicalPredicates))
        @test isnothing(ExplicitImports.check_no_stale_explicit_imports(MathematicalPredicates))
    end
end

@testset "Aqua tests" begin
    Aqua.test_all(MathematicalPredicates;
                  # `contains` is a known piracy
                  piracies=(treat_as_own=Function[contains],))
end
