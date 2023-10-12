# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs

DESCRIPTION="A customizable and extensible shell"
HOMEPAGE="https://github.com/Aylur/ags"

SRC_URI="https://github.com/Aylur/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"


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
	
	# This patch moves the libdir from global /usr/lib64 to the application
	# directory as it compiles libgnome-volume-control as libgvc.so which
	# in turn conflicts with Graphviz... This may be an ugly hack, but it
	# is the easiest fix at the moment.
	sed -i -e '15i libdir = pkgdatadir' \
		-e '15i extensiondir = join_paths(libdir, meson.project_name())' \
		-e 's|^libdir|#libdir|g' \
		-e 's|^extensiondir|#extensiondir|g' \
		meson.build
}

src_install() {
	meson_src_install
	
	# Copy packaged NodeJS modules to the app dir
	insinto "/usr/share/com.github.Aylur.ags/"
	doins -r "node_modules"
}
