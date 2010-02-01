# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="A Modular,Parallel,Multiprotocol, Network Login Auditor"
HOMEPAGE="http://www.foofus.net/jmk/medusa/medusa.html"
SRC_URI="http://www.foofus.net/jmk/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug ncp postgres +ssh2 subversion +untested-modules"

RDEPEND="ssh2? ( net-libs/libssh2 )
	ncp? ( net-fs/ncpfs )
	postgres? ( dev-db/libpq )
	subversion? ( dev-util/subversion )"
DEPEND="${RDEPEND}
	dev-libs/openssl
	sys-devel/autoconf
	sys-devel/automake"

src_configure() {
	econf \
		--with-default-mod-path="/usr/lib/medusa/modules" \
		`use_enable debug` \
		`use_enable untested-modules untested` \
		`use_with ssh2` \
		`use_with ncp` \
		`use_with postgres` \
		`use_with subversion svn` \
		|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"

	dodoc README TODO ChangeLog
	dohtml doc/*.html
}
