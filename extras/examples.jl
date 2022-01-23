using SimString
using Faker
using BenchmarkTools
using DataStructures

################################# Benchmark Bulk addition #####################
db = DictDB(CharacterNGrams(3, " "));
Faker.seed(2020)
@time fake_names = [string(Faker.first_name(), " ", Faker.last_name()) for i in 1:100_000];


f(d, x) = append!(d, x)
@time f(db, fake_names)



################################ Simple Addition ###############################

db = DictDB(CharacterNGrams(2, " "));
push!(db, "foo");
push!(db, "bar");
push!(db, "fooo");

f(x, c, s, a, r) = search(x, c, s; α=a, ranked=r)
test = "foo";
col = db;
sim = Cosine();
a = 0.8;
r = true;

f(Cosine(),  db, "foo", 0.8, true)

@btime f($sim,  $col, $test, $a, $r)
@btime search(Cosine(), db, "foo"; α=0.8, ranked=true)



db2 = DictDB(CharacterNGrams(3, " "));
append!(db2, ["foo", "bar", "fooo", "foor"]) # also works via multiple dispatch on a vector

results = search(Cosine(), db, "foo"; α=0.8, ranked=true)  # yet to be implemented

bs = ["foo", "bar", "foo", "foo", "bar"]
SimString.extract_features(CharacterNGrams(3, " "), "prepress")
SimString.extract_features(WordNGrams(2, " ", " "), "You are a really really really cool dude.")

db = DictDB(WordNGrams(2, " ", " "))
push!(db, "You are a really really really cool dude.")
