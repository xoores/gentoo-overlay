# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils flag-o-matic meson

# Unfortunately cargo.eclass does not really work because it does not allow
# downloading https://github.com/rust-lang/crates.io-index so it always
# fails on "Spurious network error"... Tried for an hour to get around this
# but fuck this eclass - let's disable network-sandbox instead.

DESCRIPTION="Helvum is a GTK-based patchbay for pipewire, inspired by the JACK tool catia."
HOMEPAGE="https://gitlab.freedesktop.org/ryuukyu/helvum"
SRC_URI="https://gitlab.freedesktop.org/ryuukyu/helvum/-/archive/${PV}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"


RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"


DEPEND="
	virtual/rust
	>=sys-devel/clang-3.7
	>=media-video/pipewire-0.3.0
	>=gui-libs/gtk-4.4.0:4
	dev-util/meson
	"
RDEPEND="${DEPEND}"



pkg_setup() {
	# Sorry... I really tried but could not get cargo.eclass working
	# properly, so disabling netowrk-sandbox it is...
	if has network-sandbox ${FEATURES}; then
		eerror
		eerror "Helvum downloads some Meson dependencies during build process and this will not"
		eerror "be possible when network-sandbox feautre of Portage is enabled."
		eerror
		eerror "You can use package.env to disable this feature for this specific package using"
		eerror "following commands:"
		eerror
		eerror "  echo 'FEATURES=\"-network-sandbox\"' > /etc/portage/env/no-network-sandbox.conf"
		eerror "  echo 'media-sound/helvum no-network-sandbox.conf' > /etc/portage/package.env/helvum"
		eerror
		eerror "See also:"
		eerror
		eerror "    https://wiki.gentoo.org/wiki//etc/portage/package.env"
		eerror
		die "network-sandbox is enabled";
	fi
}


src_configure() {
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
