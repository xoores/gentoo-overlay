# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8



#~ DISTUTILS_USE_PEP517=no
DISTUTILS_USE_PEP517=flit

PYTHON_COMPAT=( python3_{9..11} )

DESCRIPTION="A python script for sending desktop notifications from the shell"
HOMEPAGE="https://github.com/phuhl/notify-send.py"
RESTRICT="bindist mirror"

EGIT_REPO_URI="https://github.com/phuhl/notify-send.py"
EGIT_COMMIT="0575c79f10d10892c41559dd3695346d16a8b184"

KEYWORDS="amd64 arm arm64 ppc64 x86"

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

inherit git-r3 distutils-r1 

DEPEND="
	>=dev-lang/python-3.0
	dev-python/pygobject
	dev-python/dbus-python
	dev-python/flit-core
	"
RDEPEND="${DEPEND}"

