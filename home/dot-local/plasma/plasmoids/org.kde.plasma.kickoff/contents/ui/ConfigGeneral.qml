/*
 *  Copyright 2013 David Edmundson <davidedmundson@kde.org>
 *  Copyright (C) 2021 by Mikel Johnson <mikel5764@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.15
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import org.kde.kirigami 2.5 as Kirigami

ColumnLayout {

    property string cfg_icon: plasmoid.configuration.icon
    property alias cfg_switchTabsOnHover: switchTabsOnHoverCheckbox.checked
    property int cfg_favoritesDisplay: plasmoid.configuration.favoritesDisplay
    property alias cfg_gridAllowTwoLines: gridAllowTwoLines.checked
    property alias cfg_startText: startText.text 
    property alias cfg_alphaSort: alphaSort.checked
    property var cfg_systemFavorites: String(plasmoid.configuration.systemFavorites)
    property int cfg_primaryActions: plasmoid.configuration.primaryActions

    Kirigami.FormLayout {
        Item {
            Kirigami.FormData.isSection: true
        }

        CheckBox {
            id: switchTabsOnHoverCheckbox
            Kirigami.FormData.label: i18n("General:")
            text: i18n("Switch tabs on hover")
        }

        CheckBox {
            id: alphaSort
            text: i18n("Always sort applications alphabetically")
        }

        Button {
            icon.name: "settings-configure"
            text: i18n("Configure enabled search plugins")
            onPressed: KQuickAddons.KCMShell.openSystemSettings("kcm_plasmasearch")
        }

        Item {
            Kirigami.FormData.isSection: true
        }


        TextField {
            id: startText
            Kirigami.FormData.label: i18n("Start button text:")
            text: plasmoid.configuration.startText
        }

        RadioButton {
            id: showFavoritesInGrid
            Kirigami.FormData.label: i18n("Show favorites:")
            text: i18n("In a grid")
            ButtonGroup.group: displayGroup
            property int index: 0
            checked: plasmoid.configuration.favoritesDisplay == index
        }

        RadioButton {
            id: showFavoritesInList
            text: i18n("In a list")
            ButtonGroup.group: displayGroup
            property int index: 1
            checked: plasmoid.configuration.favoritesDisplay == index
        }

        CheckBox {
            id: gridAllowTwoLines
            text: i18n("Allow label to have two lines")
            enabled: showFavoritesInGrid.checked
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        RadioButton {
            id: powerActionsButton
            Kirigami.FormData.label: i18n("Primary actions:")
            text: i18n("Power actions")
            ButtonGroup.group: radioGroup
            property string actions: "suspend,hibernate,reboot,shutdown"
            property int index: 0
            checked: plasmoid.configuration.primaryActions == index
        }

        RadioButton {
            id: sessionActionsButton
            text: i18n("Session actions")
            ButtonGroup.group: radioGroup
            property string actions: "lock-screen,logout,save-session,switch-user"
            property int index: 1
            checked: plasmoid.configuration.primaryActions == index
        }
    }

    ButtonGroup {
        id: displayGroup
        onCheckedButtonChanged: {
            if (checkedButton) {
                cfg_favoritesDisplay = checkedButton.index
            }
        }
    }

    ButtonGroup {
        id: radioGroup
        onCheckedButtonChanged: {
            if (checkedButton) {
                cfg_primaryActions = checkedButton.index
                cfg_systemFavorites = checkedButton.actions
            }
        }
    }

    Item {
        Layout.fillHeight: true
    }
}
