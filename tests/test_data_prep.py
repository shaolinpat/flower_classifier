# tests/test_data_prep.py

from flower_classifier.data_prep import load_iris_data

def test_load_iris_data():
    df = load_iris_data()
    # 150 rows, at least these columns:
    assert len(df) == 150
    for col in ["sepal_length", "sepal_width", "petal_length", "petal_width", "species"]:
        assert col in df.columns

