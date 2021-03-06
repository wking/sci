# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/fasttree/fasttree-2.0.1.ebuild,v 1.1 2009/09/10 23:14:22 weaver Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="Rapid reconstruction of phylogenies by the Neighbor-Joining method"
HOMEPAGE="http://www.sanger.ac.uk/Software/analysis/quicktree/"
SRC_URI="ftp://ftp.sanger.ac.uk/pub4/resources/software/quicktree/quicktree.tar.gz -> quicktree-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}/${PN}_${PV}

src_prepare() {
	sed -e "s/\-O2 \-Wall/${CFLAGS}/" \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" LFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin bin/quicktree || die
	dodoc README || die
}
