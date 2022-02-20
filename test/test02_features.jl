module TestFeatures
using SimString
using Test


@testset "Test feature extraction" begin
    char_ngram_res = SimString.extract_features(CharacterNGrams(3, " "), "prepress")
    @test char_ngram_res[5] == ("pre", 2)

    # Unicode text test
    @test SimString.extract_features(CharacterNGrams(2, " "), "∀∃😄🍕")[3] == ("😄🍕", 1)

    word_ngram_res = SimString.extract_features(WordNGrams(2, " ", " "), "You are a really really really cool dude 😄🍕")
    @test word_ngram_res[5] == (["really", "really"], 2)
    @test word_ngram_res[8] == (["dude", "😄🍕"], 1)
end


@testset "Test padding" begin
    @test SimString.pad_string(["one", "word"], " ") == [" ", "one", "word", " "]
    @test SimString.pad_string("one word", " ") == " one word "
end



@testset "Test cummulative_ngram_count" begin

end










end  # module