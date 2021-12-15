# Custom Collections

"""
Base type for all custom db collections.
"""
abstract type AbstractSimStringDB end


"""
Abstract type for feature extraction structs
"""
abstract type FeatureExtractor end


"""
Custom DB collection for storing SimString data using base Dictionary `Dict`
"""
struct DictDB{
    T1<:FeatureExtractor,
    T2<:AbstractString,
    T3<:AbstractDict{Int64, Set{String}},
    T4<:AbstractDict{Int64, DefaultOrderedDict{Vector{String}, Set{String}}}
    } <: AbstractSimStringDB

    feature_extractor::T1                       # NGram feature extractor
    string_collection::Vector{T2}               # Collection of strings in the DB
    string_size_map::T3                         # Index map of feature sizes
    string_feature_map::T4                      # Index map of all features with associated strings and sizes
end


function DictDB(x::FeatureExtractor)
    DictDB(
        x,
        String[],
        DefaultDict{Int, Set{String}}( () -> Set{String}() ),
        DefaultDict{ Int, DefaultOrderedDict{Vector{String}, Set{String}}  }( () -> DefaultOrderedDict{Vector{String}, Set{String} }(Set{String}))
    )
end
