# Common Utils

"""
"""
function add!(db::AbstractSimStringDB, str::AbstractString)
    # Extract features based on the specified feature extractor
    features = extract_features(db.feature_extractor, str)

    # Size of the new feature
    size = length(features)

    # Add the string to the database
    push!(db.string_collection, str)
    return db
end


"""
"""
function pad_string(x::AbstractString, padder::AbstractString)
    return string(padder, x, padder)
end


"""
"""
function n_grams(x::AbstractString, n::Integer)
    return [x[i+1: i+n] for i in 0:length(x) - n]
end