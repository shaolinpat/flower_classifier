"""
flower_classifier_app.py -- Streamlit demo for saved Support Vector Machines model

"""

import pathlib
import joblib
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import streamlit as st

iris_classes = ["setosa", "versicolor", "virginica"]


# ------------------------------------------------------------------------------
# 1. Load the full pipeline (cached so it isn’t reloaded on every interaction)
# ------------------------------------------------------------------------------
@st.cache_resource(show_spinner=False)
def load_pipeline(path: pathlib.Path):
    return joblib.load(path)


BASE_DIR = pathlib.Path(__file__).resolve().parent
PIPELINE_FILE = "support_vector_machines_flower_classifier.joblib"
PIPELINE_PATH = BASE_DIR / "../models" / PIPELINE_FILE

pipeline = load_pipeline(PIPELINE_PATH)
scaler = pipeline.named_steps["scale"]
model = pipeline.named_steps["clf"]


# ------------------------------------------------------------------------------
# 2. Build simple UI
# ------------------------------------------------------------------------------
st.title("Flower-species classifier")
st.caption(
    f"Trained Support Vector Machine\n" f" C = {model.C}\n" f" kernel = {model.kernel}"
)

col1, col2 = st.columns(2)
with col1:
    sepal_len = st.slider("Sepal length (cm)", 4.0, 8.0, 5.8, 0.1)
    sepal_wid = st.slider("Sepal width (cm)", 2.0, 4.4, 3.0, 0.1)
with col2:
    petal_len = st.slider("Petal length (cm)", 1.0, 7.0, 4.35, 0.1)
    petal_wid = st.slider("Petal width (cm)", 0.1, 2.6, 1.3, 0.1)

if st.button("Predict"):
    # --------------------------------------------------------------------------
    # 3. Model inference
    # --------------------------------------------------------------------------
    sample = np.array([[sepal_len, sepal_wid, petal_len, petal_wid]])
    sample_scaled = scaler.transform(sample)
    pred_idx = model.predict(sample_scaled)[0]
    pred_proba = model.predict_proba(sample_scaled).flatten()

    pred_idx = model.predict(sample_scaled)[0]
    pred_name = iris_classes[pred_idx].capitalize()
    st.success(f"**Prediction:** {pred_name}")

    # Probability bar-chart
    proba_df = pd.DataFrame(
        {"Species": [n.capitalize() for n in iris_classes], "Probability": pred_proba}
    ).set_index("Species")

    # 1) Build a horizontal bar chart
    fig, ax = plt.subplots(figsize=(5, 3), facecolor="#0E1117")  # match Streamlit dark
    bars = ax.barh(
        [name.capitalize() for name in proba_df.index],
        proba_df["Probability"],
        color="#0E75B6",  # Streamlit blue
    )

    # 2) Style for dark theme
    ax.set_facecolor("#0E1117")
    ax.invert_yaxis()
    ax.xaxis.label.set_color("white")
    ax.yaxis.label.set_color("white")
    ax.tick_params(colors="white", which="both")
    for spine in ax.spines.values():
        spine.set_color("white")
    ax.set_xlabel("Probability", color="white", fontsize=12)

    # 3) Render
    st.pyplot(fig)


# ------------------------------------------------------------------------------
# 4. Footer
# ------------------------------------------------------------------------------
st.markdown(
    """
    <hr style="margin:1em 0">
    <small>
    Model & scaler saved with <code>joblib</code>; demo built in Streamlit.<br>
    © 2025 Patrick Beach
    </small>
    """,
    unsafe_allow_html=True,
)
