# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Firebird RDBMS bindings for Python."
HOMEPAGE="https://pypi.python.org/pypi/fdb/"
SRC_URI="mirror://pypi/f/fdb/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
SLOT="0"

RDEPEND="dev-db/firebird"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
