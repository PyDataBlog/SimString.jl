module SimString

import Base: push!, append!
using DataStructures: DefaultOrderedDict, DefaultDict
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
    push!, append!, search






end
