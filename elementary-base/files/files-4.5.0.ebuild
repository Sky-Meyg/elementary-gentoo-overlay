# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="A simple, powerful, sexy file manager for the Pantheon desktop"
HOMEPAGE="https://github.com/elementary/files"
SRC_URI="https://github.com/elementary/files/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="nls zeitgeist"

BDEPEND="
	$(vala_depend)
	>=dev-util/meson-0.50.0
	virtual/pkgconfig
"
DEPEND="
	nls? ( sys-devel/gettext )
"
RDEPEND="${DEPEND}
	dev-db/sqlite:3
	dev-libs/dbus-glib
	>=dev-libs/glib-2.40.0:2
	>=dev-libs/granite-5.3.0
	dev-libs/libgee
	dev-libs/libgit2-glib
	dev-libs/libcloudproviders[vala]
	gnome-base/gvfs
	zeitgeist? ( gnome-extra/zeitgeist )
	media-libs/libcanberra
	>=x11-libs/gtk+-3.22:3
	x11-libs/libnotify
	x11-libs/pango
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dwith-unity=disabled
		$(meson_use zeitgeist)
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}