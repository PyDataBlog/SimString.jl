# Main SimString search algorithm

"""
Search for strings in a string collection using the SimString algorithm and a
similarity measure.
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
    candidate_match_counts = DefaultDict(0)

    feature_slice_index = query_feature_length - τ + 1

    if feature_slice_index < 0
        focus_features = features[1:end + feature_slice_index]
    else
        focus_features = features[1:feature_slice_index]
    end

    for i in focus_features
        for s in lookup_feature_set_by_size_feature(db_collection, candidate_size, i)
            candidate_match_counts[s] += 1
        end
    end

    results = String[]

    # TODO: Return results in case of a perfect match??
    # if τ == 1
    #     results = collect(keys(candidate_match_counts))
    # end

    for (candidate, match_count) in candidate_match_counts

        for i in (query_feature_length - τ + 1) : query_feature_length - 1  # TODO: Verify

            if i < 0
                feature = features[end + i]
            elseif i == 0
                feature = features[i+1]
            else
                feature = features[i]

            end

            if candidate in lookup_feature_set_by_size_feature(db_collection, candidate_size, feature)
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

    # TODO: Metadata from the generated features (length, min & max sizes)
    length_of_features = length(features)
    min_feature_size = minimum_feature_size(measure, length_of_features, α)
    max_feature_size = maximum_feature_size(measure, db_collection, length_of_features, α)

    results = String[]

    # TODO: Generate and return results from the potential candidate size pool
    for candidate_size in min_feature_size:max_feature_size
        # Minimum overlap
        τ = minimum_overlap(measure, length_of_features, candidate_size, α)
        append!(results, overlap_join(db_collection, features, τ, candidate_size))
    end

    # TODO: Rank search results
    return rank_search_results(measure, db_collection, query, results; ranked=ranked)
end