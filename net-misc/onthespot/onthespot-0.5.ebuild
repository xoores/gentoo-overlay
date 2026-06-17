# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="qt based music downloader written in python"
HOMEPAGE="https://github.com/casualsnek/onthespot"
SRC_URI="https://github.com/casualsnek/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="dev-python/pymysql[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/certifi
	dev-python/charset-normalizer
	dev-python/defusedxml
	dev-python/idna
	dev-python/ifaddr
	dev-python/librespot
	dev-python/music-tag
	dev-python/mutagen
	dev-python/packaging
	dev-python/pillow
	dev-python/protobuf
	dev-python/pycryptodomex
	dev-python/PyOgg
	dev-python/pyqt5
	dev-python/pyqt5-sip
	dev-python/pyxdg
	dev-python/requests
	dev-python/show-in-file-manager
	dev-python/urllib3
	dev-python/websocket-client
	dev-python/zeroconf
	dev-python/setuptools[${PYTHON_USEDEP}]
	media-video/ffmpeg
"
