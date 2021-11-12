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


"""
Calculate minimum feature size for Dice similarity measure.
"""
function minimum_feature_size(measure::Dice, query_size, α)
    return ceil(Int, ( (α / (2 - α)) * query_size) )
end


"""
Calculate minimum feature size for Jaccard similarity measure.
"""
function minimum_feature_size(measure::Jaccard, query_size, α)
    return ceil(Int, (α * query_size))
end


"""
Calculate minimum feature size for Cosine similarity measure.
"""
function minimum_feature_size(measure::Cosine, query_size, α)
    return ceil(Int, (α * α * query_size) )
end


"""
Calculate maximum feature size for Dice similarity measure.
"""
function maximum_feature_size(measure::Dice, query_size, α)
    return floor(Int, ( ((2 - α) / α) * query_size) )
end


"""
Calculate maximum feature size for Jaccard similarity measure.
"""
function maximum_feature_size(measure::Jaccard, query_size, α)
    return floor(Int, (query_size / α))
end


"""
Calculate maximum feature size for Cosine similarity measure.
"""
function maximum_feature_size(measure::Cosine, query_size, α)
    return floor(Int, ( query_size / (α * α) ))
end


"""
Calculate similarity score between X and Y using Dice similarity measure.
"""
function similarity_score(measure::Dice, X, Y)
    return 2 * ( length( X ∩ Y ) ) / ( length(X) + length(Y) )
end


"""
Calculate similarity score between X and Y using Jaccard similarity measure.
"""
function similarity_score(measure::Jaccard, X, Y)
    return length( X ∩ Y ) / ( length( X ∪ Y ) )
end


"""
Calculate similarity score between X and Y using Cosine similarity measure.
"""
function similarity_score(measure::Cosine, X, Y)
    return length( X ∩ Y ) / ( √(length(X) * length(Y)) )
end


"""
Calculate similarity score between X and Y using Overlap similarity measure.
"""
function similarity_score(measure::Overlap, X, Y)
    return length( X ∩ Y ) / min(length(X), length(Y))
end


"""
Calculate the minimum overlap for a query size, candidate size, and α
using Dice similarity measure.
"""
function minimum_overlap(measure::Dice, query_size, candidate_size, α)
    return ceil(Int, (0.5 * α * query_size * candidate_size))
end


"""
Calculate the minimum overlap for a query size, candidate size, and α
using Jaccard similarity measure.
"""
function minimum_overlap(measure::Jaccard, query_size, candidate_size, α)
    return ceil(Int,  ((α * (query_size + candidate_size)) / (1 + α)) )
end


"""
Calculate the minimum overlap for a query size, candidate size, and α
using Cosine similarity measure.
"""
function minimum_overlap(measure::Cosine, query_size, candidate_size, α)
    return ceil(Int, ( α * √(query_size * candidate_size) ))
end


"""
Calculate the minimum overlap for a query size, candidate size, and α
using Overlap similarity measure.
"""
function minimum_overlap(measure::Overlap, query_size, candidate_size, α)
    return ceil(Int, (α * min(query_size, candidate_size)) )
end