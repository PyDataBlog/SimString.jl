# String Similarity Measure Definitions

abstract type AbstractSimilarityMeasure end

struct Dice <: AbstractSimilarityMeasure end

struct Jaccard <: AbstractSimilarityMeasure end

struct Cosine <: AbstractSimilarityMeasure end

