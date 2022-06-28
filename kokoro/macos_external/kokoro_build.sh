#!/bin/bash

set -e
set -x

cd "${KOKORO_ARTIFACTS_DIR}/github/kokoro-phawkins"

git clone https://github.com/google/jax.git
python3.10 -m pip install -e jax
cd jax
python3.10 install https://storage.googleapis.com/jax-releases/mac/jaxlib-0.3.14-cp310-none-macosx_10_14_x86_64.whl
python3.10 install pytest
pytest tests/fft_test.py
