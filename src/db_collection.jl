# Custom Collections

"""
"""
abstract type AbstractSimStringDB end


# """
# """
# abstract type DBContainer end


"""
"""
struct DictDB <: AbstractSimStringDB
    feature_extractor::FeatureExtractor
end


# """
# """
# struct DictDBResult <: DBContainer
#     feature_extractor::FeatureExtractor
#     string_collection::Vector{AbstractString}
#     string_size_map::AbstractSet{AbstractDict}
#     string_feature_map::AbstractSet{AbstractDict}
# end