module TestDBCollection
using SimString
using Wakame: Mecab
using Test


@testset "Check single updates of DictDB using CharacterNGrams" begin
    db = DictDB(CharacterNGrams(3, " "))
    push!(db, "foo")
    push!(db, "bar")
    push!(db, "fooo")

    @test db.string_collection == ["foo", "bar", "fooo"]
    @test db.string_size_map[5] == Set(["bar", "foo"])
    @test db.string_size_map[6] == Set(["fooo"])

    @test collect(keys(db.string_feature_map)) == [5, 6]

    @test collect(values(db.string_feature_map[5])) == vcat((repeat([Set(["foo"])], 5)), (repeat([Set(["bar"])], 5)))
    @test collect(values(db.string_feature_map[6])) == repeat([Set(["fooo"])], 6)
end


@testset "Check single update of DictDB using WordNGrams" begin
    db = DictDB(WordNGrams(2, " ", " "))
    push!(db, "You are a really really really cool dude.")

    @test db.string_collection == ["You are a really really really cool dude."]
    @test db.string_size_map[9] == Set(["You are a really really really cool dude."])
    @test collect(keys(db.string_feature_map)) == [9]
    @test collect(values(db.string_feature_map[9])) == repeat([Set(["You are a really really really cool dude."])], 9)
end


@testset "Check bulk updates of DictDB using CharacterNGrams" begin
    db = DictDB(CharacterNGrams(3, " "))
    append!(db, ["foo", "bar", "fooo"])

    @test db.string_collection == ["foo", "bar", "fooo"]
    @test db.string_size_map[5] == Set(["bar", "foo"])
    @test db.string_size_map[6] == Set(["fooo"])

    @test collect(keys(db.string_feature_map)) == [5, 6]

    @test collect(values(db.string_feature_map[5])) == vcat((repeat([Set(["foo"])], 5)), (repeat([Set(["bar"])], 5)))
    @test collect(values(db.string_feature_map[6])) == repeat([Set(["fooo"])], 6)

    @test eltype(collect(keys(db.string_feature_map[5]))) == Tuple{String,Int64}
end


@testset "Check bulk updates of DictDB using WordNGrams" begin
    db = DictDB(WordNGrams(2, " ", " "))
    append!(db, ["You are a really really really cool dude.", "Sometimes you are not really really cool tho"])

    @test db.string_collection == ["You are a really really really cool dude.", "Sometimes you are not really really cool tho"]
    @test db.string_size_map[9] == Set(["You are a really really really cool dude.", "Sometimes you are not really really cool tho"])

    @test collect(keys(db.string_feature_map)) == [9]
    @test collect(values(db.string_feature_map[9]))[5] == Set(["You are a really really really cool dude.", "Sometimes you are not really really cool tho"])
    @test collect(values(db.string_feature_map[9]))[7] == Set(["You are a really really really cool dude.", "Sometimes you are not really really cool tho"])

    @test eltype(collect(keys(db.string_feature_map[9]))) == Tuple{SubArray{SubString{String}},Int64}
end



@testset "Test describe functionality" begin
    db = DictDB(CharacterNGrams(2, " "))
    append!(db, ["foo", "bar", "fooo"])

    # Interact with db
    search(Dice(), db, "zep"; α = 0.8, ranked = true)

    @test describe_collection(db) == (total_collection = 3, avg_size_ngrams = 4.5, total_ngrams = 13)
end


@testset "Test bulk insertion from a file using CharacterNGrams" begin
    db = DictDB(CharacterNGrams(3, " "))
    append!(db, "dummy_words.txt")

    @test db.string_collection == ["foo", "bar", "fooo"]
    @test db.string_size_map[5] == Set(["bar", "foo"])
    @test db.string_size_map[6] == Set(["fooo"])

    @test collect(keys(db.string_feature_map)) == [5, 6]

    @test collect(values(db.string_feature_map[5])) == vcat((repeat([Set(["foo"])], 5)), (repeat([Set(["bar"])], 5)))
    @test collect(values(db.string_feature_map[6])) == repeat([Set(["fooo"])], 6)

    @test eltype(collect(keys(db.string_feature_map[5]))) == Tuple{String,Int64}
end



@testset "Test bulk insertion from a file using WordNGrams" begin
    db = DictDB(WordNGrams(2, " ", " "))
    append!(db, "dummy_sents.txt")

    @test db.string_collection == ["You are a really really really cool dude.", "Sometimes you are not really really cool tho"]
    @test db.string_size_map[9] == Set(["You are a really really really cool dude.", "Sometimes you are not really really cool tho"])

    @test collect(keys(db.string_feature_map)) == [9]
    @test collect(values(db.string_feature_map[9]))[5] == Set(["You are a really really really cool dude.", "Sometimes you are not really really cool tho"])
    @test collect(values(db.string_feature_map[9]))[7] == Set(["You are a really really really cool dude.", "Sometimes you are not really really cool tho"])

    @test eltype(collect(keys(db.string_feature_map[9]))) == Tuple{SubArray{SubString{String}},Int64}

end



@testset "Test mecab insert" begin
    db = DictDB(MecabNGrams(2, " ", Mecab()))
    append!(db, ["pythonが大好きです", "I am a cat."])

    @test db.string_collection == ["pythonが大好きです", "I am a cat."]
    @test db.string_size_map[5] == Set(["pythonが大好きです"])
    @test db.string_size_map[6] == Set(["I am a cat."])
end


end  # module