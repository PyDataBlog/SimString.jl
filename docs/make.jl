using SimString
using Documenter

DocMeta.setdocmeta!(SimString, :DocTestSetup, :(using SimString); recursive=true)

makedocs(;
    modules=[SimString],
    authors="Bernard Brenyah",
    repo="https://github.com/PyDataBlog/SimString.jl/blob/{commit}{path}#{line}",
    sitename="SimString.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://PyDataBlog.github.io/SimString.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/PyDataBlog/SimString.jl",
    devbranch="main",
)
