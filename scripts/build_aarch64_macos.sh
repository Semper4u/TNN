#!/bin/bash

SHARED_LIB="ON"
ARM="ON"
ARM82="ON"
METAL="OFF"
DEBUG="OFF"
MODEL_CHECK="OFF"
PROFILE="OFF"
TARGET_ARCH=aarch64

CC=`which clang`
CXX=`which clang++`

if [ -z $TNN_ROOT_PATH ]
then
    TNN_ROOT_PATH=$(cd `dirname $0`; pwd)/..
fi

BUILD_DIR=build_aarch64_macos
if [ $DEBUG == "ON" ]; then
    BUILD_DIR=${BUILD_DIR}_debug
fi

rm -rf $BUILD_DIR
mkdir $BUILD_DIR
cd $BUILD_DIR

cmake ${TNN_ROOT_PATH} \
    -DCMAKE_C_COMPILER=$CC \
    -DCMAKE_CXX_COMPILER=$CXX \
    -DTNN_TEST_ENABLE=ON \
    -DTNN_UNIT_TEST_ENABLE=ON \
    -DDEBUG:BOOL=$DEBUG \
    -DTNN_CPU_ENABLE=ON \
    -DTNN_ARM_ENABLE:BOOL=$ARM \
    -DTNN_ARM82_ENABLE:BOOL=$ARM82 \
    -DTNN_OPENCL_ENABLE:BOOL=$OPENCL \
    -DTNN_METAL_ENABLE:BOOL=$METAL \
    -DCMAKE_SYSTEM_PROCESSOR=$TARGET_ARCH \
    -DTNN_MODEL_CHECK_ENABLE=$MODEL_CHECK \
    -DTNN_PROFILER_ENABLE=$PROFILE \
    -DTNN_BUILD_SHARED:BOOL=$SHARED_LIB


make -j10
