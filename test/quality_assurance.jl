using MathematicalPredicates, Test
import Aqua

@testset "Aqua tests" begin
    Aqua.test_all(MathematicalPredicates;
                  # `contains` is a known piracy
                  piracies=(treat_as_own=Function[contains],))
end
