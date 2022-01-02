module TestMeasures
using SimString
using Test
using Faker


@testset "Test Dice Search" begin
    db = DictDB(CharacterNGrams(2, " "));
    append!(db, ["foo", "bar", "fooo"]);

    res = search(Dice(), db, "foo"; α=0.8, ranked=true)
    @test res == [("foo", 1.0), ("fooo", 0.8888888888888888)]
end


@testset "Test Jaccard Search" begin
    db = DictDB(CharacterNGrams(2, " "));
    append!(db, ["foo", "bar", "fooo"]);

    res = search(Jaccard(), db, "foo"; α=0.8, ranked=true)
    @test res == [("foo", 1.0), ("fooo", 0.8)]

end


@testset "Test Cosine Search" begin
    db = DictDB(CharacterNGrams(2, " "));
    append!(db, ["foo", "bar", "fooo"]);

    res = search(Cosine(), db, "foo"; α=0.8, ranked=true)
    @test res == [("foo", 1.0), ("fooo", 0.8944271909999159)]

end


@testset "Test Overlap Search" begin
    db = DictDB(CharacterNGrams(2, " "));
    append!(db, ["foo", "bar", "fooo"]);

    res = search(Overlap(), db, "foo"; α=0.8, ranked=true)
    @test res == [("foo", 1.0), ("fooo", 1.0)]

end








end  # module