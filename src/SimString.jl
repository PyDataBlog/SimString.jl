module SimString

import Base: push!
using DataStructures: OrderedDict
using ProgressMeter

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






end
