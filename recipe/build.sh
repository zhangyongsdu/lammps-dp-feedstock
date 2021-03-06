#!/bin/bash

cp -r ${PREFIX}/share/USER-DEEPMD src/
mkdir build
cd build
if [ ${float_prec} == "high" ]; then
    export PREC_DEF="-DHIGH_PREC"
fi
if [ ${dp_variant} == "gpu" ]; then
    export DEEPMD_CUDA_LINK="-ldeepmd_op_cuda"
fi
cmake -D PKG_USER-DEEPMD=ON -D PKG_USER-MISC=ON -D FFT=FFTW3 -D CMAKE_INSTALL_PREFIX=${PREFIX} -D CMAKE_CXX_FLAGS="${PREC_DEF} -I${PREFIX}/include -I${PREFIX}/include/deepmd -L${PREFIX}/lib -Wl,--no-as-needed -lrt -ldeepmd_op ${DEEPMD_CUDA_LINK} -ldeepmd -ltensorflow_cc -ltensorflow_framework -Wl,-rpath=${PREFIX}/lib" ../cmake
make -j${NUM_CPUS}
make install
cd ..
