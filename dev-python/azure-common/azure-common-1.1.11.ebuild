# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Client Library for Python (Common)"
HOMEPAGE="https://pypi.org/project/azure-common"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~x86 ~arm"
LICENSE="MIT"
SLOT="0"

#RDEPEND="dev-python/extras[${PYTHON_USEDEP}]
RDEPEND="<dev-python/msrestazure-2.0.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	# avoiding file collision with net-misc/azure-cli
	python_export PYTHON_SITEDIR
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
}
