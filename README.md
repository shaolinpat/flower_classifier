# Flower-Species Classifier

[![CI](https://github.com/shaolinpat/flower_classifier/actions/workflows/ci.yml/badge.svg)](https://github.com/shaolinpat/flower_classifier/actions/workflows/ci.yml)
[![Coverage (flag)](https://img.shields.io/codecov/c/github/shaolinpat/flower_classifier.svg?flag=flower_classifier&branch=main)](https://codecov.io/gh/shaolinpat/flower_classifier)  
[![Python 3.11](https://img.shields.io/badge/python-3.11-blue.svg)](https://www.python.org/downloads/release/python-3110/)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/shaolinpat/flower_classifier/blob/main/notebooks/flower_classifier.ipynb)


An end-to-end Iris-dataset classifier with EDA, 8 models, SHAP interpretation, and a Streamlit UI.

## Table of Contents

- [Overview](#overview)
- [Key Results](#key-results)
- [Features](#features)
- [Quick Start](#quick-start)
- [Quick Verify](#quick-verify)
- [File Layout](#file-layout)
- [Next Steps](#next-steps)
- [License](#license)


## Overview

A compact end-to-end machine-learning project that:

1. Explores the classic **Iris** dataset (150 samples, 4 numeric features, 3 species)  
2. Benchmarks **8 traditional classifiers** with hyper-parameter search  
3. Interprets the winning model with **SHAP**  
4. Saves the best pipeline and serves it through a **Streamlit** app  

---

## Key Results

- Achieved **100% test coverage** (Codecov verified)
- Trained and compared **8 classification models** (e.g., SVM, KNN, Random Forest)
- Best model: **Support Vector Machine (SVM)** with **97.3% accuracy**
- Used **SHAP** for model interpretability and feature impact visualization
- Delivered an interactive **Streamlit UI** for real-time classification


| Metric                        | Score |
|-------------------------------|-------|
| Majority-class baseline accuracy  | 0.33  |
| **Best model (SVM) macro-F1**     | **0.98** |
| Test accuracy (SVM)               | 0.97  |

---

## Features 
- Exploratory Data Analysis (EDA) with visualizations of Iris dataset
- 100% test coverage with pytest and GitHub Actions
- 8 trained classifiers compared (SVM, KNN, Logistic Regression, etc.)
- Best model selection based on cross-validated accuracy
- Model interpretability using SHAP (feature importance plots)
- Streamlit web app for live flower species prediction
- Joblib model export and cache directory setup
- Modular project layout with setup.py, requirements.txt, and environment.yml
- Colab-compatible notebook with preloaded model

---
## Quick Start

### 0) GitHub cloning
```bash
git clone git@github.com:shaolinpat/flower_classifier.git  
cd flower_classifier  
```

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
bash scripts/register_kernel.sh
```

### 2) Run the notebook
```bash
jupyter notebook notebooks/flower_classifier.ipynb
# or in VS Code:
code notebooks/flower_classifier.ipynb
# or in Colab by clicking the Colab badge at the top
```

### 3) Launch the Streamlit app
```bash
streamlit run scripts/steamlit_app.py
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
flower_classifier/
├── flower_classifier/ # Python package
│ ├── init.py
│ └── data_prep.py
├── notebooks/
│ └── flower_classifier.ipynb
├── scripts/
│ ├── flower_classifier_app.py
│ ├── health_check.sh
│ └── badges.txt
├── tests/
│ └── test_data_prep.py
├── models/ # .gitignored
├── .github/
│ └── workflows/
│ └── ci.yml
├── .gitignore
├── README.md
├── LICENSE
├── requirements.txt
├── environment.yml
└── setup.py
```

---

## Next Steps

- **Colab Support**  
  Added an “Open in Colab” badge and notebook with install instructions  
  _(Tip: consider using a lightweight `requirements-colab.txt` for speed)_

- **Continuous Integration (CI)**  
  GitHub Actions workflow configured to:
  - Install dependencies
  - Run `pytest`
  - Execute notebook via `nbconvert`
  - (Optional) Smoke test Streamlit app launch

- **Unit Testing Improvements**  
  - Add more `pytest` coverage for data transformation, model loading, and inference
  - Consider adding tests for Streamlit routing logic (mocked if needed)

- **Documentation & Polish**  
  - Add sample output screenshots (EDA, SHAP, model results)
  - Improve docstrings and inline comments
  - Refactor notebook into shorter modular scripts if needed

- **Optional Enhancements**  
  - Add a CLI with `argparse` for batch predictions
  - Add Dockerfile for reproducible deployment
  - Upload demo video/gif to the README


---

## 📝 License

This project is licensed under the [MIT License](LICENSE).


*Built with scikit-learn 1.5 · Streamlit 1.33 · Python 3.11*  
