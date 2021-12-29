# Main SimString search algorithm

"""
Search for strings in a string collection using the SimString algorithm and a
similarity measure.
"""
function search(mesasure::AbstractSimilarityMeasure, db_collection::AbstractSimStringDB, query::AbstractString; α=0.7, ranked=true)
    return search!(mesasure, db_collection, query; α=α, ranked=ranked)
end



"""
"""
function overlap_join(db::AbstractSimStringDB, features, τ, candidate_size)
    # TODO: length of features

    # TODO: Sort features from the most uncommon and the most common

    # TODO: Implement overlap join
end


"""
Search for strings in custom DictDB string collection using the SimString algorithm
and a similarity measure.
"""
function search!(mesasure::AbstractSimilarityMeasure, db_collection::DictDB, query::AbstractString; α=0.7, ranked=true)
    # TODO: Generate features from query string

    # TODO: Metadata from the generated features (length, min & max sizes)

    # TODO: Count occurence of candidates to be matched

    # TODO: Generate and return results from the potential candidate size pool
end