# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Little CAD tool for taking photographs of a mask ROMs and extracting the bits"
HOMEPAGE="https://github.com/travisgoodspeed/maskromtool/"

EGIT_REPO_URI="https://github.com/travisgoodspeed/${PN}.git"
EGIT_BRANCH="master"

RESTRICT="mirror"
LICENSE="COPYING"
SLOT="0"


DEPEND=">=dev-qt/qtcharts-5"
RDEPEND="${DEPEND}"

src_compile()
{
	mkdir build
	cd build
	cmake .. || die "CMake failed"
	emake clean all || die "Make failed"
}

src_install()
{
	default 
		
	exeinto "/usr/bin"
	dobin "build/${PN}"
}
