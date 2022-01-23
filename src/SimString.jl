module SimString

import Base: push!, append!
using DataStructures: DefaultOrderedDict, DefaultDict
using ProgressMeter
using CircularArrays
using OffsetArrays

######### Import modules & utils ################
include("db_collection.jl")
include("dictdb.jl")
include("features.jl")
include("measures.jl")
include("search.jl")



####### Global export of user API #######
export Dice, Jaccard, Cosine, Overlap, ExactMatch,
    AbstractSimStringDB, DictDB, describe_collection,
    CharacterNGrams, WordNGrams,
    search






end
