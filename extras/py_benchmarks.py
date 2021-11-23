from simstring.feature_extractor.character_ngram import CharacterNgramFeatureExtractor
from simstring.measure.cosine import CosineMeasure
from simstring.database.dict import DictDatabase
from simstring.searcher import Searcher
from faker import Faker

db = DictDatabase(CharacterNgramFeatureExtractor(3))

fake = Faker()
fake_names = [fake.name() for i in range(100_000)]

def f(x):
    for i in x:
        db.add(i)

# %time f(fake_names)