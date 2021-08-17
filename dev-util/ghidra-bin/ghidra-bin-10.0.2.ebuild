# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI=7

GHIDRA_DATESTAMP="20210804"
GHIDRA_DESTDIR="/opt/ghidra-${PV}"

inherit eutils

DESCRIPTION="A software reverse engineering (SRE) suite of tools developed by NSAat "
HOMEPAGE="https://ghidra-sre.org/"
SRC_URI="https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${PV}_build/ghidra_${PV}_PUBLIC_${GHIDRA_DATESTAMP}.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE=""

RESTRICT="mirror"

# Ghidra needs OpenJDK 11 64bit
DEPEND="
	dev-java/openjdk-bin:11
	dev-java/openjdk-jre-bin:11
	"
	
RDEPEND="${DEPEND}"

src_unpack()
{
	default
	
	# Need to "fix" the default unzip directory of Ghidra...
	mv "ghidra_${PV}_PUBLIC" "${P}"
}

src_install() {
	insinto "${GHIDRA_DESTDIR}"
	
	# Copy just about everything - we don't really care for .bat though
	doins -r Extensions GPL Ghidra docs licenses server support
	doins LICENSE ghidraRun
	
	# Need to set +x on some files...
	fperms 0755 \
		"${GHIDRA_DESTDIR}/ghidraRun" \
		"${GHIDRA_DESTDIR}/support/analyzeHeadless" \
		"${GHIDRA_DESTDIR}/support/launch.sh" \
		"${GHIDRA_DESTDIR}/support/pythonRun" \
		"${GHIDRA_DESTDIR}/support/sleigh" 
	
	# Also it would be nice to run ghidra like a sane person :-)
	dosym "${GHIDRA_DESTDIR}/ghidraRun" /usr/bin/ghidra
	
}

pkg_postinst() {
	default
	
	ewarn "Created symlink for binary ${GHIDRA_DESTDIR}/ghidraRun -> /usr/bin/ghidra"
	ewarn "To launch Ghidra, you can just launch /usr/bin/ghidra"
	ewarn ""
	ewarn "OpenJDK 11 (for some reason) does not yet have gentoo-vm flag enabled so"
	ewarn "you might want to expliciely tell Ghidra location of OpenJDK. You might"
	ewarn "do that by setting an alias by adding this to your .bashrc:"
	ewarn "  alias ghidra='JAVA_HOME_OVERRIDE=\"/opt/openjdk-jre-bin-11/\" ghidra'"
	ewarn ""
	ewarn "For HiDPI monitors you might have to edit /opt/ghidra-${PV}/support/launch.properties and"
	ewarn "change property sun.java2d.uiScale from 1 to the same value as GDK_SCALE. You can"
	ewarn "find out your current value by running 'echo \$GDK_SCALE' in any shell"
}
