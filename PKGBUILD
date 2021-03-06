# Maintainer: Renato Silva <br.renatosilva@gmail.com>

_realname='nsis'
pkgbase="mingw-w64-${_realname}"
pkgname="${MINGW_PACKAGE_PREFIX}-${_realname}"
pkgver=3.01
pkgrel=1
url='https://nsis.sourceforge.io/'
pkgdesc='Windows installer development tool (mingw-w64)'
license=(ZLIB)
arch=(any)
depends=(${MINGW_PACKAGE_PREFIX}-zlib
         ${MINGW_PACKAGE_PREFIX}-gcc-libs
         ${MINGW_PACKAGE_PREFIX}-libwinpthread)
makedepends=(${MINGW_PACKAGE_PREFIX}-gcc
             'dos2unix'
             'scons>=2.3.4-3'
             rsync)
source=("https://sourceforge.net/projects/nsis/files/NSIS%203/${pkgver}/${_realname}-${pkgver}-src.tar.bz2"
        001-fhs-directory-structure.patch
        002-compile-fixes.patch
        003-remove-redundant-architecture-suffix.patch)
sha256sums=('604c011593be484e65b2141c50a018f1b28ab28c994268e4ecd377773f3ffba1'
            '70e21760b037b03c6b73b3babb418c386ee2e2c18f4c99a5c3b9040c1a18b20f'
            '633549b525d274d8507e6c537cc29822af4188c394e0a250e45e6b425a01dba3'
            '0a7a2f7c671d7776def53e2e0974b803096409fc886e78393761092556084d9e')

# Circumvent problem where makepkg will add the exe extension to some files
# when compressing the 64-bit package
options=('!strip')

consolidate() {
    msg2 'Converting to unix line breaks'
    find -name 'SConstruct' | xargs dos2unix --quiet
    find -name 'SConscript' | xargs dos2unix --quiet
    find -name '*.[ch]'     | xargs dos2unix --quiet
    find -name '*.cpp'      | xargs dos2unix --quiet
    find -name '*.py'       | xargs dos2unix --quiet
}

prepare() {
    cd "${srcdir}/${_realname}-${pkgver}-src"
    consolidate
    patch -p1 < "${startdir}"/001-fhs-directory-structure.patch
    patch -p1 < "${startdir}"/002-compile-fixes.patch
    patch -p1 < "${startdir}"/003-remove-redundant-architecture-suffix.patch
}

_build() {
    local target_arch="${CARCH/i686/x86}"
    target_arch="${target_arch/x86_64/amd64}"

    local major_version="${pkgver%%.*}"
    local minor_version="${pkgver#*.}"
    minor_version="${minor_version%%[a-z]*}"
    msg2 "Major version defined as ${major_version}"
    msg2 "Minor version defined as ${minor_version}"

    cd "${srcdir}/build-${CARCH}-${_realname}-${pkgver}"
    echo "Howdy from modified PKGBUILD!"
    scons \
        ${SCONS_OPTS} \
        APPEND__LIBFLAGS="-lgdi32 -luser32 -lpthread -liconv -lshlwapi -lversion -lz" \
        AS=gcc \
        APPEND_ASFLAGS="-x assembler-with-cpp -c" \
        APPEND_CCFLAGS="-pthread -g -fexceptions" \
        TARGET_ARCH="${target_arch}" \
        PREFIX="${MINGW_PREFIX}" \
        VERSION="${pkgver}" \
        VER_MAJOR="${major_version}" \
        VER_MINOR="${minor_version}" \
        UNICODE='yes' \
        NSIS_MAX_STRLEN='8192' \
        NSIS_CONFIG_CONST_DATA_PATH='no' \
        SKIPUTILS='NSIS Menu,SubStart' \
        PREFIX_DEST="${PREFIX_DEST}" \
        ${target}
}

build() {
    msg2 'Synchronizing build directory'
    rsync --recursive --times "${srcdir}/${_realname}-${pkgver}-src"/* "${srcdir}/build-${CARCH}-${_realname}-${pkgver}"
    _build
}

package() {
    PREFIX_DEST="${pkgdir}" target='install' _build
    install -Dm644 "${pkgdir}${MINGW_PREFIX}/share/doc/nsis/COPYING" "${pkgdir}${MINGW_PREFIX}/share/licenses/${_realname}/COPYING"
    rm "${pkgdir}${MINGW_PREFIX}/share/doc/nsis/COPYING"
}
# vi: set ts=4 sts=4 sw=4 et ai ft=sh: #
