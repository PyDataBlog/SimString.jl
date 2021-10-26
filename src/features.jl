# Feature Extraction Definitions

abstract type FeatureExtractor end

struct CharacterNGrams <: FeatureExtractor
    n::Int
end

struct WordNGrams <: FeatureExtractor
    n::Int
end