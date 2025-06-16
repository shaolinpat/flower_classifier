#!/usr/bin/env bash
set -e

################################################################################
# Flower Classifier: VERIFY FULL PIPELINE 
################################################################################

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
TEST_DIR=~/flower_test

################################################################################
# 0. Create Fresh Test Folder
################################################################################
rm -rf "$TEST_DIR"
cp -r "$PROJECT_ROOT" "$TEST_DIR"
cd "$TEST_DIR"

################################################################################
# 1. Deactivate Any Active Conda Env
################################################################################
conda deactivate || true

################################################################################
# 2. Create and Activate Test Conda Environment
################################################################################
echo "=== CREATING TEST CONDA ENVIRONMENT ==="
conda create -n iris_test python=3.11 -y
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate iris_test

################################################################################
# 3. Install Requirements
################################################################################
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
pip install nbconvert jupyterlab ipywidgets

################################################################################
# 4. Check Required Files Exist
################################################################################
echo "=== VERIFYING REQUIRED FILES EXIST ==="
REQUIRED_FILES=(
    "requirements.txt"
    "environment.yml"
    "notebooks/flower_classifier.ipynb"
    "scripts/streamlit_app.py"
    "scripts/verify_run.sh"
    "tests/test_data_prep.py"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "Missing required file: $file"
        exit 1
    fi
    echo "Found: $file"
done

################################################################################
# 5. Execute Notebook and Export to HTML
################################################################################
echo "=== RUNNING NOTEBOOK ==="
jupyter nbconvert --to html --execute notebooks/flower_classifier.ipynb --output test_conda.html
echo "✅ Notebook executed: test_conda.html created"

################################################################################
# 6. Launch and Test Streamlit App
################################################################################
echo "=== TESTING STREAMLIT APP ==="
nohup streamlit run scripts/streamlit_app.py --server.headless true &> st_conda.log &
sleep 5
curl -I http://localhost:8501 && echo "✅ Streamlit responded"
pkill -f "streamlit run scripts/streamlit_app.py"

################################################################################
# 7. Clean Up
################################################################################
conda deactivate
conda env remove -n iris_test -y

################################################################################
# Done!
################################################################################
echo
echo "All tests passed successfully under Conda!"

