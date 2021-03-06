module TestMeasures
using SimString
using Test
using Faker
using Suppressor


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


@testset "Test ExactMatch Search" begin
    db = DictDB(CharacterNGrams(2, " "));
    append!(db, ["foo", "bar", "fooo"]);

    @test search(ExactMatch(), db, "foo"; α=0.1, ranked=true) == [("foo", 1.0)]
    @test search(ExactMatch(), db, "foo"; α=0.5, ranked=true) == [("foo", 1.0)]
    @test search(ExactMatch(), db, "foo"; α=0.9, ranked=true) == [("foo", 1.0)]
    @test search(ExactMatch(), db, "foo"; α=1.0, ranked=true) == [("foo", 1.0)]

end


@testset "Test Micro Deep Dive Search" begin
    db = DictDB(CharacterNGrams(2, " "));
    append!(db, ["a", "ab", "abc", "abcd", "abcde"]);

    @test search(Cosine(), db, "a", α=1., ranked=true) == [("a", 1.0)]
    @test search(Cosine(), db, "ab", α=1., ranked=true) == [("ab", 1.0)]
    @test search(Cosine(), db, "abc", α=1., ranked=true) == [("abc", 1.0)]
    @test search(Cosine(), db, "abcd", α=1., ranked=true) == [("abcd", 1.0)]
    @test search(Cosine(), db, "abcde", α=1., ranked=true) == [("abcde", 1.0)]

    @test search(Cosine(), db, "a", α=0.5, ranked=true) == [("a", 1.0)]
    @test search(Cosine(), db, "ab", α=0.5, ranked=true) == [("ab", 1.0), ("abc", 0.5773502691896258), ("abcd", 0.5163977794943222)]
    @test search(Cosine(), db, "abc", α=0.6, ranked=false) == [("abc", 1.0), ("abcd", 0.6708203932499369), ("abcde", 0.6123724356957946)]

    @test search(Cosine(), db, "a", α=0.9, ranked=true) == [("a", 1.0)]
    @test search(Cosine(), db, "ab", α=0.9, ranked=true) == [("ab", 1.0)]
    @test search(Cosine(), db, "abc", α=0.9, ranked=true) == [("abc", 1.0)]
    @test search(Cosine(), db, "abcd", α=0.9, ranked=true) == [("abcd", 1.0)]
    @test search(Cosine(), db, "abcde", α=0.9, ranked=true) == [("abcde", 1.0)]
end


@testset "Test output from show" begin
    db = DictDB(CharacterNGrams(2, " "));
    append!(db, ["foo", "bar", "fooo"]);

    expected_out = "DictDB(SimString.CharacterNGrams{Int64, String}(2, \" \"))\nTotal collection: 3\nAverage number of ngram features: 4.5\nTotal number of ngram features: 13\n"
    r = @capture_out show(db)
    @test r == expected_out
end





end  # module