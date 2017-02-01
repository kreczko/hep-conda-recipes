#!/bin/sh
#ln -s $PREFIX/lib $PREFIX/lib64
#echo $PATH
echo "Prefix: ${PREFIX}"
echo $LD_RUN_PATH

export CFLAGS="-Wall -g -m64 -pipe -O2 -march=x86-64 -fPIC"
export CXXLAGS="${CFLAGS}"
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="-L${PREFIX}/lib"
echo $LD_LIBRARY_PATH
export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"


echo 'gcc version'
gcc -v
g++ -v
PWD=`pwd`
if [ `uname` = "Darwin" ] ; then
  # In older verisons, cmake will use gcc and c++ for the C and C++ compilers.
  # On Mac OS X, these invoke different compilers (llvm gnu and clang,
  # respectively).
  # For newer versions of OS X (10.9.x and later), use Clang.
  # For older versions, use GCC.
  if sw_vers | grep -q 'ProductVersion: 10.[91]' ; then
    CC=cc
    CXX=c++
  else
    CC=gcc
    CXX=g++
  fi
  export CC
  export CXX
fi
#CMAKE_INCLUDE_PATH=$PREFIX/include CMAKE_LIBRARY_PATH=$PREFIX/lib
cmake -DPROPER:BOOL=FALSE \
      -DCLIPPED:BOOL=TRUE \
      -DWITH_BLAHP:BOOL=FALSE \
      -DWITH_COREDUMPER:BOOL=FALSE \
      -DWITH_CREAM:BOOL=FALSE \
      -DWITH_DRMAA:BOOL=FALSE \
      -DWITH_GLOBUS:BOOL=FALSE \
      -DWITH_GSOAP:BOOL=FALSE \
      -DWITH_HADOOP:BOOL=FALSE \
      -DWITH_LIBVIRT:BOOL=FALSE \
      -DWITH_LIBXML2:BOOL=FALSE \
      -DWITH_UNICOREGAHP:BOOL=FALSE \
      -DWITH_VOMS:BOOL=FALSE \
      -DWITH_BOINC:BOOL=FALSE \
      -DWITH_LIBCGROUP:BOOL=FALSE \
      -DWITH_GANGLIA:BOOL=FALSE \
      -DWITH_CAMPUSFACTORY:BOOL=FALSE \
      -DWITH_BOSCO:BOOL=FALSE \
      -DWANT_GLEXEC:BOOL=FALSE \
      -DBUILD_TESTING:BOOL=FALSE \
      -DWITH_QPID:BOOL=FALSE \
      -DWITH_LIBDELTACLOUD:BOOL=FALSE \
      -DUW_BUILD:BOOL=TRUE \
      -D_VERBOSE:BOOL=TRUE \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DCMAKE_PREFIX_PATH="${PREFIX}" \
      -DBOOST_LIBRARYDIR="${PREFIX}/lib" \
      -DCMAKE_EXE_LINKER_FLAGS="-L${PREFIX}/lib" \
      -DCMAKE_MODULE_LINKER_FLAGS="-L${PREFIX}/lib" \
      -DCMAKE_SHARED_LINKER_FLAGS="-L${PREFIX}/lib"
#-DBUILDID:STRING=UW_development \

# flags not working with older htcondor versions:
# - -DWITH_KRB5:BOOL=FALSE


make -j${CPU_COUNT}
make install
