# About

This page contains some general information about this project and
recommendations about contributing.

```@contents
Pages = ["about.md"]
```

## Contributing

If you like this package, consider contributing!

[Creating an issue](https://help.github.com/en/articles/creating-an-issue) in
the
[MathematicalPredicates GitHub issue tracker](https://github.com/JuliaReach/MathematicalPredicates.jl/issues)
to report a bug, open a discussion about existing functionality, or suggest new
functionality is appreciated.

If you have written code and would like it to be peer reviewed and added to the
library, you can [fork](https://help.github.com/en/articles/fork-a-repo) the
repository and send a pull request (see below).
Typical contributions include fixing a bug, adding a new feature, or improving
the documentation (either in source code or the
[online manual](https://juliareach.github.io/MathematicalPredicates.jl/latest/man/getting_started/)).

Below we give some general comments about contributing to this package.
The
[JuliaReach development documentation](https://juliareach.github.io/JuliaReachDevDocs/latest/)
describes coding guidelines; take a look when in doubt about the coding style
that is expected for the code that is finally merged into the library.

### Branches and pull requests (PR)

We use a standard pull request policy:
You work in a private branch and eventually add a pull request, which is then
reviewed by other programmers and merged into the `master` branch.

Each pull request should be pushed in a new branch with the name of the author
followed by a descriptive name, e.g., `mforets/my_feature`.
If the branch is associated to a previous discussion in an issue, we use the
name of the issue for easier lookup, e.g., `mforets/7`.

### Unit testing and continuous integration (CI)

This project is synchronized with GitHub Actions such that each PR gets tested
before merging (and the build is automatically triggered after each new commit).
For the maintainability of this project, it is important to make all unit tests
pass.

To run the unit tests locally, you can do:

```julia
julia> using Pkg

julia> Pkg.test("MathematicalPredicates")
```

We also advise adding new unit tests when adding new features to ensure
long-term support of your contributions.

### Contributing to the documentation

New functions and types should be documented according to the
[JuliaReach development documentation](https://juliareach.github.io/JuliaReachDevDocs/latest/guidelines/#Writing-docstrings-1).

You can view the source-code documentation from inside the REPL by typing `?`
followed by the name of the type or function.

```
julia> ?my_function
```

The documentation you are currently reading is written in
[Markdown](https://en.wikipedia.org/wiki/Markdown), and it relies on the package
[Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/) to produce
the final layout.
The sources for creating this documentation are found in `docs/src`.
You can easily include the documentation that you wrote for your functions or
types there (see the source code or
[`Documenter`'s guide](https://juliadocs.github.io/Documenter.jl/stable/man/guide/)
for examples).

To generate the documentation locally, run `make.jl`, e.g., by executing the
following command in the terminal:

```bash
$ julia --color=yes docs/make.jl
```

## Credits

Here we list the names of the maintainers of the `MathematicalPredicates.jl`
library, as well as past and present contributors (in alphabetic order).

### Core developers

- [Marcelo Forets](http://github.com/mforets)
- [Christian Schilling](https://www.christianschilling.net/)
