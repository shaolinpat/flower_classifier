#!/bin/bash
echo "Registering Jupyter kernel for iris..."

# Ensure conda is initialized
source "$(conda info --base)/etc/profile.d/conda.sh"

# Activate the iris environment
conda activate iris

# Register the kernel
python -m ipykernel install --user --name=iris --display-name="iris"

