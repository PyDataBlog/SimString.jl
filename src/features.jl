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

end


"""
"""
function extract_features(extractor::WordNGrams, str::AbstractString)

end