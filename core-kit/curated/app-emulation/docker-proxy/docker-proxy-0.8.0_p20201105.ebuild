# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/docker/libnetwork"

EGIT_COMMIT="55e924b8a84231a065879156c0de95aefc5f5435"
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS=""
inherit golang-vcs-snapshot

DESCRIPTION="Docker container networking"
HOMEPAGE="https://github.com/docker/libnetwork"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

S=${WORKDIR}/${P}/src/${EGO_PN}

# needs dockerd
RESTRICT="test"

src_compile() {
	GOPATH="${WORKDIR}/${P}" go build -o "bin/docker-proxy" ./cmd/proxy || die
}

src_install() {
	dodoc README.md CHANGELOG.md
	dobin bin/docker-proxy
}
