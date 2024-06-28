# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils unpacker

DESCRIPTION="Microsoft SQL Server Tools for Linux"
HOMEPAGE="https://docs.microsoft.com/en-us/sql/tools/overview-sql-tools?view=sql-server-ver15"
SRC_URI="https://packages.microsoft.com/debian/12/prod/pool/main/m/${PN}${PV%%.*}/${PN}${PV%%.*}_${PV}-1_amd64.deb"

LICENSE="BSD Microsoft-TOOLS"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

RDEPEND="
	dev-db/unixODBC
	dev-db/msodbcsql:18
"

S="${WORKDIR}"

QA_PREBUILT="
	usr/bin/sqlbcp
	usr/bin/sqlcmd
"

src_install() {
	# bcp is unfortunately a boost binary, so let's rename MSSQL bcp to
	# something that will work...
	mv "opt/mssql-tools${PV%%.*}/bin/bcp" "opt/mssql-tools${PV%%.*}/bin/sqlbcp"
	
	dobin "opt/mssql-tools${PV%%.*}/bin/sql"{cmd,bcp}

	insinto /usr/share/resources/en_US
	doins "opt/mssql-tools${PV%%.*}/share/resources/en_US/BatchParserGrammar."{dfa,llr} \
		"opt/mssql-tools${PV%%.*}/share/resources/en_US/bcp.rll" \
		"opt/mssql-tools${PV%%.*}/share/resources/en_US/SQLCMD.rll"

	pax-mark m "${ED}"/usr/bin/{bcp,sqlcmd}
}


pkg_postinst() {
	elog "${PN} package contains 'bcp' binary, but this name unfortunately collides"
	elog "with another binary from dev-libs/boost... To resolve this issue I just renamed"
	elog "binary from this package to sqlbcp"
}
