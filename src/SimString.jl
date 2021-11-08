module SimString


using Dictionaries

######### Import modules & utils ################
include("measures.jl")
include("features.jl")
include("db_collection.jl")
include("search.jl")
include("utils.jl")



####### Global export of user API #######
export Dice, Jaccard, Cosine,
    AbstractSimStringDB, DictDB,
    CharacterNGrams, WordNGrams,
    add!, search


## Example of User API

# db = DictDB(CharacterNGrams(2, " "), String[], Dict(), Dict())
# add!(db, "foo")
# add!(db, "bar")
# add!(db, "fooo")

# results = search(Dice(), "foo", db; α=0.8)





end
