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
function extract_features(extractor::CharacterNGrams, str::AbstractString)
    str = string(extractor.padder, str, extractor.padder)

    return Set( str[i+1:i+extractor.n] for i in 0: (length(str) - extractor.n) )
end


"""
"""
function extract_features(extractor::WordNGrams, str::AbstractString)
    str = string(extractor.padder, str, extractor.padder)
end