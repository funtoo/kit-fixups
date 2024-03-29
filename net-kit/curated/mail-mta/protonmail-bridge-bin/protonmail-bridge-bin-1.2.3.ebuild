# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

DESCRIPTION="Serves ProtonMail to IMAP/SMTP clients"
HOMEPAGE="https://protonmail.com/bridge/"
SRC_URI="https://protonmail.com/download/${P/-bin/}-1.x86_64.rpm"

RESTRICT="bindist"

LICENSE="MIT protonmail-bridge-EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	app-crypt/libsecret
	dev-libs/glib:2
	media-sound/pulseaudio[glib]
	sys-apps/dbus
	virtual/opengl
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXext
	x11-libs/libXi
"
BDEPEND="dev-util/patchelf"

S="${WORKDIR}"

QA_PREBUILT="*"

src_prepare() {
	# Some bogus files got into package.
	rm -rf usr/lib/.build-id

	# Bug #660366. To workaround preserving libs, set RUNPATH and rm unused libs
	cd "${S}/usr/lib/protonmail/bridge" || die
	patchelf --set-rpath '$ORIGIN/lib' protonmail-bridge || die "patchelf failed"
	patchelf --set-rpath '$ORIGIN' lib/libicui18n.so.56 || die "patchelf failed"
	patchelf --set-rpath '$ORIGIN' lib/libicuuc.so.56 || die "patchelf failed"

	rm "lib/libQt53DCore.so.5" || die
	rm "lib/libQt53DExtras.so.5" || die
	rm "lib/libQt53DInput.so.5" || die
	rm "lib/libQt53DLogic.so.5" || die
	rm "lib/libQt53DQuick.so.5" || die
	rm "lib/libQt53DQuickExtras.so.5" || die
	rm "lib/libQt53DQuickInput.so.5" || die
	rm "lib/libQt53DQuickRender.so.5" || die
	rm "lib/libQt53DRender.so.5" || die
	rm "lib/libQt5Concurrent.so.5" || die
	rm "lib/libQt5Gamepad.so.5" || die
	rm "lib/libQt5QuickParticles.so.5" || die
	rm "plugins/audio/libqtaudio_alsa.so" || die
	rm "plugins/audio/libqtmedia_pulse.so" || die
	rm "plugins/bearer/libqconnmanbearer.so" || die
	rm "plugins/bearer/libqgenericbearer.so" || die
	rm "plugins/bearer/libqnmbearer.so" || die
	rm "plugins/canbus/libqtpeakcanbus.so" || die
	rm "plugins/canbus/libqtsocketcanbus.so" || die
	rm "plugins/canbus/libqttinycanbus.so" || die
	rm "plugins/designer/libqquickwidget.so" || die
	rm "plugins/designer/libqwebengineview.so" || die
	rm "plugins/egldeviceintegrations/libqeglfs-emu-integration.so" || die
	rm "plugins/egldeviceintegrations/libqeglfs-x11-integration.so" || die
	rm "plugins/gamepads/libevdevgamepad.so" || die
	rm "plugins/generic/libqevdevkeyboardplugin.so" || die
	rm "plugins/generic/libqevdevmouseplugin.so" || die
	rm "plugins/generic/libqevdevtabletplugin.so" || die
	rm "plugins/generic/libqevdevtouchplugin.so" || die
	rm "plugins/generic/libqtuiotouchplugin.so" || die
	rm "plugins/geometryloaders/libdefaultgeometryloader.so" || die
	rm "plugins/geometryloaders/libgltfgeometryloader.so" || die
	rm "plugins/geoservices/libqtgeoservices_esri.so" || die
	rm "plugins/geoservices/libqtgeoservices_itemsoverlay.so" || die
	rm "plugins/geoservices/libqtgeoservices_mapbox.so" || die
	rm "plugins/geoservices/libqtgeoservices_mapboxgl.so" || die
	rm "plugins/geoservices/libqtgeoservices_nokia.so" || die
	rm "plugins/geoservices/libqtgeoservices_osm.so" || die
	rm "plugins/iconengines/libqsvgicon.so" || die
	rm "plugins/mediaservice/libgstaudiodecoder.so" || die
	rm "plugins/mediaservice/libgstcamerabin.so" || die
	rm "plugins/mediaservice/libgstmediacapture.so" || die
	rm "plugins/mediaservice/libgstmediaplayer.so" || die
	rm "plugins/platforminputcontexts/libibusplatforminputcontextplugin.so" || die
	rm "plugins/platforminputcontexts/libqtvirtualkeyboardplugin.so" || die
	rm "plugins/platforms/libqeglfs.so" || die
	rm "plugins/platforms/libqlinuxfb.so" || die
	rm "plugins/platforms/libqminimal.so" || die
	rm "plugins/platforms/libqminimalegl.so" || die
	rm "plugins/platforms/libqoffscreen.so" || die
	rm "plugins/platforms/libqvnc.so" || die
	rm "plugins/platformthemes/libqgtk3.so" || die
	rm "plugins/playlistformats/libqtmultimedia_m3u.so" || die
	rm "plugins/position/libqtposition_geoclue.so" || die
	rm "plugins/position/libqtposition_positionpoll.so" || die
	rm "plugins/printsupport/libcupsprintersupport.so" || die
	rm "plugins/qmltooling/libqmldbg_inspector.so" || die
	rm "plugins/qmltooling/libqmldbg_local.so" || die
	rm "plugins/qmltooling/libqmldbg_messages.so" || die
	rm "plugins/qmltooling/libqmldbg_native.so" || die
	rm "plugins/qmltooling/libqmldbg_nativedebugger.so" || die
	rm "plugins/qmltooling/libqmldbg_profiler.so" || die
	rm "plugins/qmltooling/libqmldbg_quickprofiler.so" || die
	rm "plugins/qmltooling/libqmldbg_server.so" || die
	rm "plugins/qmltooling/libqmldbg_tcp.so" || die
	rm "plugins/renderplugins/libscene2d.so" || die
	rm "plugins/sceneparsers/libassimpsceneimport.so" || die
	rm "plugins/sceneparsers/libgltfsceneexport.so" || die
	rm "plugins/sceneparsers/libgltfsceneimport.so" || die
	rm "plugins/sensorgestures/libqtsensorgestures_plugin.so" || die
	rm "plugins/sensorgestures/libqtsensorgestures_shakeplugin.so" || die
	rm "plugins/sensors/libqtsensors_generic.so" || die
	rm "plugins/sensors/libqtsensors_iio-sensor-proxy.so" || die
	rm "plugins/sensors/libqtsensors_linuxsys.so" || die
	rm "plugins/sqldrivers/libqsqlite.so" || die
	rm "plugins/sqldrivers/libqsqlmysql.so" || die
	rm "plugins/sqldrivers/libqsqlpsql.so" || die
	rm "plugins/xcbglintegrations/libqxcb-egl-integration.so" || die
	rm "qml/Qt/labs/calendar/libqtlabscalendarplugin.so" || die
	rm "qml/Qt/labs/folderlistmodel/libqmlfolderlistmodelplugin.so" || die
	rm "qml/Qt/labs/platform/libqtlabsplatformplugin.so" || die
	rm "qml/Qt/labs/settings/libqmlsettingsplugin.so" || die
	rm "qml/Qt/labs/sharedimage/libsharedimageplugin.so" || die
	rm "qml/Qt3D/Animation/libquick3danimationplugin.so" || die
	rm "qml/Qt3D/Core/libquick3dcoreplugin.so" || die
	rm "qml/Qt3D/Extras/libquick3dextrasplugin.so" || die
	rm "qml/Qt3D/Input/libquick3dinputplugin.so" || die
	rm "qml/Qt3D/Logic/libquick3dlogicplugin.so" || die
	rm "qml/Qt3D/Render/libquick3drenderplugin.so" || die
	rm "qml/QtBluetooth/libdeclarative_bluetooth.so" || die
	rm "qml/QtCanvas3D/libqtcanvas3d.so" || die
	rm "qml/QtGamepad/libdeclarative_gamepad.so" || die
	rm "qml/QtLocation/libdeclarative_location.so" || die
	rm "qml/QtMultimedia/libdeclarative_multimedia.so" || die
	rm "qml/QtNfc/libdeclarative_nfc.so" || die
	rm "qml/QtPositioning/libdeclarative_positioning.so" || die
	rm "qml/QtQml/Models.2/libmodelsplugin.so" || die
	rm "qml/QtQml/StateMachine/libqtqmlstatemachine.so" || die
	rm "qml/QtQuick/Controls.2/Material/libqtquickcontrols2materialstyleplugin.so" || die
	rm "qml/QtQuick/Controls.2/Universal/libqtquickcontrols2universalstyleplugin.so" || die
	rm "qml/QtQuick/Controls/Styles/Flat/libqtquickextrasflatplugin.so" || die
	rm "qml/QtQuick/Controls/libqtquickcontrolsplugin.so" || die
	rm "qml/QtQuick/Dialogs/Private/libdialogsprivateplugin.so" || die
	rm "qml/QtQuick/Dialogs/libdialogplugin.so" || die
	rm "qml/QtQuick/Extras/libqtquickextrasplugin.so" || die
	rm "qml/QtQuick/LocalStorage/libqmllocalstorageplugin.so" || die
	rm "qml/QtQuick/Particles.2/libparticlesplugin.so" || die
	rm "qml/QtQuick/PrivateWidgets/libwidgetsplugin.so" || die
	rm "qml/QtQuick/Scene2D/libqtquickscene2dplugin.so" || die
	rm "qml/QtQuick/Scene3D/libqtquickscene3dplugin.so" || die
	rm "qml/QtQuick/XmlListModel/libqmlxmllistmodelplugin.so" || die
	rm "qml/QtScxml/libdeclarative_scxml.so" || die
	rm "qml/QtSensors/libdeclarative_sensors.so" || die
	rm "qml/QtTest/libqmltestplugin.so" || die
	rm "qml/QtWebChannel/libdeclarative_webchannel.so" || die
	rm "qml/QtWebEngine/libqtwebengineplugin.so" || die
	rm "qml/QtWebSockets/libdeclarative_qmlwebsockets.so" || die
	rm "qml/QtWebView/libdeclarative_webview.so" || die
	rm "lib/libQt5MultimediaGstTools.so.5" || die
	rm "lib/libQt5OpenGL.so.5" || die
	rm "lib/libQt5QuickWidgets.so.5" || die
	rm "lib/libQt5EglFsKmsSupport.so.5" || die
	rm "plugins/position/libqtposition_serialnmea.so" || die
	rm "plugins/webview/libqtwebview_webengine.so" || die
	rm "plugins/egldeviceintegrations/libqeglfs-kms-egldevice-integration.so" || die
	rm "plugins/texttospeech/libqtexttospeech_speechd.so" || die
	rm "plugins/canbus/libqtpassthrucanbus.so" || die
	rm "qml/QtQuick/Shapes/libqmlshapesplugin.so" || die
	rm "qml/QtQuick/Controls.2/Fusion/libqtquickcontrols2fusionstyleplugin.so" || die
	rm "qml/QtQuick/Controls.2/Imagine/libqtquickcontrols2imaginestyleplugin.so" || die
	rm "qml/QtQml/RemoteObjects/libqtqmlremoteobjects.so" || die
	rm "qml/Qt/labs/location/liblocationlabsplugin.so" || die

	default
}

src_install() {
	# Using doins -r would strip executable bits from all binaries
	cp -pPR usr "${D}"/ || die "Failed to copy files"

	dosym "protonmail-bridge" "/usr/bin/${PN}"

	insinto /etc/revdep-rebuild
	newins - "50-${PN}" <<-EOF
		SEARCH_DIRS_MASK="/usr/lib*/protonmail/bridge"
	EOF
}
