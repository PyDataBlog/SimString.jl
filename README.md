# SimString

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://PyDataBlog.github.io/SimString.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://PyDataBlog.github.io/SimString.jl/dev)
[![Build Status](https://github.com/PyDataBlog/SimString.jl/workflows/CI/badge.svg)](https://github.com/PyDataBlog/SimString.jl/actions)
[![Coverage](https://codecov.io/gh/PyDataBlog/SimString.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/PyDataBlog/SimString.jl)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![ColPrac: Contributor's Guide on Collaborative Practices for Community Packages](https://img.shields.io/badge/ColPrac-Contributor's%20Guide-blueviolet)](https://github.com/SciML/ColPrac)

A native Julia implementation of the CPMerge algorithm, which is designed for approximate string matching.
This package is be particulary useful for natural language processing tasks which demand the retrieval of strings/texts from a very large corpora (big amounts of texts). Currently, this package supports both Character and Word based N-grams feature generations and there are plans to open the package up for custom user defined feature generation methods.

## Features

- [X] Fast algorithm for string matching
- [X] 100% exact retrieval
- [X] Support for unicodes
- [X] Support for building databases directly from text files
- [X] Mecab-based tokenizer support
- [ ] Support for persistent databases like MongoDB

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
pkg> add SimString#main
```

You are good to go with bleeding edge features and breakages!

To revert to a stable version, you can simply run:

```julia
pkg> free SimString
```
