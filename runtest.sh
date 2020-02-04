#!/bin/bash

DIR_SRC="./src"
DIR_SRC_RAM=${DIR_SRC}"/ram"

DIR_OUTPUT="build"

CC=iverilog
CC_ARGS=

SIM=vvp
SIM_ARGS=

WV=gtkwave
WV_ARGS=

if [[ ! -d ${DIR_SRC} ]]; then
    echo "${DIR_SRC} directory is not exist!"
    exit 0
fi

if [[ $1 == "ram" ]]; then
    echo "Compiling Ram ..."
    if [[ ! -d ${DIR_SRC_RAM} ]]; then
        echo "${DIR_SRC_RAM} directory is not exist!"
        exit 0
    fi

    dir=${DIR_SRC_RAM}"/"${DIR_OUTPUT}

    if [[ ! -d ${dir} ]]; then
        mkdir ${dir}
    fi
    ${CC} ${CC_ARGS} -s test -o ${dir}"/test.out" ${DIR_SRC_RAM}"/test.v" ${DIR_SRC_RAM}"/ram.v"
    echo "Done"

    echo "Start Simulation..."
    ${SIM} ${SIM_ARGS} ${dir}"/test.out"
    echo "Done"
    if [[ -f test.vcd ]]; then
        mv ./test.vcd ${dir}"/test.vcd" #move vcd file
        ${WV} ${WV_ARGS} ${dir}"/test.vcd"
    fi
    exit 0
fi

if [[ $1 == "clear" ]]; then
    for module in `ls ${DIR_SRC}`; do
        dir=${DIR_SRC}"/"${module}
        if [[ -d ${dir} ]]; then
            if [[ -d ${dir}"/build" ]]; then
                rm -rf ${dir}"/build"
            fi
        fi
    done
fi