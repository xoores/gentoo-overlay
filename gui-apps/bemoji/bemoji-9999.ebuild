# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Emoji picker that remembers your favorites, with support for bemenu/wofi/rofi/dmenu and wayland/X11"
HOMEPAGE="https://github.com/marty-oehme"


EGIT_REPO_URI="https://github.com/marty-oehme/bemoji.git"
inherit git-r3

# Bemoji unfortunately does not seem to care about versions - or rather that the dev does not 
# bump the version number when pushing commits. So version is "stuck" at 0.4.0 which was released
# several years ago, but there are new commits since then. That's why I'm not masking this as 
# "normal" -9999 ebuild...
KEYWORDS="~amd64"

LICENSE="MIT"
SLOT="0"
RESTRICT="mirror"



DEPEND="
	|| (
		dev-libs/bemenu 
		gui-apps/wofi 
		x11-misc/rofi 
		x11-misc/dmenu 
		gui-apps/wmenu
		gui-apps/fuzzel
	)
	|| (
		gui-apps/wl-clipboard
		x11-misc/xclip
		x11-misc/xsel
	)
	|| (
		gui-apps/wtype
		x11-misc/xdotool
		x11-misc/ydotool
	)
"
BDEPEND="${DEPEND}"


src_install() {
	dobin bemoji
}
