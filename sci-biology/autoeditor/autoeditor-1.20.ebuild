# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="AutoEditor is a program that can automatically correct discrepancies in a
multiple alignment by reanalyzing the chromatograms of the discrepant bases."
HOMEPAGE="http://sourceforge.net/apps/mediawiki/amos/index.php?title=AutoEditor"
SRC_URI="ftp://ftp.cbcb.umd.edu/pub/software/autoEditor/autoEditor-1.20.tar.gz
		test? ( ftp://ftp.cbcb.umd.edu/pub/software/autoEditor/autoEditor-1.20-sample.tar.gz )"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sci-libs/io_lib-1.8.11
		sys-libs/zlib
		sci-biology/tigr-foundation-libs"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/autoEditor-1.20

src_prepare(){
	epatch "${FILESDIR}"/Makefile.patch || die
	rm -rf TigrFoundation-2.0 || die "Failed to drop TigrFoundation-2.0/"
}

src_compile(){
	emake || die
}

src_install(){
	emake install DESTDIR="${D}" || die
}

# TODO:
#  * QA Notice: Package has poor programming practices which may compile
#  *            fine but exhibit random runtime failures.
#  * getConsQV.c:1051: warning: implicit declaration of function 'memset'

src_test(){
	make sample > sample.out || die
	diff -u -w "${FILESDIR}"/sample_expected.out sample.out || die
}