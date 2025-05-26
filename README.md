# Flower-Species Classifier

A compact end-to-end machine-learning project that:

1. Explores the classic **Iris** dataset (150 samples, 4 numeric features, 3 species)  
2. Benchmarks **8 traditional classifiers** with hyper-parameter search  
3. Interprets the winning model with **SHAP**  
4. Saves the best pipeline and serves it through a **Streamlit** app  

---

## Key Results

| Metric                        | Score |
|-------------------------------|-------|
| Majority-class baseline accuracy  | 0.33  |
| **Best model (SVM) macro-F1**     | **0.98** |
| Test accuracy (SVM)               | 0.97  |

---

## Quick Start

### 1) Environment setup

#### Option A: Python venv
```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

#### Option B: Conda (using environment.yml)
```bash
conda env create -f environment.yml
conda activate iris
```

### 2) Run the notebook
```bash
jupyter lab
# or in VS Code:
code flower_classifier.ipynb
```

### 3) Launch the Streamlit app
```bash
streamlit run flower_classifier_app.py
```

---

### Quick Verify

To make sure everything runs end-to-end:

```bash
bash scripts/verify_run.sh
```

---

## File Layout

```text
flower-classifier/
├─ models/
│   └─ svm_iris.joblib        # saved best pipeline (SVM + scaler)
├─scripts/
│   └─ verify_run.sh
├─ environment.yaml
├─ flower_classifier.ipynb    # notebook with EDA → modelling → SHAP
├─ flower_classifier_app.py   # Streamlit UI
├─ requirements.txt
└─ README.md
```

---

## Next Steps

1. **Colab support**  
   - Add an “Open in Colab” badge linking to `flower_classifier.ipynb`  
   - Insert a top cell that installs dependencies (`!pip install -r requirements.txt`)

2. **Unit testing**  
   - Create `tests/` with pytest cases for data-prep and inference functions  
   - Ensure key functions (e.g. scaling + prediction) get validated automatically  

3. **Continuous Integration**  
   - Add a GitHub Actions workflow (`.github/workflows/ci.yml`) that on each push:  
       A. Installs dependencies  
       B. Runs pytest  
       C. Executes the notebook via nbconvert  
       D. Performs a smoke-test of the Streamlit app  

---

*Built with scikit-learn 1.5 · Streamlit 1.33 · Python 3.11*  
