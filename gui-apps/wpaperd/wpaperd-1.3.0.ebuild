# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.25.1
	adler2@2.0.1
	ahash@0.8.12
	aho-corasick@1.1.4
	aligned-vec@0.6.4
	aligned@0.4.3
	android_system_properties@0.1.5
	anstream@1.0.0
	anstyle-parse@1.0.0
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.14
	anyhow@1.0.102
	arbitrary@1.4.2
	arg_enum_proc_macro@0.3.4
	arrayvec@0.7.6
	as-slice@0.2.1
	autocfg@1.5.1
	av-data@0.4.4
	av-scenechange@0.14.1
	av1-grain@0.2.5
	avif-serialize@0.8.9
	backtrace@0.3.76
	bit_field@0.10.3
	bitflags@1.3.2
	bitflags@2.11.1
	bitreader@0.3.11
	bitstream-io@4.10.0
	block2@0.6.2
	built@0.8.1
	bumpalo@3.20.3
	byte-slice-cast@1.2.3
	bytemuck@1.25.0
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.11.1
	calloop-wayland-source@0.4.1
	calloop@0.14.4
	cc@1.2.62
	cfg-expr@0.20.7
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	chrono@0.4.44
	clap@4.6.1
	clap_builder@4.6.0
	clap_complete@4.6.5
	clap_derive@4.6.1
	clap_lex@1.1.0
	clap_mangen@0.3.0
	color-eyre@0.6.5
	color_quant@1.1.0
	colorchoice@1.0.5
	concurrent-queue@2.5.0
	core-foundation-sys@0.8.7
	crc32fast@1.5.0
	crossbeam-channel@0.5.15
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	ctrlc@3.5.2
	cursor-icon@1.2.0
	dav1d-sys@0.8.3
	dav1d@0.11.1
	dirs-sys@0.5.0
	dirs@6.0.0
	dispatch2@0.3.1
	dlib@0.5.3
	downcast-rs@1.2.1
	either@1.16.0
	equator-macro@0.4.2
	equator@0.4.2
	equivalent@1.0.2
	errno@0.3.14
	exr@1.74.0
	eyre@0.6.12
	fallible_collections@0.4.9
	fastrand@2.4.1
	fax@0.2.7
	fdeflate@0.3.7
	file-id@0.1.0
	filetime@0.2.29
	find-msvc-tools@0.1.9
	flate2@1.1.9
	flexi_logger@0.31.9
	format-bytes-macros@0.4.0
	format-bytes@0.3.0
	fsevent-sys@4.1.0
	futures-core@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	getrandom@0.2.17
	getrandom@0.3.4
	gif@0.14.2
	gimli@0.32.3
	gl_generator@0.14.0
	half@2.7.1
	hashbrown@0.13.2
	hashbrown@0.17.1
	heck@0.5.0
	hermit-abi@0.5.2
	hotwatch@0.5.0
	humantime-serde@1.1.1
	humantime@2.3.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.65
	image-webp@0.2.4
	image@0.25.10
	imgref@1.12.1
	indenter@0.3.4
	indexmap@2.14.0
	inotify-sys@0.1.5
	inotify@0.9.6
	interpolate_name@0.2.4
	is_terminal_polyfill@1.70.2
	itertools@0.14.0
	itoa@1.0.18
	jobserver@0.1.34
	js-sys@0.3.99
	khronos-egl@6.0.0
	khronos_api@3.1.0
	kqueue-sys@1.1.2
	kqueue@1.1.1
	lebe@0.5.3
	libc@0.2.186
	libfuzzer-sys@0.4.12
	libloading@0.8.9
	libredox@0.1.17
	linux-raw-sys@0.12.1
	lock_api@0.4.14
	log@0.4.30
	loop9@0.1.5
	maybe-rayon@0.1.1
	memchr@2.8.1
	memmap2@0.9.10
	mime@0.3.17
	miniz_oxide@0.8.9
	mio@0.8.11
	moxcms@0.8.1
	mp4parse@0.17.0
	new_debug_unreachable@1.0.6
	new_mime_guess@4.0.4
	nix@0.31.3
	no_std_io2@0.9.4
	nom@8.0.0
	noop_proc_macro@0.3.0
	notify-debouncer-full@0.1.0
	notify@6.1.1
	nu-ansi-term@0.50.3
	num-bigint@0.4.6
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	objc2-encode@4.1.0
	objc2@0.6.4
	object@0.37.3
	once_cell@1.21.4
	once_cell_polyfill@1.70.2
	option-ext@0.2.0
	owo-colors@4.3.0
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	paste@1.0.15
	pastey@0.1.1
	pin-project-lite@0.2.17
	pkg-config@0.3.33
	png@0.18.1
	polling@3.11.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.106
	profiling-procmacros@1.0.18
	profiling@1.0.18
	pxfm@0.1.29
	qoi@0.4.1
	quick-error@2.0.1
	quick-xml@0.39.4
	quote@1.0.45
	r-efi@5.3.0
	rand@0.9.4
	rand_chacha@0.9.0
	rand_core@0.9.5
	rav1e@0.8.1
	ravif@0.13.0
	rayon-core@1.13.0
	rayon@1.12.0
	redox_syscall@0.5.18
	redox_users@0.5.2
	regex-automata@0.4.14
	regex-syntax@0.8.10
	regex@1.12.3
	rgb@0.8.53
	roff@1.1.1
	rustc-demangle@0.1.27
	rustix@1.1.4
	rustversion@1.0.22
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.2.0
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.150
	serde_spanned@1.1.1
	shlex@1.3.0
	simd-adler32@0.3.9
	simd_helpers@0.1.0
	slab@0.4.12
	smallvec@1.15.1
	smithay-client-toolkit@0.20.0
	stable_deref_trait@1.2.1
	static_assertions@1.1.0
	strsim@0.11.1
	syn@1.0.109
	syn@2.0.117
	system-deps@7.0.8
	target-lexicon@0.13.3
	terminal_size@0.4.4
	thiserror-impl@2.0.18
	thiserror@2.0.18
	tiff@0.11.3
	tikv-jemalloc-sys@0.7.1+5.3.1-0-g81034ce1f1373e37dc865038e1bc8eeecf559ce8
	tikv-jemallocator@0.7.0
	toml@1.1.2+spec-1.1.0
	toml_datetime@1.1.1+spec-1.1.0
	toml_parser@1.1.2+spec-1.1.0
	toml_writer@1.1.1+spec-1.1.0
	tracing-core@0.1.36
	tracing@0.1.44
	unicase@2.9.0
	unicode-ident@1.0.24
	utf8parse@0.2.2
	v_frame@0.3.9
	version-compare@0.2.1
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.3+wasi-0.2.9
	wasm-bindgen-macro-support@0.2.122
	wasm-bindgen-macro@0.2.122
	wasm-bindgen-shared@0.2.122
	wasm-bindgen@0.2.122
	wayland-backend@0.3.15
	wayland-client@0.31.14
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.14
	wayland-egl@0.32.11
	wayland-protocols-experimental@20250721.0.1
	wayland-protocols-misc@0.3.12
	wayland-protocols-wlr@0.3.12
	wayland-protocols@0.32.12
	wayland-scanner@0.31.10
	wayland-sys@0.31.11
	weezl@0.1.12
	winapi-util@0.1.11
	windows-core@0.62.2
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.2.1
	windows-result@0.4.1
	windows-strings@0.5.1
	windows-sys@0.48.0
	windows-sys@0.61.2
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	winnow@1.0.3
	wit-bindgen@0.57.1
	xcursor@0.3.10
	xdg@3.0.0
	xkeysym@0.2.1
	xml-rs@0.8.28
	y4m@0.8.0
	zerocopy-derive@0.8.49
	zerocopy@0.8.49
	zmij@1.0.21
	zune-core@0.5.1
	zune-inflate@0.2.54
	zune-jpeg@0.5.15
"
RUST_MIN_VER="1.88.0"

inherit bash-completion-r1 cargo systemd

DESCRIPTION="Modern wallpaper daemon for Wayland (includes the wpaperctl CLI)"
HOMEPAGE="https://github.com/danyspin97/wpaperd"
SRC_URI="
	https://github.com/danyspin97/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="avif +jemalloc"

RDEPEND="
	dev-libs/wayland
	media-libs/libglvnd
	avif? ( media-libs/dav1d:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-text/scdoc
	virtual/pkgconfig
"

src_compile() {
	local daemonfeatures=(
		--no-default-features
		$(usev avif --features=avif)
		$(usev jemalloc --features=jemalloc)
	)

	cargo_src_compile -p wpaperd "${daemonfeatures[@]}"
	cargo_src_compile -p wpaperctl
}

src_install() {
	local tdir=$(cargo_target_dir)

	dobin "${tdir}"/wpaperd
	dobin "${tdir}"/wpaperctl

	doman "${tdir}"/man/wpaperd.1
	doman "${tdir}"/man/wpaperctl.1

	scdoc < man/wpaperd-output.5.scd > wpaperd-output.5 || die
	doman wpaperd-output.5

	newbashcomp "${tdir}"/completions/wpaperd.bash wpaperd
	newbashcomp "${tdir}"/completions/wpaperctl.bash wpaperctl

	insinto /usr/share/zsh/site-functions
	doins "${tdir}"/completions/_wpaperd
	doins "${tdir}"/completions/_wpaperctl

	insinto /usr/share/fish/vendor_completions.d
	doins "${tdir}"/completions/wpaperd.fish
	doins "${tdir}"/completions/wpaperctl.fish

	systemd_douserunit contrib/wpaperd.service

	einstalldocs
}

pkg_postinst() {
	elog "wpaperd needs a per-output configuration file before it does anything:"
	elog "  ~/.config/wpaperd/config.toml"
	elog "See wpaperd-output(5) and https://github.com/danyspin97/wpaperd"
	elog
	elog "A systemd user unit was installed, enable it with:"
	elog "  systemctl --user enable --now wpaperd.service"
}
