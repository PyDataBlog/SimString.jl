var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = SimString","category":"page"},{"location":"#SimString","page":"Home","title":"SimString","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for SimString.","category":"page"},{"location":"","page":"Home","title":"Home","text":"A native Julia implementation of the CPMerge algorithm, which is designed for approximate string matching. This package is be particulary useful for natural language processing tasks which demand the retrieval of strings/texts from a very large corpora (big amounts of texts). Currently, this package supports both Character and Word based N-grams feature generations and there are plans to open the package up for custom user defined feature generation methods.","category":"page"},{"location":"#Features","page":"Home","title":"Features","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"[X] Fast algorithm for string matching\n[X] 100% exact retrieval\n[X] Support for unicodes\n[ ] Custom user defined feature generation methods\n[ ] Mecab-based tokenizer support","category":"page"},{"location":"#Suported-String-Similarity-Measures","page":"Home","title":"Suported String Similarity Measures","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"[X] Dice coefficient\n[X] Jaccard coefficient\n[X] Cosine coefficient\n[X] Overlap coefficient","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"You can grab the latest stable version of this package from Julia registries by simply running;","category":"page"},{"location":"","page":"Home","title":"Home","text":"NB: Don't forget to invoke Julia's package manager with ]","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> add SimString","category":"page"},{"location":"","page":"Home","title":"Home","text":"The few (and selected) brave ones can simply grab the current experimental features by simply adding the master branch to your development environment after invoking the package manager with ]:","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> add SimString#master","category":"page"},{"location":"","page":"Home","title":"Home","text":"You are good to go with bleeding edge features and breakages!","category":"page"},{"location":"","page":"Home","title":"Home","text":"To revert to a stable version, you can simply run:","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> free SimString","category":"page"},{"location":"#Usage","page":"Home","title":"Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using SimString\n\n# Inilisate database and some strings\ndb = DictDB(CharacterNGrams(2, \" \"));\npush!(db, \"foo\");\npush!(db, \"bar\");\npush!(db, \"fooo\");\n\n# Convinient approach is to use an array of strings for multiple entries: `append!(db, [\"foo\", \"bar\", \"fooo\"]);`\n\n# Retrieve the closest match(es)\nres = search(Dice(), db, \"foo\"; α=0.8, ranked=true)\n# 2-element Vector{Tuple{String, Float64}}:\n#  (\"foo\", 1.0)\n#  (\"fooo\", 0.8888888888888888)\n\n","category":"page"},{"location":"#TODO:-Benchmarks","page":"Home","title":"TODO: Benchmarks","text":"","category":"section"},{"location":"#Release-History","page":"Home","title":"Release History","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"0.1.0 Initial release.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [SimString]","category":"page"},{"location":"#SimString.AbstractSimStringDB","page":"Home","title":"SimString.AbstractSimStringDB","text":"Base type for all custom db collections.\n\n\n\n\n\n","category":"type"},{"location":"#SimString.AbstractSimilarityMeasure","page":"Home","title":"SimString.AbstractSimilarityMeasure","text":"Abstract base type for all string similarity measures.\n\n\n\n\n\n","category":"type"},{"location":"#SimString.CharacterNGrams","page":"Home","title":"SimString.CharacterNGrams","text":"Feature extraction on character-level ngrams\n\n\n\n\n\n","category":"type"},{"location":"#SimString.Cosine","page":"Home","title":"SimString.Cosine","text":"Cosine Similarity Measure.\n\n\n\n\n\n","category":"type"},{"location":"#SimString.Dice","page":"Home","title":"SimString.Dice","text":"Dice Similarity Measure.\n\n\n\n\n\n","category":"type"},{"location":"#SimString.DictDB","page":"Home","title":"SimString.DictDB","text":"Custom DB collection for storing SimString data using base Dictionary Dict\n\n\n\n\n\n","category":"type"},{"location":"#SimString.DictDB-Tuple{CharacterNGrams}","page":"Home","title":"SimString.DictDB","text":"DictDB(x::CharacterNGrams)\n\nInitialize a dict DB with additional containers and Metadata for CharacterNGrams\n\nArguments\n\nx: CharacterNGrams object\n\nExample\n\ndb = DictDB(CharacterNGrams(2, \" \"))\n\nReturns\n\nDictDB: A DictDB object with additional containers and Metadata for CharacterNGrams\n\n\n\n\n\n","category":"method"},{"location":"#SimString.DictDB-Tuple{WordNGrams}","page":"Home","title":"SimString.DictDB","text":"DictDB(x::WordNGrams)\n\nInitialize a dict DB with additional containers and Metadata for WordNGrams\n\nArguments\n\nx: WordNGrams object\n\nExample\n\ndb = DictDB(WordNGrams(2, \" \", \" \"))\n\nReturns\n\nDictDB: A DictDB object with additional containers and Metadata for WordNGrams\n\n\n\n\n\n","category":"method"},{"location":"#SimString.FeatureExtractor","page":"Home","title":"SimString.FeatureExtractor","text":"Abstract type for feature extraction structs\n\n\n\n\n\n","category":"type"},{"location":"#SimString.Jaccard","page":"Home","title":"SimString.Jaccard","text":"Jaccard Similarity Measure.\n\n\n\n\n\n","category":"type"},{"location":"#SimString.Overlap","page":"Home","title":"SimString.Overlap","text":"Overlap Similarity Measure.\n\n\n\n\n\n","category":"type"},{"location":"#SimString.WordNGrams","page":"Home","title":"SimString.WordNGrams","text":"Feature extraction based on word-level ngrams\n\n\n\n\n\n","category":"type"},{"location":"#Base.append!-Tuple{AbstractSimStringDB, Vector}","page":"Home","title":"Base.append!","text":"Add bulk items to a new or existing collection of strings using the custom AbstractSimStringDB type.\n\n\n\n\n\n","category":"method"},{"location":"#Base.push!-Tuple{AbstractSimStringDB, AbstractString}","page":"Home","title":"Base.push!","text":"Add a new item to a new or existing collection of strings using the custom AbstractSimStringDB type.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.cummulative_ngram_count-Tuple{Any}","page":"Home","title":"SimString.cummulative_ngram_count","text":"Internal function to count and pad generated character-level ngrams (including duplicates)\n\n\n\n\n\n","category":"method"},{"location":"#SimString.extract_features-Tuple{CharacterNGrams, Any}","page":"Home","title":"SimString.extract_features","text":"Internal function to generate character-level ngrams features from an AbstractString\n\n\n\n\n\n","category":"method"},{"location":"#SimString.extract_features-Tuple{WordNGrams, Any}","page":"Home","title":"SimString.extract_features","text":"Internal function to generate word-level ngrams features from an AbstractString\n\n\n\n\n\n","category":"method"},{"location":"#SimString.init_ngrams-Tuple{CharacterNGrams, Any, Any}","page":"Home","title":"SimString.init_ngrams","text":"Internal function to generate intial uncounted ngrams on a character level\n\n\n\n\n\n","category":"method"},{"location":"#SimString.init_ngrams-Tuple{WordNGrams, Any, Any}","page":"Home","title":"SimString.init_ngrams","text":"Internal function to generate intial uncounted ngrams on a word level\n\n\n\n\n\n","category":"method"},{"location":"#SimString.lookup_feature_set_by_size_feature-Tuple{DictDB, Any, Any}","page":"Home","title":"SimString.lookup_feature_set_by_size_feature","text":"Internal function to lookup feature sets by size and feature\n\n\n\n\n\n","category":"method"},{"location":"#SimString.maximum_feature_size-Tuple{Cosine, AbstractSimStringDB, Any, Any}","page":"Home","title":"SimString.maximum_feature_size","text":"Calculate maximum feature size for Cosine similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.maximum_feature_size-Tuple{Dice, AbstractSimStringDB, Any, Any}","page":"Home","title":"SimString.maximum_feature_size","text":"Calculate maximum feature size for Dice similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.maximum_feature_size-Tuple{Jaccard, AbstractSimStringDB, Any, Any}","page":"Home","title":"SimString.maximum_feature_size","text":"Calculate maximum feature size for Jaccard similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.maximum_feature_size-Tuple{Overlap, AbstractSimStringDB, Any, Any}","page":"Home","title":"SimString.maximum_feature_size","text":"Calculate maximum feature size for Overlap similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.minimum_feature_size-Tuple{Cosine, Any, Any}","page":"Home","title":"SimString.minimum_feature_size","text":"Calculate minimum feature size for Cosine similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.minimum_feature_size-Tuple{Dice, Any, Any}","page":"Home","title":"SimString.minimum_feature_size","text":"Calculate minimum feature size for Dice similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.minimum_feature_size-Tuple{Jaccard, Any, Any}","page":"Home","title":"SimString.minimum_feature_size","text":"Calculate minimum feature size for Jaccard similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.minimum_feature_size-Tuple{Overlap, Any, Any}","page":"Home","title":"SimString.minimum_feature_size","text":"Calculate minimum feature size for Overlap similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.minimum_overlap-Tuple{Cosine, Any, Any, Any}","page":"Home","title":"SimString.minimum_overlap","text":"Calculate the minimum overlap (τ) for a query size, candidate size, and α using Cosine similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.minimum_overlap-Tuple{Dice, Any, Any, Any}","page":"Home","title":"SimString.minimum_overlap","text":"Calculate the minimum overlap (τ) for a query size, candidate size, and α using Dice similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.minimum_overlap-Tuple{Jaccard, Any, Any, Any}","page":"Home","title":"SimString.minimum_overlap","text":"Calculate the minimum overlap (τ) for a query size, candidate size, and α using Jaccard similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.minimum_overlap-Tuple{Overlap, Any, Any, Any}","page":"Home","title":"SimString.minimum_overlap","text":"Calculate the minimum overlap (τ) for a query size, candidate size, and α using Overlap similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.n_grams-Tuple{CharacterNGrams, Any, Any}","page":"Home","title":"SimString.n_grams","text":"Internal function to create character-level ngrams features from an AbstractString\n\n\n\n\n\n","category":"method"},{"location":"#SimString.n_grams-Tuple{WordNGrams, Any, Any}","page":"Home","title":"SimString.n_grams","text":"Internal function to create word-level ngrams from an AbstractVector\n\n\n\n\n\n","category":"method"},{"location":"#SimString.overlap_join-Tuple{AbstractSimStringDB, Any, Any, Any}","page":"Home","title":"SimString.overlap_join","text":"Internal function which performs the overlap join\n\n\n\n\n\n","category":"method"},{"location":"#SimString.pad_string-Tuple{AbstractString, AbstractString}","page":"Home","title":"SimString.pad_string","text":"Internal function to pad AbstractString types with specified padder\n\n\n\n\n\n","category":"method"},{"location":"#SimString.pad_string-Tuple{AbstractVector, AbstractString}","page":"Home","title":"SimString.pad_string","text":"Internal function to pad AbstractVector types with specified padder\n\n\n\n\n\n","category":"method"},{"location":"#SimString.rank_search_results-Tuple{SimString.AbstractSimilarityMeasure, DictDB, Any, Any}","page":"Home","title":"SimString.rank_search_results","text":"Internal function which ranks the results of a search using the specified similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.retrieve_existing_feature_by_size-Tuple{DictDB, Any, Any}","page":"Home","title":"SimString.retrieve_existing_feature_by_size","text":"Internal function for retrieving existing features by size\n\n\n\n\n\n","category":"method"},{"location":"#SimString.search!-Tuple{SimString.AbstractSimilarityMeasure, DictDB, AbstractString}","page":"Home","title":"SimString.search!","text":"Search for strings in custom DictDB string collection using the SimString algorithm and a similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.search-Tuple{SimString.AbstractSimilarityMeasure, AbstractSimStringDB, AbstractString}","page":"Home","title":"SimString.search","text":"search(measure::AbstractSimilarityMeasure, db_collection::AbstractSimStringDB, query::AbstractString;\n    α=0.7, ranked=true)\n\nSearch for strings in a string collection using the SimString algorithm and a similarity measure.\n\nArguments:\n\nmeasure::AbstractSimilarityMeasure - The similarity measure to use.\ndb_collection::AbstractSimStringDB - The database collection to search.\nquery::AbstractString - The query string to search for.\nα::float - The α parameter for the SimString algorithm.\nranked::Boolean - Whether to return the results in ranked order.\n\nExample\n\ndb = DictDB(CharacterNGrams(2, \" \"));\nappend!(db, [\"foo\", \"bar\", \"fooo\"]);\n\nsearch(Dice(), db, \"foo\"; α=0.8, ranked=true)\n# 2-element Vector{Tuple{String, Float64}}:\n#  (\"foo\", 1.0)\n#  (\"fooo\", 0.8888888888888888)\n\nReturns\n\nA Vector of results, where each element is a Tuple of the form (string, similarity measure score).\n\n\n\n\n\n","category":"method"},{"location":"#SimString.similarity_score-Tuple{Cosine, Any, Any}","page":"Home","title":"SimString.similarity_score","text":"Calculate similarity score between X and Y using Cosine similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.similarity_score-Tuple{Dice, Any, Any}","page":"Home","title":"SimString.similarity_score","text":"Calculate similarity score between X and Y using Dice similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.similarity_score-Tuple{Jaccard, Any, Any}","page":"Home","title":"SimString.similarity_score","text":"Calculate similarity score between X and Y using Jaccard similarity measure.\n\n\n\n\n\n","category":"method"},{"location":"#SimString.similarity_score-Tuple{Overlap, Any, Any}","page":"Home","title":"SimString.similarity_score","text":"Calculate similarity score between X and Y using Overlap similarity measure.\n\n\n\n\n\n","category":"method"}]
}
