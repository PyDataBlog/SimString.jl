# Main SimString search algorithm

"""
    search(measure::AbstractSimilarityMeasure, db_collection::AbstractSimStringDB, query::AbstractString;
        α=0.7, ranked=true)

Search for strings in a string collection using the SimString algorithm and a
similarity measure.

# Arguments:
* `measure`::AbstractSimilarityMeasure - The similarity measure to use.
* `db_collection`::AbstractSimStringDB - The database collection to search.
* `query`::AbstractString - The query string to search for.
* `α`::float - The α parameter for the SimString algorithm.
* `ranked`::Boolean - Whether to return the results in ranked order.

# Example
```julia
db = DictDB(CharacterNGrams(2, " "));
append!(db, ["foo", "bar", "fooo"]);

search(Dice(), db, "foo"; α=0.8, ranked=true)
# 2-element Vector{Tuple{String, Float64}}:
#  ("foo", 1.0)
#  ("fooo", 0.8888888888888888)
```

# Returns
* A Vector of results, where each element is a Tuple of the form (`string`, `similarity measure score`).
"""
function search(measure::AbstractSimilarityMeasure, db_collection::AbstractSimStringDB, query::AbstractString; α=0.7, ranked=true)
    return search!(measure, db_collection, query; α=α, ranked=ranked)
end


"""
Internal function which ranks the results of a search using the specified similarity measure.
"""
function rank_search_results(measure::AbstractSimilarityMeasure, db_collection::DictDB, query, results; ranked=true)
    features = extract_features(db_collection.feature_extractor, query)

    # Compute similarity scores for each result
    ranked_results = map(results) do x
        x, similarity_score(measure, features, extract_features(db_collection.feature_extractor, x) )
    end

    # Sort by similarity score and return
    return ranked ? sort(ranked_results, by = i -> i[2], rev=true) : ranked_results
end


"""
Internal function which performs the overlap join
"""
function overlap_join(db_collection::AbstractSimStringDB, features, τ, candidate_size)
    # length of features
    query_feature_length = length(features)

    # Sort features from the most uncommon and the most common
    features = sort(features, by = i -> length(lookup_feature_set_by_size_feature(db_collection, candidate_size, i) ) )

    # Count the occurrences of each feature
    candidate_match_counts = DefaultDict{String, Int}(0)
    feature_slice_index = query_feature_length - τ + 1
    idx = query_feature_length - τ
    focus_features = feature_slice_index < 0 ? (@view features[0:end + feature_slice_index]) : (@view features[0:idx])

    @inbounds @views for i in focus_features
        for s in lookup_feature_set_by_size_feature(db_collection, candidate_size, i)
            candidate_match_counts[s] += 1
        end
    end

    results = String[]

    for (candidate, match_count) in candidate_match_counts
        for i in (query_feature_length - τ + 1) : query_feature_length # TODO: Verify
            if candidate in lookup_feature_set_by_size_feature(db_collection, candidate_size, features[i])
                match_count += 1
            end

            if match_count >= τ
                append!(results, [candidate])
                break
            end

            remaining_count = query_feature_length - i - 1
            if (match_count + remaining_count) < τ
                break
            end
        end
    end
    return results
end


"""
Search for strings in custom DictDB string collection using the SimString algorithm
and a similarity measure.
"""
function search!(measure::AbstractSimilarityMeasure, db_collection::DictDB, query::AbstractString; α=0.7, ranked=true)
    # Generate features from query string
    features = extract_features(db_collection.feature_extractor, query)

    # Metadata from the generated features (length, min & max sizes)
    length_of_features = length(features)
    min_feature_size = minimum_feature_size(measure, length_of_features, α)
    max_feature_size = maximum_feature_size(measure, db_collection, length_of_features, α)

    results = String[]

    # Generate and return results from the potential candidate size pool
    @inbounds for candidate_size in min_feature_size:max_feature_size
        # Minimum overlap
        τ = minimum_overlap(measure, length_of_features, candidate_size, α)

        # Generate approximate candidates from the overlap join
        append!(results, overlap_join(db_collection, features, τ, candidate_size))
    end

    # Rank search results
    return rank_search_results(measure, db_collection, query, results; ranked=ranked)
end