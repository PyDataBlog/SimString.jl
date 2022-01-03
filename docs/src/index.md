```@meta
CurrentModule = SimString
```

# SimString

Documentation for [SimString](https://github.com/PyDataBlog/SimString.jl).

A native Julia implementation of the CPMerge algorithm, which is designed for approximate string matching.
This package is be particulary useful for natural language processing tasks which demand the retrieval of strings/texts from a very large corpora (big amounts of texts). Currently, this package supports both Character and Word based N-grams feature generations and there are plans to open the package up for custom user defined feature generation methods.

## Features

- [X] Fast algorithm for string matching
- [X] 100% exact retrieval
- [X] Support for unicodes
- [ ] Custom user defined feature generation methods
- [ ] Mecab-based tokenizer support

## Suported String Similarity Measures

- [X] Dice coefficient
- [X] Jaccard coefficient
- [X] Cosine coefficient
- [X] Overlap coefficient

## Installation

You can grab the latest stable version of this package from Julia registries by simply running;

*NB:* Don't forget to invoke Julia's package manager with `]`

```julia
pkg> add SimString
```

The few (and selected) brave ones can simply grab the current experimental features by simply adding the master branch to your development environment after invoking the package manager with `]`:

```julia
pkg> add SimString#master
```

You are good to go with bleeding edge features and breakages!

To revert to a stable version, you can simply run:

```julia
pkg> free SimString
```

## Usage

```julia
using SimString

# Inilisate database and some strings
db = DictDB(CharacterNGrams(2, " "));
push!(db, "foo");
push!(db, "bar");
push!(db, "fooo");

# Convinient approach is to use an array of strings for multiple entries: `append!(db, ["foo", "bar", "fooo"]);`

# Retrieve the closest match(es)
res = search(Dice(), db, "foo"; α=0.8, ranked=true)
# 2-element Vector{Tuple{String, Float64}}:
#  ("foo", 1.0)
#  ("fooo", 0.8888888888888888)


```

## TODO: Benchmarks

## Release History

- 0.1.0 Initial release.

```@index
```

```@autodocs
Modules = [SimString]
```
