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
struct DictDB{T1<:FeatureExtractor, T2<:AbstractString, T3<:AbstractDict} <: AbstractSimStringDB
    feature_extractor::T1
    string_collection::Vector{T2}
    string_size_map::T3       # AbstractDict{Int64, Set{String}}
    string_feature_map::T3    # AAbstractDict{Int64, AbstractDict{String, Set{String}}}
end
