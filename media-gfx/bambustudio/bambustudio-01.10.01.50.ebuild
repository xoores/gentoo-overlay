# Maintainer: Xoores <gentoo@xoores.cz>

EAPI=8

inherit autotools

DESCRIPTION="PC Software for BambuLab and other 3D printers"
HOMEPAGE="https://github.com/bambulab/BambuStudio"
SRC_URI="https://github.com/bambulab/BambuStudio/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="amd64 ~x86 ~arm"

IUSE=""

# Do not try to get this from mirrors...
RESTRICT="mirror"

DEPEND="
	sys-devel/clang
	sys-devel/gcc
	sys-devel/m4
	dev-build/cmake
	dev-build/autoconf
	dev-build/automake
	media-gfx/openvdb
	dev-vcs/git
	sci-libs/nlopt
	dev-libs/cereal
	dev-libs/wayland
	dev-libs/boost
	dev-libs/wayland-protocols
	x11-libs/libxkbcommon
	x11-libs/cairo
	media-libs/mesa
	media-libs/opencv
	media-libs/gstreamer
	media-libs/mesa
	media-libs/x264
	media-libs/qhull
	media-plugins/gst-plugins-meta
	media-video/ffmpeg
	net-libs/libsoup
	net-libs/webkit-gtk
	virtual/pkgconfig
	virtual/libc
	virtual/glu
	dev-cpp/gtkmm:3
	dev-lang/nasm
	dev-lang/yasm"

RDEPEND="${DEPEND}"

S="${WORKDIR}/BambuStudio-${PV}"

src_prepare() {
	default
	
	ewarn "This ebuild is such a pain in the *fucking* ass... I've already seen an OOM killer, many cmake errors etc..."
	ewarn ""
	eqarn "This means this ebuild is *not ready* for use - sorry"
	die "Not ready yet, sorry friend..."
	
	sed -i -e 's|bambustudio_copy_sos|#bambustudio_copy_sos|g' \
		"${S}/src/CMakeLists.txt" || die "Fixing bambucopy"
		
	sed -i -e 's|INTERFACE Qhull::qhullcpp|INTERFACE -lqhullcpp|g' \
		"${S}/src/qhull/CMakeLists.txt" || die "Fixing qhull CMakeLists.txt"
		
}

src_compile() {
	BAMBU_DEPS_DIR="${S}/BambuStudio_dep"
	mkdir "${BAMBU_DEPS_DIR}"
	
	einfo "Building BambuStudio dependencies"
	cd deps
	
		#~ -DFLATPAK=1 \
		
	cmake ../ \
		-DDESTDIR="${BAMBU_DEPS_DIR}" \
		-DOPENVDB_FIND_MODULE_PATH="/usr/lib64/cmake/OpenVDB/" \
		-DwxWidgets_CONFIG_EXECUTABLE="/usr/bin/wx-config" \
		-DwxWidgets_USE_STATIC=0 \
		-DCMAKE_PREFIX_PATH="/usr" \
		-DSLIC3R_GTK=3 \
		-DCMAKE_BUILD_TYPE=Release \
		-DDEP_WX_GTK3=1 || die "Failed to configure BambuStudio dependencies"
		
	make -j || die "Failed to build BambuStudio dependencies"
		
	
	cd ..
	einfo "Building BambuStudio"
	mkdir build
	cd build
	cmake .. \
		-DSLIC3R_STATIC=ON \
		-DSLIC3R_GTK=3 \
		-DBBL_RELEASE_TO_PUBLIC=1 \
		-DCMAKE_PREFIX_PATH="${BAMBU_DEPS_DIR}/usr/local" \
		-DCMAKE_INSTALL_PREFIX="${D}" \
		-DCMAKE_BUILD_TYPE=Release || die "Failed to configure BambuStudio"
		
	cmake --build . \
		--target install \
		--config Release \
		-j || die "Failed to build BambuStudio"
}

src_install() {
	cd build
	cmake --build . --target install --config Release
}
