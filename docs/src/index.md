```@meta
CurrentModule = SimString
```

# SimString

Documentation for [SimString](https://github.com/PyDataBlog/SimString.jl).

A native Julia implementation of the CPMerge algorithm, which is designed for approximate string matching.
This package is be particulary useful for natural language processing tasks which require the retrieval of strings/texts from a very large corpora (big amounts of texts). Currently, this package supports both Character and Word based N-grams feature generations and there are plans to open the package up for custom user defined feature generation methods.

CPMerge Paper: [https://aclanthology.org/C10-1096/](https://aclanthology.org/C10-1096/)

## Features

- [X] Fast algorithm for string matching
- [X] 100% exact retrieval
- [X] Support for unicodes
- [X] Support for building databases directly from text files
- [X] Mecab-based tokenizer support for Japanese
- [ ] Custom user defined feature generation methods
- [ ] Support for persistent databases

## Suported String Similarity Measures

- [X] Dice coefficient
- [X] Jaccard coefficient
- [X] Cosine coefficient
- [X] Overlap coefficient
- [X] Exact match

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
# OR: db = DictDB(WordNGrams(2, " ")); for word based ngrams 
# OR  db = DictDB(MecabNGrams(2, " ", Mecab())) for Japanese ngrams. Requires installation of Mecab
push!(db, "foo");
push!(db, "bar");
push!(db, "fooo");

# Convinient approach is to use an array of strings for multiple entries: `append!(db, ["foo", "bar", "fooo"]);`

# OR: Build database from text files: `append!(db, "YOUR_FILE_NAME.txt");

# Retrieve the closest match(es)
res = search(Dice(), db, "foo"; α=0.8, ranked=true)
# 2-element Vector{Tuple{String, Float64}}:
#  ("foo", 1.0)
#  ("fooo", 0.8888888888888888)

# Describe a working database collection
desc = describe_collection(db)
# (total_collection = 3, avg_size_ngrams = 4.5, total_ngrams = 13)
```

## TODO: Benchmarks

## Release History

- 0.1.0 Initial release.
- 0.2.0 Added support for unicodes

```@index
```

```@autodocs
Modules = [SimString]
```
