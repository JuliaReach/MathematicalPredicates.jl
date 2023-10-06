using Documenter, MathematicalPredicates
import LazySets

DocMeta.setdocmeta!(MathematicalPredicates, :DocTestSetup,
                    :(using MathematicalPredicates); recursive=true)

makedocs(; sitename="MathematicalPredicates.jl",
         modules=[MathematicalPredicates],
         format=Documenter.HTML(; prettyurls=get(ENV, "CI", nothing) == "true",
                                assets=["assets/aligned.css"]),
         pagesonly=true,
         pages=["Home" => "index.md",
                "Library" => ["Predicates" => "lib/predicates.md",
                              "LazySets integration" => "lib/LazySets.md"],
                "About" => "about.md"])

deploydocs(; repo="github.com/JuliaReach/MathematicalPredicates.jl.git",
           push_preview=true)
