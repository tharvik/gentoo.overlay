# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

DESCRIPTION="Firebird RDBMS bindings for Python."
HOMEPAGE="https://pypi.python.org/pypi/fdb/"
SRC_URI="mirror://pypi/f/fdb/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
SLOT="0"

RDEPEND="dev-db/firebird"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-python/setuptools"

src_prepare() {
	eapply "${FILESDIR}"/fix_syntax.patch
	eapply_user
}