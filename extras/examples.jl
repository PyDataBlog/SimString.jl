using SimString
using Faker
using BenchmarkTools

################################# Benchmark Builk addition #####################
db = DictDB(CharacterNGrams(3, " "), String[], Dict(), Dict());
Faker.seed(2020)
@time fake_names = [string(Faker.first_name(), " ", Faker.last_name()) for i in 1:100_000];


f(d, x) = push!(d, x)
@benchmark f($db, $fake_names)



################################ Simple Addition ###############################

# db = DictDB(CharacterNGrams(2, " "), String[], Dict(), Dict())
# push!(db, "foo")
# push!(db, "bar")
# push!(db, "fooo")

# push!(db, ["foo", "bar", "fooo"]) # also works via multiple dispatch on a vector

# results = search(db,  Cosine(), "foo"; α=0.8)  # yet to be implemented

