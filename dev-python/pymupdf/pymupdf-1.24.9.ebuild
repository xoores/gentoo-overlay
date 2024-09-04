# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Yes, this ebuild does trigger a QA warning about "one or more Python
# modules not being byte-compiled", but it was quite a PITA to make the
# package atleast compile & install. I honestly don't know how to fix 
# this, so if anyone else want's to improve on this, feel free and please
# either do a PR or push it into main gentoo :)


EAPI=8

PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1

DESCRIPTION="High performance Python library for data extraction, analysis, conversion & manipulation of PDF"
HOMEPAGE="https://github.com/pymupdf/PyMuPDF/"
SRC_URI="https://github.com/pymupdf/PyMuPDF/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
https://mupdf.com/downloads/archive/mupdf-${PV}-source.tar.gz -> mupdf-${PV}-source.tar.gz"


LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-tesseract"
RESTRICT="mirror test"

RDEPEND="
	=app-text/mupdf-${PV}
	dev-lang/swig
	tesseract? ( dev-python/pytesseract[${PYTHON_USEDEP}] )
	dev-python/clang-python[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/PyMuPDF-${PV}"

python_compile() {
	true
}

python_install() {
	export PYMUPDF_SETUP_MUPDF_BUILD="${WORKDIR}/mupdf-1.24.9-source"
	
	if ! use tesseract; then
		export PYMUPDF_SETUP_MUPDF_TESSERACT=0
	fi
	
	esetup.py install --root "${D}"
}
