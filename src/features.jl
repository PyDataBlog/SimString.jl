"""
Internal function to pad AbstractString types with specified padder
"""
function pad_string(x::AbstractString, padder::AbstractString)
    return string(padder, x, padder)
end


"""
Internal function to pad AbstractVector types with specified padder
"""
function pad_string(x::AbstractVector, padder::AbstractString)
    # Insert a padder as the first and last element of x
    insert!(x, 1, padder)
    push!(x, padder)
    return x
end


"""
Internal function to generate intial uncounted ngrams on a character level
"""
function init_ngrams(extractor::CharacterNGrams, x, n)
    map(0:length(x)-n) do i
        x[i+1: i+n]
    end
end


"""
Internal function to generate intial uncounted ngrams on a word level
"""
function init_ngrams(extractor::WordNGrams, x, n)
    map(0:length(x)-n) do i
        tuple(String.(x[i+1: i+n])...)
    end
end


"""
Internal function to create character-level ngrams features from an AbstractString
"""
function n_grams(extractor::CharacterNGrams, x, n)
    # Return counted n-grams (including duplicates)
    return cummulative_ngram_count(init_ngrams(extractor, x, n))
end


"""
Internal function to create word-level ngrams from an AbstractVector
"""
function n_grams(extractor::WordNGrams, x, n)
    return cummulative_ngram_count(init_ngrams(extractor, x, n))
end


"""
Internal function to make zero indexed circular arrays
"""
function make_zero_index_circular_array(x)
    return CircularArray(OffsetArray(x, 0:length(x)-1))
end


"""
Internal function to generate character-level ngrams features from an AbstractString
"""
function extract_features(extractor::CharacterNGrams, str)
    n = extractor.n - 1 == 0 ? 1 : extractor.n - 1
    str = pad_string(str, repeat(extractor.padder, n))
    # str = pad_string(str, repeat(extractor.padder, extractor.n))
    return make_zero_index_circular_array(n_grams(extractor, str, extractor.n))
end


"""
Internal function to generate word-level ngrams features from an AbstractString
"""
function extract_features(extractor::WordNGrams, str)
    words_split = split(str, extractor.splitter)
    padded_words = pad_string(words_split, extractor.padder)
    return make_zero_index_circular_array(n_grams(extractor, padded_words, extractor.n))
end


"""
Internal function to count and pad generated character-level ngrams (including duplicates)
"""
function cummulative_ngram_count(x)
    counter = Dict{eltype(x), Int}()

    unique_list = map(x) do val
        if val in keys(counter)
            counter[val] += 1
        else
            counter[val] = 1
        end
        (val, counter[val])
    end

    return unique_list
end


"""
Add a new item to a new or existing collection of strings using
the custom AbstractSimStringDB type.
"""
function push!(db::AbstractSimStringDB, str::AbstractString)
    # Extract features based on the specified feature extractor
    features = extract_features(db.feature_extractor, str)

    # Size of the new feature
    size = length(features)

    # Add the string to the database
    push!(db.string_collection, str)

    # Add the size of the incoming string to size map
    push!(db.string_size_map[size], str)

    # Map each feature to a size map along with the originating string
    @inbounds for n in features
        push!(db.string_feature_map[size][n], str)
    end

    return db
end


"""
Add bulk items to a new or existing collection of strings using
the custom AbstractSimStringDB type.
"""
function append!(db::AbstractSimStringDB, str::Vector)
    @inbounds @simd for i in str
        push!(db, i)
    end
end