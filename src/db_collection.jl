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
Feature extraction based on mecab word-level ngrams
"""
struct MecabNGrams{T1<:Int, T2<:AbstractString, T3<:Mecab} <: FeatureExtractor
    n::T1           # number of n-grams to extract
    padder::T2      # string to use to pad n-grams
    tokenizer::T3   # Mecab tokenizer to use
end