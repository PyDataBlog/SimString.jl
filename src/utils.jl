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