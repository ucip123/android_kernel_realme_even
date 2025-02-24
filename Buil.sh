#ubah nama kernel dan dev builder
export ARCH=arm64
export KBUILD_BUILD_USER="ucip"
export LOCALVERSION="KernelAbalAbal"

#mulai mengcompile kernel
[ -d "out" ] && rm -rf out  mkdir -p out

make O=out ARCH=arm64 k68v1_64_k419_defconfig

PATH="/workspace/zyc/bin:$PATH" \
make -j$(nproc --all) O=out \
      ARCH=arm64 \
      LD=ld.lld \
      NM=llvm-nm \
      AR=llvm-ar \
      CC="ccache clang" \
      CLANG_TRIPLE=aarch64-linux-gnu- \
      CROSS_COMPILE=aarch64-linux-gnu- \
      CROSS_COMPILE_ARM32=arm-linux-gnueabi-
      V=0 2>&1 | tee log.txt
