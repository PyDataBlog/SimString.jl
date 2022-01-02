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
"""
function DictDB(x::WordNGrams)
    DictDB(
        x,
        String[],
        DefaultDict{Int, Set{String}}( () -> Set{String}() ),
        DefaultDict{ Int, DefaultOrderedDict{Tuple{NTuple{x.n, String}, Int}, Set{String}}  }( () -> DefaultOrderedDict{Tuple{NTuple{x.n, String}, Int}, Set{String} }(Set{String})),
        DefaultDict{ Int, DefaultDict{Tuple{NTuple{x.n, String}, Int}, Set{String}} }( () -> DefaultDict{Tuple{NTuple{x.n, String}, Int}, Set{String}}(Set{String}))
    )
end




################################## DictDB UTIL Functions  ############################
"""
"""
function retrieve_existing_feature_by_size(db::DictDB, size, feature)
    return db.string_feature_map[size][feature]
end


"""
"""
function minimum_db_feature_size(db::DictDB)
    return minimum(keys(db.string_feature_map))
end


"""
"""
function maximum_db_feature_size(db::DictDB)
    return maximum(keys(db.string_feature_map))
end


"""
"""
function lookup_feature_set_by_size_feature(db::DictDB, size, feature)
    # TODO: Clean this up and make it more efficient. Shouldn't updated db.string_feature_map
    if feature ∉ keys(db.lookup_cache[size])
        db.lookup_cache[size][feature] = retrieve_existing_feature_by_size(db, size, feature)
    end
    return db.lookup_cache[size][feature]
end