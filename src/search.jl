# Main SimString search algorithm

"""
Search for strings in a string collection using the SimString algorithm and Dice
similarity measure.
"""
function search(mesasure::Dice, db_collection::AbstractSimStringDB, query::AbstractString; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Jaccard
similarity measure.
"""
function search(measure::Jaccard, db_collection::AbstractSimStringDB, query::AbstractString; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Cosine
similarity measure.
"""
function search(measure::Cosine, db_collection::AbstractSimStringDB, query::AbstractString; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Overlap
similarity measure.
"""
function search(measure::Overlap, db_collection::AbstractSimStringDB, query::AbstractString; α=0.7)

end