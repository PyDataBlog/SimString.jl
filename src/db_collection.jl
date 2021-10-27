# Custom Collections
"""
"""
abstract type DBCollection end


"""
"""
abstract type DBContainer end


"""
"""
struct DictCollection <: DBCollection
    feature_extractor::FeatureExtractor
end


"""
"""
struct DictDB <: DBContainer
    feature_extractor::FeatureExtractor
    string_collection::Vector{AbstractString}
    string_size_map::AbstractSet{AbstractDict}
    string_feature_map::AbstractSet{AbstractDict}
end