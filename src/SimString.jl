module SimString

# Write your package code here.

######### Import modules & utils ################
include("measures.jl")
include("features.jl")
include("db_collection.jl")
include("utils.jl")



####### Global export of user API #######
export Dice, Jaccard, Cosine,
    DictCollection,
    CharacterNGrams, WordNGrams








end
