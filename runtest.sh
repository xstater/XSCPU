#!/bin/bash

DIR_SRC="./src"

DIR_OUTPUT="build"

CC=iverilog
CC_ARGS=

SIM=vvp
SIM_ARGS=

WV=gtkwave
WV_ARGS=

echo "Clearing build directories..."
for module in `ls ${DIR_SRC}`; do
    dir=${DIR_SRC}"/"${module}
    if [[ -d ${dir} ]]; then
        if [[ -d ${dir}"/build" ]]; then
            rm -rf ${dir}"/build"
        fi
    fi
done
echo "Done"

if [[ $1 == "" ]]; then
    exit 0;
fi;

if [[ $1 != "ram"  && $1 != "alu" && $1 != "pc" ]]; then
    echo "Unknow module name!"
    exit 1;
fi

MODULE_DIR=${DIR_SRC}"/"$1
MODULE_BUILD_DIR=${MODULE_DIR}"/"${DIR_OUTPUT}

if [[ ! -d ${MODULE_DIR} ]]; then
    echo "Module directory is not exist!"
    exit 1;
fi

if [[ ! -d ${MODULE_BUILD_DIR} ]]; then
    mkdir ${MODULE_BUILD_DIR}
fi

echo "Compiling Module "$1"..."
${CC} ${CC_ARGS} -s test -o ${MODULE_BUILD_DIR}"/test.out" ${MODULE_DIR}"/test.v" ${MODULE_DIR}"/"$1".v"

if [[ ! -f ${MODULE_BUILD_DIR}"/test.out" ]]; then
    echo "Compiling Failed!"
    exit 1;
fi
echo "Done"

echo "Start Simulation..."
${SIM} ${SIM_ARGS} ${MODULE_BUILD_DIR}"/test.out"
echo "Finish"

if [[ -f "./test.vcd" ]]; then
    mv "./test.vcd" ${MODULE_BUILD_DIR}"/test.vcd"
    echo "Open GTKWAVE..."
    ${WV} ${WV_ARGS} ${MODULE_BUILD_DIR}"/test.vcd"
    echo "Done"
fi
