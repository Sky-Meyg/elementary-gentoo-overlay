# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_USE_DEPEND="vapigen"

inherit meson vala

DESCRIPTION="Allows sync clients provide access to cloud providers"
HOMEPAGE="https://gitlab.gnome.org/World/libcloudproviders"
SRC_URI="https://gitlab.gnome.org/World/libcloudproviders/-/archive/${PV}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="introspection vala"

BDEPEND="
	$(vala_depend)
"
RDEPEND="
	dev-libs/glib:2
"
DEPEND="${RDEPEND}"

src_prepare() {
    vala_src_prepare
	default
}
src_configure() {
    local emesonargs=(
        $(meson_use vala vapigen)
        $(meson_use introspection)
    )
    meson_src_configure
}