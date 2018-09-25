#!/bin/bash

set -e

PROJECT_ROOT=..
TOOLS_PATH=$PROJECT_ROOT/tool
SDK_PATH=$PROJECT_ROOT/sdk

ARM_GCC_PATH=$TOOLS_PATH/gcc-arm-none-eabi-5_4-2016q3
NRF5X_COMMAND_LINE_PATH=$TOOLS_PATH/nRF5x-Command-Line-Tools_9_7_3
NRF5_SDK_12_3_0_PATH=$SDK_PATH/nRF5_SDK_12.3.0_d7731ad

ARM_GCC_LINK=https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
NRF5X_COMMAND_LINE_LINK=https://www.nordicsemi.com/eng/nordic/download_resource/51392/29/85293435/94917
NRF5_SDK_12_3_0_LINK=https://www.nordicsemi.com/eng/nordic/download_resource/54291/56/91735559/32925


function tool(){
    echo "> install arm gcc tool ..."
    if [ ! -d $ARM_GCC_PATH ]; then 
        pack=gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 
        wget -O $pack $ARM_GCC_LINK 
		tar -xjvf $pack 
		rm -rf $pack 
	fi

    echo "> install nRF5x command line tool ..."
    if [ ! -d $NRF5X_COMMAND_LINE_PATH ]; then 
        pack=nRF5x-Command-Line-Tools_9_7_3_Linux-x86_64.tar
        wget  -O $pack $NRF5X_COMMAND_LINE_LINK
        mkdir $NRF5X_COMMAND_LINE_PATH
        tar -xvf $pack -C $NRF5X_COMMAND_LINE_PATH
        rm -rf $pack 
    fi

    echo "> install nRF5 SDK 12.3.0 ..."
    if [ ! -d $NRF5_SDK_12_3_0_PATH ]; then 
        if [ ! -d $SDK_PATH ]; then
            mkdir -p $SDK_PATH
        fi

        pack=nRF5_SDK_12.3.0_d7731ad
        wget -O $pack.zip $NRF5_SDK_12_3_0_LINK 
        unzip -X $pack.zip
        rm -rf $pack.zip
        mv $pack $SDK_PATH
    fi

    echo "> update the *.posix file, when the project root is changed ..."
    t_arm_gcc_path=`pwd`/gcc-arm-none-eabi-5_4-2016q3
    posix_file=$NRF5_SDK_12_3_0_PATH"/components/toolchain/gcc/Makefile.posix"
    echo "GNU_INSTALL_ROOT := $t_arm_gcc_path" > $posix_file
    echo "GNU_VERSION := 5.4.1" >> $posix_file
    echo "GNU_PREFIX := arm-none-eabi" >> $posix_file
}

function clean(){
    echo "Cleaning..."
    rm -rf $ARM_GCC_PATH
    rm -rf $NRF5X_COMMAND_LINE_PATH
    rm -rf $NRF5_SDK_12_3_0_PATH
}


if [ "$1" == "clean" ]; then
    clean
elif [ "$1" == "tool" ]; then
    tool
else
    echo "error"
fi