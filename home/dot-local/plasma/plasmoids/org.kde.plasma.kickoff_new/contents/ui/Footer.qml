/*
 *    Copyright 2014  Sebastian Kügler <sebas@kde.org>
 *    SPDX-FileCopyrightText: (C) 2020 Carl Schwan <carl@carlschwan.eu>
 *    Copyright (C) 2021 by Mikel Johnson <mikel5764@gmail.com>
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License along
 *    with this program; if not, write to the Free Software Foundation, Inc.,
 *    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kcoreaddons 1.0 as KCoreAddons
import org.kde.plasma.private.kicker 0.1 as Kicker
import org.kde.kirigami 2.13 as Kirigami
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

Item {
    FrameSvgAdv {
        id: footer

        borderSize: 7.0
        image: "widgets/plasmoidheading"
        basePrefix: "footer"

        Kicker.SystemModel {
            id: systemModel
            favoritesModel: globalFavorites
        }

        FooterButton {
            id: powerButton
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                topMargin: Math.round(4 * PlasmaCore.Units.devicePixelRatio)
                bottomMargin: Math.round(5 * PlasmaCore.Units.devicePixelRatio)
            }
            iconSource: "system-shutdown"
            text: "Σβήσιμο"

            onClicked: systemModel.trigger(1, "", "")
        }

        FooterButton {
            anchors {
                right: powerButton.left
                top: parent.top
                bottom: parent.bottom
                topMargin: Math.round(4 * PlasmaCore.Units.devicePixelRatio)
                bottomMargin: Math.round(5 * PlasmaCore.Units.devicePixelRatio)
            }
            iconSource: "system-log-out"
            text: "Αποσύνδεση χρήστη"

            onClicked: systemModel.trigger(0, "", "")
        }
    }
}