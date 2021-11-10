# Main SimString search algorithm

"""
Search for strings in a string collection using the SimString algorithm and Dice
similarity measure.
"""
function search(db_collection::AbstractSimStringDB, mesasure::Dice, query::AbstractString; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Jaccard
similarity measure.
"""
function search(db_collection::AbstractSimStringDB, measure::Jaccard, query::AbstractString; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Cosine
similarity measure.
"""
function search(db_collection::AbstractSimStringDB, measure::Cosine, query::AbstractString; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Overlap
similarity measure.
"""
function search(db_collection::AbstractSimStringDB, measure::Overlap, query::AbstractString; α=0.7)

end