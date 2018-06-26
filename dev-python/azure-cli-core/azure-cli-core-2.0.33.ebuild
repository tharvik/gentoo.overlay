# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools Core Module"
HOMEPAGE="https://pypi.org/project/azure-cli-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86 ~arm"
LICENSE="MIT"
SLOT="0"

IUSE=""

RDEPEND="dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-16.2[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	>=dev-python/msrestazure-0.4.25[${PYTHON_USEDEP}]
	>=dev-python/msrest-0.4.4[${PYTHON_USEDEP}]
	>=dev-python/knack-0.3.2[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/humanfriendly[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	dev-python/azure-cli-nspkg[${PYTHON_USEDEP}]
	>=dev-python/argcomplete-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/applicationinsights-0.11.1[${PYTHON_USEDEP}]
	>=dev-python/adal-0.4.7[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# The proper __init__.py is provided by net-misc/azure-cli
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-cli-nspkg
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
}
