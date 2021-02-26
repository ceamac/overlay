# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="A fast replacement for TigerVNC"
HOMEPAGE="https://www.turbovnc.org/"
SRC_URI="https://sourceforge.net/projects/turbovnc/files/${PV}/${P}.tar.gz/download -> ${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/jdk:1.8
	>=media-libs/libjpeg-turbo-2.0.0[java]
	!net-misc/tigervnc"
RDEPEND="${DEPEND}
	x11-apps/xkbcomp"

src_configure() {
	local mycmakeargs=(
		-DTJPEG_JAR=/usr/share/java/turbojpeg.jar
		-DTJPEG_JNILIBRARY=/usr/lib64/libturbojpeg.so
		-DXKB_BIN_DIRECTORY=/usr/bin
		-DXKB_DFLT_RULES=base
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	find "${D}/usr/share/man/man1/" -name Xserver.1\* -print0 | xargs -0 rm
	einstalldocs
}
