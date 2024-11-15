export PSPDEV=$(pwd)/pspdev
export PATH=$PATH:$PSPDEV/bin

# binutils by pspdev developers

## Exit with code 1 when any command executed returns a non-zero exit code.
onerr()
{
  exit 1;
}
trap onerr ERR

## Download the source code.
REPO_URL="https://github.com/pspdev/binutils-gdb.git"
REPO_REF="allegrex-v2.40.0"
REPO_FOLDER="$(s="$REPO_URL"; s=${s##*/}; printf "%s" "${s%.*}")"

git clone --depth 1 -b "$REPO_REF" "$REPO_URL" "$REPO_FOLDER"

cd "$REPO_FOLDER"

TARGET="psp"
TARG_XTRA_OPTS=""

## Determine the maximum number of processes that Make can work with.
PROC_NR=$(getconf _NPROCESSORS_ONLN)

## Create and enter the toolchain/build directory
rm -rf build-$TARGET && mkdir build-$TARGET && cd build-$TARGET

## Configure the build.
../configure \
  --quiet \
  --prefix="$PSPDEV" \
  --target="$TARGET" \
  --with-sysroot="$PSPDEV/$TARGET" \
  --enable-plugins \
  --disable-initfini-array \
  --with-python="auto" \
  --disable-werror \
  $TARG_XTRA_OPTS

## Compile and install.
make --quiet -j $PROC_NR clean
make --quiet -j $PROC_NR all
make --quiet -j $PROC_NR install-strip
make --quiet -j $PROC_NR clean