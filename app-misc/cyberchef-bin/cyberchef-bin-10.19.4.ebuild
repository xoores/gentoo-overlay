# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

DESCRIPTION="The Cyber Swiss Army Knife in your browser"
HOMEPAGE="https://github.com/gchq/CyberChef"
SRC_URI="https://github.com/gchq/CyberChef/releases/download/v${PV}/CyberChef_v${PV}.zip -> ${P}.zip"

LICENSE="Apache-2.0"
KEYWORDS="*"
RESTRICT="mirror"

S="${WORKDIR}"

# Don't think Gentoo has virtual metapackage for WWW server :-(
RDEPEND="
	|| (
		www-servers/apache
		www-servers/nginx
		www-servers/cherokee
		www-servers/gatling
	)
"

src_install() {
	webapp_src_preinst
	mv CyberChef_v${PV}.html index.html
	rm -f *.LICENSE.txt

	insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	doins -r .

	webapp_src_install
}
