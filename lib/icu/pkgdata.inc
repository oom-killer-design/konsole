GENCCODE_ASSEMBLY_TYPE=-a gcc-mingw64
SO=dll
SOBJ=dll
A=a
LIBPREFIX=
LIB_EXT_ORDER=71.dll
COMPILE=gcc   -DHAVE_DLOPEN=0 -DU_HAVE_MMAP=0 -DU_HAVE_STRTOD_L=0  -DWINVER=0x0601 -D_WIN32_WINNT=0x0601 -DU_ATTRIBUTE_DEPRECATED= -I/c/builds/sysadmin/ci-management/windows-mingw_64-gcc/include  -O2 -g -DNDEBUG  -std=c11 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -mthreads  -c
LIBFLAGS=-I/c/builds/sysadmin/ci-management/windows-mingw_64-gcc/include -DPIC 
GENLIB=gcc -I/c/builds/sysadmin/ci-management/windows-mingw_64-gcc/include  -O2 -g -DNDEBUG  -std=c11 -Wall -pedantic -Wshadow -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -mthreads  -L/c/builds/sysadmin/ci-management/windows-mingw_64-gcc/lib   -shared  -Wl,--enable-auto-import -Wl,--out-implib=./liball.dll.a
LDICUDTFLAGS=
LD_SONAME=
RPATH_FLAGS=
BIR_LDFLAGS=
AR=ar
ARFLAGS=r
RANLIB=ranlib
INSTALL_CMD=/usr/bin/install -c
