# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${P}_linux"

DESCRIPTION="robust automatic backbone assignment of proteins"
HOMEPAGE="http://www.mpibpc.mpg.de/groups/zweckstetter/_links/software_mars.htm"
SRC_URI="http://www.mpibpc.mpg.de/groups/zweckstetter/_software_files/_${PN}/${MY_P}.tar.Z"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="as-is"
IUSE="examples"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

src_install() {
	dobin bin/runmars* || die

	exeinto /opt/${PN}/
	doexe bin/{${PN},calcJC-S2,runmars*,*.awk} || die
	insinto /opt/${PN}/
	doins bin/*.{tab,txt} || die
	if use examples; then
		insinto /usr/share/${PN}/
		doins -r example || die
	fi

	dohtml -r html/* || die

	cat >> "${T}"/23mars <<- EOF
	MARSHOME="${EPREFIX}/opt/${PN}"
	EOF

	doenvd "${T}"/23mars || die
}