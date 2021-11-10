# String Similarity Measure Definitions

"""
Abstract base type for all string similarity measures.
"""
abstract type AbstractSimilarityMeasure end


"""
Dice Similarity Measure.
"""
struct Dice <: AbstractSimilarityMeasure end


"""
Jaccard Similarity Measure.
"""
struct Jaccard <: AbstractSimilarityMeasure end


"""
Cosine Similarity Measure.
"""
struct Cosine <: AbstractSimilarityMeasure end


"""
Overlap Similarity Measure.
"""
struct Overlap <: AbstractSimilarityMeasure end

