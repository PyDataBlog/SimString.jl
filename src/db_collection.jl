# Custom Collections

"""
Base type for all custom db collections.
"""
abstract type AbstractSimStringDB end


"""
Abstract type for feature extraction structs
"""
abstract type FeatureExtractor end


# Feature Extraction Definitions

"""
Feature extraction on character-level ngrams
"""
struct CharacterNGrams{T1<:Int, T2<:AbstractString} <: FeatureExtractor
    n::T1         # number of n-grams to extract
    padder::T2    # string to use to pad n-grams
end


"""
Feature extraction based on word-level ngrams
"""
struct WordNGrams{T1<:Int, T2<:AbstractString} <: FeatureExtractor
    n::T1           # number of n-grams to extract
    padder::T2      # string to use to pad n-grams
    splitter::T2    # string to use to split words
end


"""
Custom DB collection for storing SimString data using base Dictionary `Dict`
"""
struct DictDB{
    T1<:FeatureExtractor,
    T2<:AbstractString,
    T3<:AbstractDict,
    T4<:AbstractDict ,
    } <: AbstractSimStringDB

    feature_extractor::T1                       # NGram feature extractor
    string_collection::Vector{T2}               # Collection of strings in the DB
    string_size_map::T3                         # Index map of feature sizes
    string_feature_map::T4                      # Index map of all features with associated strings and sizes
end


"""
"""
function DictDB(x::CharacterNGrams)
    DictDB(
        x,
        String[],
        DefaultDict{Int, Set{String}}( () -> Set{String}() ),
        DefaultDict{ Int, DefaultOrderedDict{Tuple{String, Int64}, Set{String}}  }( () -> DefaultOrderedDict{Tuple{String, Int64}, Set{String} }(Set{String}))
    )
end


"""
"""
function DictDB(x::WordNGrams)
    DictDB(
        x,
        String[],
        DefaultDict{Int, Set{String}}( () -> Set{String}() ),
        DefaultDict{ Int, DefaultOrderedDict{Tuple{NTuple{x.n, String}, Int}, Set{String}}  }( () -> DefaultOrderedDict{Tuple{NTuple{x.n, String}, Int}, Set{String} }(Set{String}))
    )
end