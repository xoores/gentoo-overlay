# Ebuild for YT-DLP
#
# Description: yt-dlp is a youtube-dl fork based on the now inactive youtube-dlc.
#			   The main focus of this project is adding new features and patches
#			   while also keeping up to date with the original project
#
# Maintainer: Xoores <gentoo@xoores.cz>

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit bash-completion-r1 distutils-r1 readme.gentoo-r1


DESCRIPTION="youtube-dl fork based on the now inactive youtube-dlc"
HOMEPAGE="https://github.com/yt-dlp/yt-dlp"
SRC_URI="https://github.com/yt-dlp/yt-dlp/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"

KEYWORDS="amd64 arm ~arm64 ~hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
SLOT="0"
IUSE="test bash-completion fish-completion zsh-completion +ffmpeg +rtmp +rtsp +embed-thumbnails python_targets_python3_8 python_targets_python3_9 python_targets_python3_10"

RDEPEND="
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	!net-misc/youtube-dl
	app-text/pandoc
	ffmpeg? ( media-video/ffmpeg )
	rtmp? ( media-video/rtmpdump )
	rtsp? (
		|| (
			media-video/mplayer
			media-video/mpv
			)
		)
	embed-thumbnails? ( media-video/atomicparsley )
"

# Do not try to get this from mirrors...
RESTRICT="mirror"

python_test()
{
	emake offlinetest
}

python_install_all()
{
	# Manpage building is PITA for this. To generate that you need pandoc, which
	# in turn needs over 130 Haskell packages :-( If you also wonder, how
	# youtube-dl does this without Pandoc dependency, it is by downloading an
	# archive that contains BOTH compiled parts & sources. This means either
	# downloading second file and extracting just the manpage or going all in
	# and do it right... I might create -bin version for yt-dlp in the future
	emake yt-dlp.1 || die "Failed: make doc"
	doman yt-dlp.1

	if use bash-completion; then
		emake completion-bash || die "Failed: make completion-bash"
		newbashcomp completions/bash/yt-dlp yt_dlp
	fi

	if use zsh-completion; then
		emake completion-zsh || die "Failed: make completion-zsh"
		insinto /usr/share/zsh/site-functions
		newins completions/zsh/_yt-dlp _yt_dlp
	fi

	if use fish-completion; then
		emake completion-fish || die "Failed: make completion-fish"
		insinto /usr/share/fish/vendor_completions.d
		doins completions/fish/yt-dlp.fish
	fi


	distutils-r1_python_install_all

	# Shhh! Dirty fix for dirty install script...
	rm -r "${ED}"/usr/share/doc/yt_dlp || die

	# Since I'm lazy & wanna have a drop-in replacement
	dosym /usr/bin/yt-dlp /usr/bin/youtube-dl
}


pkg_postinst() {
	if ! use ffmpeg; then
		ewarn "USE ffmpeg was disabled. ${PN} will not be able to convert audio or"
		ewarn "video. If you just want to download files as-is, it should work just fine."
	fi

	if ! use rtmp; then
		ewarn "USE rtmp was disabled, so videos streamed using RTMP will not be possible"
		ewarn "to download using ${PN}"
	fi

	if ! use rtsp; then
		ewarn "USE rtsp was disabled. You will not be able to download videos that utilize"
		ewarn "RTSP or MMS"
	fi

	if ! use embed-thumbnails; then
		ewarn "USE embed-thumbnails was disabled. This means that ${PV} will not be able"
		ewarn "to embed thumbnails into MP4/M4A files"
	fi
}
