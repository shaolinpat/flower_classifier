# flower_classifier/data_prep.py

from sklearn.datasets import load_iris
import pandas as pd

def load_iris_data():
    """
    Load the classic Iris dataset as a pandas DataFrame with renamed columns.

    Returns:
        df (pd.DataFrame): DataFrame containing 150 samples with columns:
            - sepal_length
            - sepal_width
            - petal_length
            - petal_width
            - target
            - species
    """
    iris = load_iris(as_frame=True)
    # Use iris.frame to get both features and target in one DataFrame
    df = iris.frame.copy()
    # Rename columns for simplified downstream usage
    df = df.rename(columns={
        'sepal length (cm)': 'sepal_length',
        'sepal width (cm)': 'sepal_width',
        'petal length (cm)': 'petal_length',
        'petal width (cm)': 'petal_width',
    })
    # Map numeric target values to species names
    df['species'] = df['target'].map(lambda i: iris.target_names[i])
    return df
