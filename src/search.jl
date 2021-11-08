# Main SimString search algorithm

"""
Search for strings in a string collection using the SimString algorithm and Dice
similarity measure.
"""
function search(mesasure::Dice, query::AbstractString, database::AbstractSimStringDB; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Jaccard
similarity measure.
"""
function search(mesasure::Jaccard, query::AbstractString, database::AbstractSimStringDB; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Cosine
similarity measure.
"""
function search(mesasure::Cosine, query::AbstractString, database::AbstractSimStringDB; α=0.7)

end


"""
Search for strings in a string collection using the SimString algorithm and Overlap
similarity measure.
"""
function search(mesasure::Overlap, query::AbstractString, database::AbstractSimStringDB; α=0.7)

end