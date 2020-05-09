# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit golang-build bash-completion-r1 golang-vcs-snapshot

EGO_PN="github.com/rclone/${PN}"

DESCRIPTION="A program to sync files to and from various cloud storage providers"
HOMEPAGE="https://rclone.org/"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="*"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin ${PN}
	doman src/${EGO_PN}/${PN}.1
	dodoc src/${EGO_PN}/README.md

	./rclone genautocomplete bash ${PN}.bash || die
	newbashcomp ${PN}.bash ${PN}

	./rclone genautocomplete zsh ${PN}.zsh || die
	insinto /usr/share/zsh/site-functions
	newins ${PN}.zsh _${PN}
}
