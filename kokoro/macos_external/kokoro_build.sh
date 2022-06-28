#!/bin/bash

set -e
set -x

cd "${KOKORO_ARTIFACTS_DIR}/github/kokoro-phawkins"

git clone https://github.com/google/jax.git
python3.7 -m pip install -e jax
cd jax
python3.7 install https://storage.googleapis.com/jax-releases/mac/jaxlib-0.3.14-cp37-none-macosx_10_14_x86_64.whl
python3.7 install pytest
pytest tests/fft_test.py
