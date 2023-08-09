"""
Custom DB collection for storing SimString data using base Dictionary `Dict`
"""
struct DictDB{
    T1<:FeatureExtractor,
    T2<:AbstractString,
    T3<:AbstractDict,
    T4<:AbstractDict,
    T5<:AbstractDict,
    } <: AbstractSimStringDB

    feature_extractor::T1                       # NGram feature extractor
    string_collection::Vector{T2}               # Collection of strings in the DB
    string_size_map::T3                         # Index map of feature sizes
    string_feature_map::T4                      # Index map of all features with associated strings and sizes
    lookup_cache::T5                            # Cache for lookup results
end


"""
    DictDB(x::CharacterNGrams)

Initialize a dict DB with additional containers and Metadata for CharacterNGrams

# Arguments
* `x`: CharacterNGrams object

# Example
```julia
db = DictDB(CharacterNGrams(2, " "))
```

# Returns
* `DictDB`: A DictDB object with additional containers and Metadata for CharacterNGrams
"""
function DictDB(x::CharacterNGrams)
    DictDB(
        x,
        String[],
        DefaultDict{Int, Set{String}}( () -> Set{String}() ),
        DefaultDict{ Int, DefaultOrderedDict{Tuple{String, Int64}, Set{String}}  }( () -> DefaultOrderedDict{Tuple{String, Int64}, Set{String} }(Set{String})),
        DefaultDict{ Int, DefaultDict{Tuple{String, Int64}, Set{String}}  }( () -> DefaultDict{Tuple{String, Int64}, Set{String}}(Set{String}))
    )
end


"""
    Internal function for generating a base DictDB object for WordNGrams and MecabNGrams
"""
function generate_base_dict_db(x)
    DictDB(
        x,
        String[],
        DefaultDict{Int, Set{String}}( () -> Set{String}() ),
        DefaultDict{ Int, DefaultOrderedDict{Tuple{SubArray{SubString{String}}, Int}, Set{String}}  }( () -> DefaultOrderedDict{Tuple{SubArray{SubString{String}}, Int}, Set{String} }(Set{String})),
        DefaultDict{ Int, DefaultDict{Tuple{SubArray{SubString{String}}, Int}, Set{String}} }( () -> DefaultDict{Tuple{SubArray{SubString{String}}, Int}, Set{String}}(Set{String}))
    )
end

"""
    DictDB(x::WordNGrams)

Initialize a dict DB with additional containers and Metadata for WordNGrams

# Arguments
* `x`: WordNGrams object

# Example
```julia
db = DictDB(WordNGrams(2, " ", " "))
```

# Returns
* `DictDB`: A DictDB object with additional containers and Metadata for WordNGrams
"""
DictDB(x::WordNGrams) = generate_base_dict_db(x)



"""
    DictDB(x::MecabNGrams)

Initialize a dict DB with additional containers and Metadata for MecabNGrams

# Arguments
* `x`: MecabNGrams object

# Example
```julia
db = DictDB(MecabNGrams(2, " ", Mecab()))
```

# Returns
* `DictDB`: A DictDB object with additional containers and Metadata for MecabNGrams
"""
DictDB(x::MecabNGrams) = generate_base_dict_db(x)





################################## DictDB UTIL Functions  ############################
"""
    describe_collection(db::DictDB)

Basic summary stats for the DB

# Arguments
* `db`: DictDB object

# Example
```julia
db = DictDB(CharacterNGrams(2, " "));
append!(db, ["foo", "bar", "fooo"]);
describe_collection(db)
(total_collection = 3, avg_size_ngrams = 4.5, total_ngrams = 13)

# Returns
* NamedTuples: Summary stats for the DB
```

"""
function describe_collection(db::DictDB)

    # Total number of strings in collection
    ∑ = length(db.string_collection)

    # Average size of ngram features
    n = [x for x in keys(db.string_size_map)]
    μ = sum(n) / length(n)

    # Total number of ngram features
    total_ngrams = 0
    for i in values(db.string_feature_map)
        total_ngrams += length(i)
    end

    return (total_collection = ∑, avg_size_ngrams = μ, total_ngrams = total_ngrams)
end


"""
Pretty print summary stats for the DB
"""
function Base.show(io::IO, x::DictDB)
    metrics = describe_collection(x)
    println(io, "DictDB($(x.feature_extractor))")
    println(io, "Total collection: ", metrics.total_collection)
    println(io, "Average number of ngram features: ", metrics.avg_size_ngrams)
    println(io, "Total number of ngram features: ", metrics.total_ngrams)
end


"""
Internal function to lookup feature sets by size and feature
"""
function lookup_feature_set_by_size_feature(db::DictDB, size, feature)
    if !haskey(db.lookup_cache[size], feature)
        db.lookup_cache[size][feature] = get(db.string_feature_map[size], feature, Set{String}())
    end
    return db.lookup_cache[size][feature]
end