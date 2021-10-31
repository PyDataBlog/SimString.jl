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
    str = pad_string(str, extractor.n)
    return n_grams(str, extractor.n)
end


"""
"""
function extract_features(extractor::WordNGrams, str::AbstractString)
    str = pad_string(str, extractor.n)
    split_words = split(str, extractor.splitter)
    return n_grams(split_words, extractor.n)
end