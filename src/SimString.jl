module SimString


using Dictionaries

######### Import modules & utils ################
include("db_collection.jl")
include("features.jl")
include("measures.jl")
include("search.jl")



####### Global export of user API #######
export Dice, Jaccard, Cosine,
    AbstractSimStringDB, DictDB,
    CharacterNGrams, WordNGrams,
    push!, search

    # using SimString

    # db = DictDB(CharacterNGrams(2, " "), String[], Dict(), Dict())
    # push!(db, "foo")
    # push!(db, "bar")
    # push!(db, "fooo")

    # push!(db, ["foo", "bar", "fooo"]) # also works via multiple dispatch on a vector

    # results = search(Dice(), "foo", db; α=0.8)  # yet to be implemented



end
