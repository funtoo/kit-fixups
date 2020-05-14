# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="github.com/docker/libnetwork"

EGIT_COMMIT="e7933d41e7b206756115aa9df5e0599fc5169742"
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="*"
inherit golang-vcs-snapshot

DESCRIPTION="Docker container networking"
HOMEPAGE="https://github.com/docker/libnetwork"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

S=${WORKDIR}/${P}/src/${EGO_PN}

RESTRICT="test" # needs dockerd

src_compile() {
	GOPATH="${WORKDIR}/${P}" go build -o "bin/docker-proxy" ./cmd/proxy || die
}

src_install() {
	dodoc ROADMAP.md README.md CHANGELOG.md
	dobin bin/docker-proxy
}