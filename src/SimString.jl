module SimString


######### Import modules & utils ################
include("measures.jl")
include("features.jl")
include("db_collection.jl")
include("search.jl")
include("utils.jl")



####### Global export of user API #######
export Dice, Jaccard, Cosine,
    AbstractSimStringDB
    CharacterNGrams, WordNGrams,
    add!, search








end
