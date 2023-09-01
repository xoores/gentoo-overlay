# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Rewrite of Sakakis buildkernel for creating secureboot EFI kernel with LUKS and LVM"
HOMEPAGE="https://gitlab.com/Xoores/buildkernel-next"

EGIT_REPO_URI="https://gitlab.com/Xoores/${PN}.git"
EGIT_BRANCH="dev"

RESTRICT="mirror"
LICENSE="Unlicense"
SLOT="0"


DEPEND="
	sys-kernel/dracut
	sys-boot/efibootmgr
	app-crypt/sbsigntools
	app-arch/cpio
	sys-apps/util-linux"
RDEPEND="${DEPEND}"


src_install()
{
	exeinto "/usr/bin"
	dobin "${PN}"
}
