/*
    Copyright (C) 2011  Martin Gräßlin <mgraesslin@kde.org>
    Copyright (C) 2012  Gregor Taetzner <gregor@freenet.de>
    Copyright (C) 2012  Marco Martin <mart@kde.org>
    Copyright (C) 2013 2014 David Edmundson <davidedmundson@kde.org>
    Copyright 2014 Sebastian Kügler <sebas@kde.org>
    Copyright (C) 2021 by Mikel Johnson <mikel5764@gmail.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/
import QtQuick 2.12
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents // for TabGroup
import org.kde.plasma.components 3.0 as PC3
import org.kde.plasma.extras 2.0 as PlasmaExtras

import org.kde.plasma.private.kicker 0.1 as Kicker

PlasmaComponents.Page {
    id: root
    Layout.minimumWidth: Math.round(380 * PlasmaCore.Units.devicePixelRatio)
    Layout.maximumWidth: Layout.minimumWidth

    Layout.minimumHeight: Math.round(478 * PlasmaCore.Units.devicePixelRatio)//PlasmaCore.Units.gridUnit * 40
    Layout.maximumHeight: Layout.minimumHeight

    property QtObject systemFavorites: rootModel.systemFavoritesModel
    property QtObject globalFavorites: rootModel.favoritesModel

    onFocusChanged: {
        input.forceActiveFocus();
    }

    onSystemFavoritesChanged: {
        systemFavorites.favorites = String(plasmoid.configuration.systemFavorites).split(',');
    }

    function switchToInitial() {
        root.state = "Normal";
        tabBar.currentIndex = 0;
        header.query = ""
        keyboardNavigation.state = "LeftColumn"
        navigationMethod.state = "mouse"
    }

    Kicker.DragHelper {
        id: dragHelper

        dragIconSize: PlasmaCore.Units.iconSizes.medium
        onDropped: kickoff.dragSource = null
    }

    Kicker.RootModel {
        id: rootModel

        autoPopulate: false

        appletInterface: plasmoid

        flat: false
        sorted: plasmoid.configuration.alphaSort
        showSeparators: false
        showTopLevelItems: true

        showAllApps: true
        showAllAppsCategorized: false
        showRecentApps: false
        showRecentDocs: false
        showRecentContacts: false
        showPowerSession: false
        showFavoritesPlaceholder: true

        Component.onCompleted: {
            favoritesModel.initForClient("org.kde.plasma.kickoff.favorites.instance-" + plasmoid.id)

            if (!plasmoid.configuration.favoritesPortedToKAstats) {
                favoritesModel.portOldFavorites(plasmoid.configuration.favorites);
                plasmoid.configuration.favoritesPortedToKAstats = true;
            }

            rootModel.refresh();
            console.log("===========================" + favoritesModel.sourceModel.rowCount())

            for (let i = favoritesModel.sourceModel.rowCount(); i > 6; --i){
                console.log("REMOVING " + favoritesModel.sourceModel.remove(1))
                //favoritesModel.sourceModel.removeRow(i);
            }
        }
    }

    Connections {
        target: plasmoid.configuration

        function onFavoritesChanged() {
            globalFavorites.favorites = plasmoid.configuration.favorites;
        }

        function onSystemFavoritesChanged() {
            systemFavorites.favorites = String(plasmoid.configuration.systemFavorites).split(',');
        }
    }

    Connections {
        target: globalFavorites

        function onFavoritesChanged() {
            plasmoid.configuration.favorites = target.favorites;
        }
    }

    Header {
        id: header
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: Math.round(66 * PlasmaCore.Units.devicePixelRatio)
        Component.onCompleted: {
            header.input.forceActiveFocus();
        }
    }

    Rectangle {
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: footer.top
        }
        color: "#1854c2"

        MainArea {
            anchors {
                fill: parent
                margins: PlasmaCore.Units.devicePixelRatio
            }
        }
    }

    Footer {
        id: footer
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: Math.round(40 * PlasmaCore.Units.devicePixelRatio)
    }

        // we make our model ourselves
    ListModel {
        id: placesViewModel
        signal trigger(int index)

        function getI18nName(index) {
            switch(index) {
                case 0: return i18n("Computer");
                case 1: return i18n("History");
                case 2: return i18n("Frequently Used");
                default: return ""
            }
        }

        ListElement { filename: "ComputerView.qml"; decoration: "computer-laptop"; managesChildrenOutside: true }
        ListElement { filename: "RecentlyUsedView.qml"; decoration: "view-history"; managesChildrenOutside: true }
        ListElement { filename: "FrequentlyUsedView.qml"; decoration: "clock"; managesChildrenOutside: true }
    }

    Item {
        id: keyboardNavigation
        state: "LeftColumn"
        states: [
            State {
                name: "LeftColumn"
            },
            State {
                name: "RightColumn"
            }
        ]
        onStateChanged: {
            if (state == "LeftColumn") {
                root.currentView.forceActiveFocus()
            } else if (root.state != "search") {
                root.currentContentView.forceActiveFocus()
            }
        }
    }

    Item {
        id: navigationMethod
        property bool inSearch: root.state == "Search"
        state: "mouse"
        states: [
            State {
                name: "mouse"
            },
            State {
                name: "keyboard"
            }
        ]
    }
}
