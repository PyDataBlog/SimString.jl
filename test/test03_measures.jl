module TestMeasureUtils
using SimString
using Test


@testset "Test Similarity Scores" begin
    X = [1, 2, 3]
    Y = [1, 2, 4, 5]
    @test SimString.similarity_score(Dice(), X, Y)        ≈ 0.5714285714285714
    @test SimString.similarity_score(Jaccard(), X, Y)     ≈ 0.4
    @test SimString.similarity_score(Cosine(), X, Y)      ≈ 0.5773502691896258
    @test SimString.similarity_score(Overlap(), X, Y)     ≈ 0.6666666666666666
end


@testset "Test Minimum Candidate Feature Size" begin
    @test SimString.minimum_feature_size(Dice(), 5, 1.)     == 5
    @test SimString.minimum_feature_size(Dice(), 5, 0.5)    == 2

    @test SimString.minimum_feature_size(Jaccard(), 5, 1.)   == 5
    @test SimString.minimum_feature_size(Jaccard(), 5, 0.5)  == 3

    @test SimString.minimum_feature_size(Cosine(), 5, 1.)    == 5
    @test SimString.minimum_feature_size(Cosine(), 5, 0.5)   == 2

    @test SimString.minimum_feature_size(Overlap(), 5, 1.)   == 1
    @test SimString.minimum_feature_size(Overlap(), 5, 0.5)  == 1
end


@testset "Test Maximum Candidate Feature Size" begin
    db = DictDB(CharacterNGrams(3, " "))
    append!(db, ["foo", "bar", "fooo"])

    @test SimString.maximum_feature_size(Dice(), db, 5, 1.)     == 5
    @test SimString.maximum_feature_size(Dice(), db, 5, 0.5)    == 15

    @test SimString.maximum_feature_size(Jaccard(), db, 5, 1.)   == 5
    @test SimString.maximum_feature_size(Jaccard(), db, 5, 0.5)  == 10

    @test SimString.maximum_feature_size(Cosine(), db, 5, 1.)    == 5
    @test SimString.maximum_feature_size(Cosine(), db, 5, 0.5)   == 20

    @test SimString.maximum_feature_size(Overlap(), db, 5, 1.)   == 6
    @test SimString.maximum_feature_size(Overlap(), db, 5, 0.5)  == 6
end


@testset "Test Minimum Feature Overlap" begin
    @test SimString.minimum_overlap(Dice(), 5, 5, 1.0)          == 13
    @test SimString.minimum_overlap(Dice(), 5, 20, 1.0)         == 50
    @test SimString.minimum_overlap(Dice(), 5, 5, 0.5)          == 7

    @test SimString.minimum_overlap(Jaccard(), 5, 5, 1.0)        == 5
    @test SimString.minimum_overlap(Jaccard(), 5, 20, 1.0)       == 13
    @test SimString.minimum_overlap(Jaccard(), 5, 5, 0.5)        == 4

    @test SimString.minimum_overlap(Cosine(), 5, 5, 1.0)         == 5
    @test SimString.minimum_overlap(Cosine(), 5, 20, 1.0)        == 10
    @test SimString.minimum_overlap(Cosine(), 5, 5, 0.5)         == 3

    @test SimString.minimum_overlap(Overlap(), 5, 5, 1.0)        == 5
    @test SimString.minimum_overlap(Overlap(), 5, 20, 1.0)       == 5
    @test SimString.minimum_overlap(Overlap(), 5, 5, 0.5)        == 3

end



end  # module