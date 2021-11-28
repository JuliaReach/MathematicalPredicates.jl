using Documenter, MathematicalPredicates
import LazySets

DocMeta.setdocmeta!(MathematicalPredicates, :DocTestSetup,
                    :(using MathematicalPredicates); recursive=true)

makedocs(
    sitename = "MathematicalPredicates.jl",
    modules = [MathematicalPredicates],
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        assets = ["assets/juliareach.css"]),
    pages = [
        "Home" => "index.md",
        "About" => "about.md"
    ],
    strict = true
)

deploydocs(
    repo = "github.com/JuliaReach/MathematicalPredicates.jl.git"
)
