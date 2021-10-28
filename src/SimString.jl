module SimString


######### Import modules & utils ################
include("measures.jl")
include("features.jl")
include("db_collection.jl")
include("search.jl")
include("utils.jl")



####### Global export of user API #######
export Dice, Jaccard, Cosine,
    DictCollection,
    CharacterNGrams, WordNGrams,
    make_db, add!, search








end
