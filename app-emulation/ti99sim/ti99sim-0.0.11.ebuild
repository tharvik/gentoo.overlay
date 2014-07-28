# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Texas Instruments Home Computer Emulator"

SRC_URI="http://www.mrousseau.org/programs/ti99sim/archives/${P}.src.tar.gz
	roms? ( http://www.harmlesslion.com/zips/classic99.zip )"

HOMEPAGE="http://www.mrousseau.org/programs/ti99sim/"
# Classic99 http://www.harmlesslion.com/cgi-bin/showprog.cgi?search=Classic99 v373

IUSE="+roms"

RDEPEND="media-libs/libsdl[sound,video]"

DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/rules_CFLAGS.patch
	epatch "${FILESDIR}"/support-DATA_DIR.patch
	epatch "${FILESDIR}"/ti99-install1.patch
	epatch "${FILESDIR}"/ti99-install2.patch
	epatch "${FILESDIR}"/ti99-install3.patch
	sed -i -e 's:CFLAGS   \:= -g -O3:CFLAGS += -g:;s:ARCH:RESERVED:;s:Release:.:' rules.mak
}

src_configure() {
#	append-cflags "-fsigned-char"
#	append-cxxflags "-fsigned-char"
	export DATA_DIR=/usr/share/ti99sim
}

src_install() {
	export SYS_BIN=${D}/usr/bin
	export BIN_DIR=${D}/usr/bin
	export DATA_DIR=${D}/usr/share/ti99sim

	if use roms; then
		ewarn "Classic99 is a Windows freeware. System ROMs and many cartridges"
		ewarn "are INCLUDED in Classic99 under license from Texas Instruments."

		cd "${S}"/../classic99/src/roms
		# must be lowercase
		mv 994AGROM.BIN 994agrom.bin
		mv 994AROM.BIN 994arom.bin
		mv SPCHROM.BIN spchrom.bin
		mv DISK.BIN ti-disk.bin
		#
		"${S}"/src/util/convert-ctg 994a.bin
		"${S}"/src/util/convert-ctg --cru=1100 ti-disk.bin
		"${S}"/src/util/convert-ctg V-CHESSG.BIN
		"${S}"/src/util/convert-ctg CarWarsG.Bin
		"${S}"/src/util/convert-ctg PARSECG.BIN
		insinto /usr/share/ti99sim/roms/
		doins TI-994A.ctg
		doins ti-disk.ctg
		doins spchrom.bin
		insinto /usr/share/ti99sim/cartridges/
		doins V-CHESSG.ctg
		doins CarWarsG.ctg
		doins PARSECG.ctg
		cd "${S}"
	else
		ewarn "In order to run the emulator, you need to create a cartridge"
		ewarn "that contains the console ROM & GROMs from the TI-99/4A."
		ewarn "See http://www.mrousseau.org/programs/ti99sim/README.html."
	fi
	emake DESTDIR="${D}" install || die "emake install failed"
}