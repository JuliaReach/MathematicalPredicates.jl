using MathematicalPredicates, Test
import Aqua

@testset "Aqua tests" begin
    # Requires is only used in old versions
    @static if VERSION >= v"1.9"
        stale_deps = (ignore=[:Requires],)
    else
        stale_deps = true
    end

    Aqua.test_all(MathematicalPredicates; stale_deps=stale_deps,
                  # `contains` is a known piracy
                  piracies=(treat_as_own=Function[contains],))
end
