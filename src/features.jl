# Feature Extraction Definitions

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
Internal function to create character-level ngrams features from an AbstractString
"""
function n_grams(extractor::CharacterNGrams, x, n)
    # Return counted n-grams (including duplicates)
    return cummulative_ngram_count(extractor, [x[i+1: i+n] for i in 0:length(x) - n])

end


"""
Internal function to create word-level ngrams from an AbstractVector
"""
function n_grams(extractor::WordNGrams, x, n)
    # [tuple(x[i+1: i+n]...) for i in 0:length(x) - n]
    init_grams = [x[i+1: i+n] for i in 0:length(x) - n]
    return cummulative_ngram_count(extractor, init_grams)
end


"""
Internal function to generate character-level ngrams features from an AbstractString
"""
function extract_features(extractor::CharacterNGrams, str)
    n = extractor.n - 1 == 0 ? 1 : extractor.n - 1
    str = pad_string(str, repeat(extractor.padder, n))
    return n_grams(extractor, str, extractor.n)
end


"""
Internal function to generate word-level ngrams features from an AbstractString
"""
function extract_features(extractor::WordNGrams, str)
    words_split = split(str, extractor.splitter)
    padded_words = pad_string(words_split, extractor.padder)
    return n_grams(extractor, padded_words, extractor.n)
end



# """
# Internal function to count and pad generated character-level ngrams (including duplicates)
# """
# function cummulative_ngram_count(extractor::CharacterNGrams, x)
#     p1 = sortperm(x)
#     p2 = sortperm(p1)
#     x = sort(x)

#     results = String[]
#     counter = 0
#     last_i, rest = Iterators.peel(x)

#     push!(results, string(last_i, "#",  counter += 1))

#     for i in rest
#         counter = i == last_i ? counter + 1 : 1
#         last_i = i
#         push!(results, string(i, "#", counter))
#     end
#     return results[p2]
# end


"""
Internal function to count and pad generated character-level ngrams (including duplicates)
"""
function cummulative_ngram_count(extractor::WordNGrams, x)
    p1 = sortperm(x)
    p2 = sortperm(p1)
    x = sort(x)

    results = Vector{Vector{String}}()
    counter = 0
    last_i, rest = Iterators.peel(x)

    push!(last_i, "#$(counter += 1)")
    push!(results, last_i)

    for i in rest
        counter = i == last_i[1:extractor.n] ? counter + 1 : 1
        last_i = i

        push!(last_i, "#$(counter)")
        push!(results, last_i)
    end
    return results[p2]
end


"""
Internal function to count and pad generated character-level ngrams (including duplicates)
"""
function cummulative_ngram_count(extractor::CharacterNGrams, x)
    counter = Dict{String, Int}()
    unique_list = Vector{Vector{String}}()

    for val in x
        if val in keys(counter)
            counter[val] += 1
        else
            counter[val] = 1
        end
        # push!(unique_list, string(val, "#", counter[val]))
        push!(unique_list, [val, string("#", counter[val])])
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
    @inbounds for i in str
        push!(db, i)
    end
end