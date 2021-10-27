# Common Utils

"""
"""
function make_db(collection::DictCollection)
    return DictDB(collection.feature_extractor, Vector{AbstractString}(), Set{AbstractDict}(), Set{AbstractDict}())
end


"""
"""
function add!(str::AbstractString, db::DictDB)
    # Extract features based on the specified feature extractor
    features = extract_features(db.feature_extractor, str)

    # Size of the new feature
    size = length(features)

    # Add the string to the database
    push!(db.string_collection, str)
    return db
end