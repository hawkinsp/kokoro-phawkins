#!/bin/bash

set -e
set -x

cd "${KOKORO_ARTIFACTS_DIR}/github/kokoro-phawkins"

git clone https://github.com/hawkinsp/jax.git
cd jax
git checkout faulthandler
python3.7 -m pip install --user --upgrade pip 
python3.7 -m pip install --user -e jax
python3.7 -m pip install --user https://storage.googleapis.com/jax-releases/mac/jaxlib-0.3.14-cp37-none-macosx_10_14_x86_64.whl
python3.7 -m pip install --user pytest
#python3.7 -m pytest tests/fft_test.py
echo run > t.txt
echo thread backtrace all >> t.txt
#sed -i.old 's|# Copyright 2019 Google LLC|import faulthandler; faulthandler.disable()|' tests/fft_test.py
#lldb --batch -s t.txt python3.7 -- tests/fft_test.py
ulimit -c unlimited && (python3.7 tests/fft_test.py || (lldb -c `ls -t /cores/* | head -n1` \
    --batch -o 'thread backtrace all' -o 'quit' && exit 1))
