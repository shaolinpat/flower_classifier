#!/usr/bin/env bash
set -e

PROJECT_ROOT=~/Dropbox/VT-MIT/JobHunt/Projects/flower_classifier
TEST_DIR=~/flower_test

################################################################################
# 0) Prepare a fresh test folder
################################################################################
rm -rf $TEST_DIR
cp -r $PROJECT_ROOT $TEST_DIR
cd $TEST_DIR

################################################################################
# 1) Deactivate any active Conda env
################################################################################
conda deactivate || true

################################################################################
# 2) VENV TEST
################################################################################
echo
echo "=== VENV TEST ==="

rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
pip install nbconvert jupyterlab ipywidgets

jupyter nbconvert --to html --execute flower_classifier.ipynb --output test_venv.html
echo "✅ venv: test_venv.html created"

nohup streamlit run flower_classifier_app.py --server.headless true &> st_venv.log &
sleep 5
curl -I http://localhost:8501 && echo "✅ venv: Streamlit OK"
pkill -f "streamlit run flower_classifier_app.py"
deactivate

################################################################################
# 3) CONDA TEST
################################################################################
echo
echo "=== CONDA TEST ==="

conda create -n iris_test python=3.11 -y
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate iris_test

pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
pip install nbconvert jupyterlab ipywidgets

jupyter nbconvert --to html --execute flower_classifier.ipynb --output test_conda.html
echo "✅ conda: test_conda.html created"

nohup streamlit run flower_classifier_app.py --server.headless true &> st_conda.log &
sleep 5
curl -I http://localhost:8501 && echo "✅ conda: Streamlit OK"
pkill -f "streamlit run flower_classifier_app.py"

conda deactivate
conda env remove -n iris_test -y

echo
echo "🎉 All tests passed under both venv and Conda!"
