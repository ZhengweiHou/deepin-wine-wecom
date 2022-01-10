# Maintainer: sirius <916108538@qq.com>

#pkgname=deepin-wine-work-weixin
pkgname=deepin-wine-work-weixin_hzwcustom
pkgver=3.1.23.6025
debpkgver=3.1.12.6001deepin8
debpkgname="com.qq.weixin.work.deepin"
winxin_installer_name="WeCom"
pkgrel=1
pkgdesc="Tencent WeixinWork on Deepin Wine(${debpkgname}) For Archlinux"
arch=("x86_64")
url="https://work.weixin.qq.com/"
license=('custom')
groups=()
depends=(
        'lib32-alsa-plugins' 'lib32-glib2' 'lib32-glibc' 'libgphoto2'
        'lib32-gst-plugins-base-libs' 'lib32-lcms2' 'lib32-libldap' 'lib32-mpg123'
        'lib32-openal' 'lib32-libpcap' 'lib32-libcanberra-pulse' 'lib32-libudev0-shim'
        'lib32-libusb' 'lib32-vkd3d' 'lib32-libx11' 'lib32-libxext' 'lib32-libxml2'
        'lib32-ocl-icd' 'deepin-udis86' 'lib32-zlib' 'lib32-ncurses' 'lib32-fontconfig'
        'lib32-freetype2' 'lib32-gettext' 'lib32-libxcursor' 'lib32-mesa' 'lib32-libjpeg6'
        'lib32-libxrandr' 'lib32-libxi' 'lib32-glu' 
        'deepin-wine5'
#        'deepin-wine-helper'
#        'deepin-wine6-stable'
    )
#        'deepin-wine5'
#        'deepin-wine6-stable'
makedepends=(
        'tar' 'p7zip'
)
conflicts=('deepin-wxwork' 'com.qq.weixin.work.deepin')
install=deepin-wine-work-weixin.install
source=(
    "https://com-store-packages.uniontech.com/appstore/pool/appstore/c/${debpkgname}/${debpkgname}_${debpkgver}_i386.deb"
    "${winxin_installer_name}_${pkgver}.exe::https://dldir1.qq.com/wework/work_weixin/${winxin_installer_name}_${pkgver}.exe"
    "run.sh"
)
noextract=("${debpkgname}_${debpkgver}_i386.deb")
md5sums=(
    '36c6c6cc6033468a3dd8f130d6f8afad'
    'f5b8b6611945367d72b31f15dabe60f0'
    'e0b2fc52e59f9f2a7a3e93ee6348fc61'
)


prepare() {
    msg "==prepare $(pwd)"
    msg "--startdir:${startdir}"
    msg "--srcdir:  ${srcdir}"
    msg "--pkgdir:  ${pkgdir}"
    
}

build() {
    msg "==build $(pwd)"

    msg "1. Extraction DPKG package ..."
	ar -x ${debpkgname}_${debpkgver}_i386.deb
	mkdir -p ${srcdir}/dpkgdir
	tar -xf data.tar.xz -C "${srcdir}/dpkgdir"
    # 添加应用到互联网分类
    sed "s/\(Categories.*$\)/\1Network;/" -i "${srcdir}/dpkgdir/opt/apps/${debpkgname}/entries/applications/${debpkgname}.desktop"

    sed "s/run.sh\".*/run.sh\"/" -i "${srcdir}/dpkgdir/opt/apps/${debpkgname}/entries/applications/${debpkgname}.desktop"

    msg "2. 提取Deepin Wine 企业微信文件..."
    if [ -d "${srcdir}/deepinwecomdir" ]; then
        echo "清除旧文件"
        rm -r ${srcdir}/deepinwecomdir
    fi
    7z x -aoa "${srcdir}/dpkgdir/opt/apps/${debpkgname}/files/files.7z" -o"${srcdir}/deepinwecomdir"

    msg "3.清理原始的企业微信文件..."
#    rm -r "${srcdir}/deepinwecomdir/drive_c/Program Files/WXDrive"
#    rm -r "${srcdir}/deepinwecomdir/drive_c/Program Files/WXWork"

    msg "4.修复注册表文件..."
    # TODO 需进行修复

    msg "5.添加字体软链接..."
#    ln -sf "/usr/share/fonts/wenquanyi/wqy-microhei/wqy-microhei.ttc" "${srcdir}/deepinwechatdir/drive_c/windows/Fonts/wqy-microhei.ttc"

    msg "6.拷贝企业微信安装文件"
    install -m644 "${srcdir}/${winxin_installer_name}_${pkgver}.exe" "${srcdir}/deepinwecomdir/drive_c/Program Files/"

    msg "7.Repackageing app archive ..."
    7z a -t7z -r "${srcdir}/files.7z" "${srcdir}/deepinwecomdir/*"
}

check() {
    msg "==check $(pwd)"
}

package() {
    msg "==package $(pwd)"
    msg "1.Preparing icons ..."
    install -d "${pkgdir}/usr/share/applications"
    install -Dm644 "${srcdir}/dpkgdir/opt/apps/${debpkgname}/entries/applications/${debpkgname}.desktop" "${pkgdir}/usr/share/applications/${debpkgname}.desktop"
    cp -r "${srcdir}/dpkgdir/opt/apps/${debpkgname}/entries/icons/" "${pkgdir}/usr/share/"

    msg "2.Copying deepin files ..."
    install -d "${pkgdir}/opt/apps/${debpkgname}/files"
    cp -r "${srcdir}/dpkgdir/opt/apps/${debpkgname}/files/dlls" "${pkgdir}/opt/apps/${debpkgname}/files/"
    install -m644 "${srcdir}/files.7z" "${pkgdir}/opt/apps/${debpkgname}/files/"
    md5sum "${srcdir}/files.7z" | awk '{ print $1 }' > "${pkgdir}/opt/apps/${debpkgname}/files/files.md5sum" 
    install -m755 "${srcdir}/run.sh" "${pkgdir}/opt/apps/${debpkgname}/files/"
}



