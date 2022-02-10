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
    # TODO: Insert a padder as the first and last element of x with undef
    insert!(x, 1, padder)
    push!(x, padder)
    return x
end


"""
Internal function to generate intial uncounted ngrams on a character level
"""
function init_ngrams(extractor::CharacterNGrams, x, n)
    # TODO: Use rule length(x) - n + 1 to initiate non allocated ngrams
    map(0:length(x)-n) do i
        x[i+1: i+n]
    end
end


"""
Internal function to generate intial uncounted ngrams on a word level
"""
function init_ngrams(extractor::WordNGrams, x, n)
    # TODO: Use rule results = length(x) - n + 1 to initiate non allocated ngrams
    map(0:length(x)-n) do i
        tuple(String.(x[i+1: i+n])...)
    end
end


"""
Internal function to create character-level ngrams features from an AbstractString
"""
function n_grams(extractor::CharacterNGrams, x, n)
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
    # TODO: Use length of x initiate non allocated ngrams
    counter = Dict{eltype(x), Int}()

    return map(x) do val
        if val in keys(counter)
            counter[val] += 1
        else
            counter[val] = 1
        end
        (val, counter[val])
    end
end


"""
    push!(db::AbstractSimStringDB, str::AbstractString)

Add a new item to a new or existing collection of strings using
the custom AbstractSimStringDB type.

# Arguments:
* `db`: AbstractSimStringDB - The collection of strings to add to
* `str`: AbstractString - The string to add to the collection

# Example:
```julia
db = DictDB(CharacterNGrams(2, " "));
push!(db, "foo")
push!(db, "bar")
push!(db, "fooo")
````

# Returns:
* `db`: AbstractSimStringDB - The collection of strings with the new string added
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
    append!(db::AbstractSimStringDB, str::Vector)

Add bulk items to a new or existing collection of strings using
the custom AbstractSimStringDB type.

# Arguments:
* db: AbstractSimStringDB - The database to add the strings to
* str: Vector of AbstractString - Vector/Array of strings to add to the database

# Example:
```julia
db = DictDB(CharacterNGrams(2, " "));
append!(db, ["foo", "foo", "fooo"]);
```

# Returns:
* db: AbstractSimStringDB - The database with the new strings added
"""
function append!(db::AbstractSimStringDB, str::Vector)
    @inbounds @simd for i in str
        push!(db, i)
    end
end


"""
    append!(db::AbstractSimStringDB, file::AbstractString)

Add bulk items to a new or existing collection of strings using
from a file using the custom AbstractSimStringDB type.

# Arguments:
* `db``: AbstractSimStringDB - The database to add the items to
* `file`: AbstractString - Path to the file to read from

# Example:
```julia
db = DictDB(CharacterNGrams(2, " "));
append!(db, "./data/test.txt")
```

# Returns:
* `db`: AbstractSimStringDB - The database with the items added
"""
function append!(db::AbstractSimStringDB, file::AbstractString)
    open(file) do f
        for line in eachline(f)
            push!(db, line)
        end
    end
end