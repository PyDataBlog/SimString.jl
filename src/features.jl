# Feature Extraction Definitions

"""
"""
abstract type FeatureExtractor end


"""
"""
struct CharacterNGrams <: FeatureExtractor
    n::Int                      # number of n-grams to extract
    padder::AbstractString      # string to use to pad n-grams
end


"""
"""
struct WordNGrams <: FeatureExtractor
    n::Int                      # number of n-grams to extract
    padder::AbstractString      # string to use to pad n-grams
    splitter::AbstractString    # string to use to split words
end


"""
"""
function pad_string(x, padder)
    return string(padder, x, padder)
end


"""
"""
function n_grams(x, n)
    return Set(x[i+1: i+n] for i in 0:length(x) - n)
end


"""
"""
function extract_features(extractor::CharacterNGrams, str::AbstractString)
    str = pad_string(str, extractor.n)
    return n_grams(str, extractor.n)
end


"""
"""
function extract_features(extractor::WordNGrams, str::AbstractString)
    str = pad_string(str, extractor.n)
    return n_grams(split(str, extractor.splitter), extractor.n)
end