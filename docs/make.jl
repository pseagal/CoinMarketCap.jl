using CoinMarketCap
using Documenter

DocMeta.setdocmeta!(CoinMarketCap, :DocTestSetup, :(using CoinMarketCap); recursive = true)

makedocs(;
    modules = [CoinMarketCap],
    sitename = "CoinMarketCap.jl",
    format = Documenter.HTML(;
        repolink = "https://github.com/bhftbootcamp/CoinMarketCap.jl",
        canonical = "https://bhftbootcamp.github.io/CoinMarketCap.jl",
        edit_link = "master",
        assets = ["assets/favicon.ico"],
        sidebar_sitename = true,  # Set to 'false' if the package logo already contain its name
    ),
    pages = [
        "Home"    => "index.md",
        "Content" => "pages/content.md",
        # Add your pages here ...
    ],
    warnonly = [:doctest, :missing_docs],
)

deploydocs(;
    repo = "github.com/bhftbootcamp/CoinMarketCap.jl",
    devbranch = "master",
    push_preview = true,
)
