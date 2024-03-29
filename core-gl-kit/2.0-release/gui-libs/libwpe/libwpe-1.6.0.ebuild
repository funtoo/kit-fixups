# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Platform-agnostic interfaces for WPE WebKit"
HOMEPAGE="https://wpewebkit.org/"
SRC_URI="https://wpewebkit.org/releases/${P}.tar.xz"

LICENSE="BSD-2"
SLOT="1.0"
IUSE=""

KEYWORDS="*"

RDEPEND="
	media-libs/mesa[egl]
	x11-libs/libxkbcommon
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_DOCS=OFF # hotdoc not packaged
	)

	cmake_src_configure
}
