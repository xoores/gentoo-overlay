# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit git-r3 distutils-r1

DESCRIPTION="Python (py) gdb machine interface (mi)"
HOMEPAGE="https://github.com/cs01/pygdbmi"
EGIT_REPO_URI="https://github.com/cs01/pygdbmi.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=""
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
