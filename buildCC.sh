#!/bin/bash

BINUTILS_VERSION="2.40"
GCC_VERSION="12.2.0"
DEPS_FOLDER="$PWD/deps"

export PREFIX="$PWD/cc"
export TARGET="i686-elf"
export PATH="$PREFIX/bin:$PATH"

rm -rf $PREFIX
rm -rf $DEPS_FOLDER
echo "[CrossC] Installing Dependencies..."
sudo apt update
sudo apt install build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo
echo "[CrossC] Finished Installing Dependencies!"
echo "[CrossC] Creating Build Tools..."
mkdir $DEPS_FOLDER
cd $DEPS_FOLDER
echo "[CrossC] Building Binutils..."
wget -O binutils.tar.gz https://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.gz
tar -zxf binutils.tar.gz
cd binutils-$BINUTILS_VERSION
mkdir build
cd build
../configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install
cd ../..
echo "[CrossC] Finished Building Binutils!"
echo "[CrossC] Building GCC..."
wget -O gcc.tar.gz https://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.gz
tar -zxf gcc.tar.gz
cd gcc-$GCC_VERSION
which -- $TARGET-as || echo "[CrossC] $TARGET-as is not in the PATH"
mkdir build
cd build
../configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
cd ../..
echo "[CrossC] Finished Building GCC!"
