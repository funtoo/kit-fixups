# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5..7})

inherit eutils estack python-single-r1 rpm

DESCRIPTION="library for manipulating the International Press Telecommunications
Council (IPTC) metadata"
HOMEPAGE="http://libiptcdata.sourceforge.net"
SRC_URI="https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/30/Everything/SRPMS/Packages/l/${P}-1.fc30.src.rpm"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm arm64 ia64 ppc ppc64 sparc x86"
IUSE="doc examples nls python"

RDEPEND="python? ( ${PYTHON_DEPS} )
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.13.1 )
	doc? ( >=dev-util/gtk-doc-1 )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure () {
	econf \
		$(use_enable nls) \
		$(use_enable python) \
		$(use_enable doc gtk-doc)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed."

	if use examples; then
		insinto /usr/share/doc/${PF}/python
		doins python/README || die "doins failed"
		doins -r python/examples || die "doins 2 failed"
	fi

	find "${D}" -name '*.la' -delete || die "failed to remove *.la files"
}
