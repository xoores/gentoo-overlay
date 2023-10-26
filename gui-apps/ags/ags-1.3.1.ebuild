# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs

DESCRIPTION="A customizable and extensible shell"
HOMEPAGE="https://github.com/Aylur/ags"

SRC_URI="
	https://github.com/kotontrion/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/kotontrion/${PN}/releases/download/v${PV}/node_modules-v${PV}.tar.gz -> ${P}-modules.tar.gz
	"
KEYWORDS="~amd64"
LICENSE="GPL-3.0"
SLOT="0"
RESTRICT="mirror"

DEPEND="
	dev-util/cmake
	dev-lang/typescript
	dev-util/meson
	dev-libs/gjs
	net-wireless/gnome-bluetooth
	gui-libs/gtk-layer-shell
	sys-power/upower
	net-misc/networkmanager
	dev-libs/gobject-introspection
	dev-libs/libdbusmenu[gtk3]
	media-sound/pulseaudio
	net-libs/nodejs
"
BDEPEND="${DEPEND}"


S="${WORKDIR}/ags"
BUILD_DIR="${S}/build"

src_prepare() {
	default
	mv ../node_modules .
}

src_configure() {
	meson_src_configure --libdir "lib/$PN"
}

src_install() {
	meson_src_install

	# Copy packaged NodeJS modules to the app dir
	insinto "/usr/share/com.github.Aylur.ags/"
	doins -r "node_modules"
}
