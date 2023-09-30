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
// While using Kirigami in applets is normally a no, we
// use Avatar, which doesn't need to read the colour scheme
// at all to function, so there won't be any oddities with colours.
import org.kde.kirigami 2.13 as Kirigami
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
 Item {
    FrameSvgAdv {
        id: header

        borderSize: 7.0
        image: "widgets/plasmoidheading"
        basePrefix: "header"
        property Item avatar: avatarButton

        KCoreAddons.KUser {
            id: kuser
        }

        MouseArea {
            id: avatarButton

            anchors {
                top: parent.top
                //bottom: parent.bottom
                left: parent.left
                leftMargin: Math.round(7 * PlasmaCore.Units.devicePixelRatio)
                topMargin: Math.round(7 * PlasmaCore.Units.devicePixelRatio)
                //bottomMargin: Math.round(7 * PlasmaCore.Units.devicePixelRatio)
            }

            cursorShape: Qt.PointingHandCursor

            height: width
            width: Math.round(52 * PlasmaCore.Units.devicePixelRatio)

            visible: KQuickAddons.KCMShell.authorize("kcm_users.desktop").length > 0

            Accessible.name: nameLabel.text
            Accessible.description: i18n("Go to user settings")

            Rectangle {
                id: imageWrapper

                anchors.fill: parent

                color: "#ccd6eb"

                radius: Math.round(4 * PlasmaCore.Units.devicePixelRatio)

                Image {
                    source: kuser.faceIconUrl
                    //name: nameLabel.text
                    anchors {
                        fill: parent
                        margins: Math.round(2 * PlasmaCore.Units.devicePixelRatio)
                    }
                        // NOTE: for some reason Avatar eats touch events even though it shouldn't
                        // Ideally we'd be using Avatar but it doesn't have proper key nav yet
                        // see https://invent.kde.org/frameworks/kirigami/-/merge_requests/218
                    // actions.main: Kirigami.Action {
                    //     text: avatarButton.Accessible.description
                    //     onTriggered: avatarButton.clicked()
                    // }
                        // no keyboard nav
                    // activeFocusOnTab: false
                        // ignore accessibility (done by the button)
                    Accessible.ignored: true
                }
            }

            Text {
                id: userNameText
                anchors {
                    left: imageWrapper.right
                    leftMargin: Math.round(9 * PlasmaCore.Units.devicePixelRatio)
                    verticalCenter: imageWrapper.verticalCenter
                }
                text: kuser.fullName
                font.family: "Franklin Gothic Medium"
                font.pointSize: 14
                font.weight: Font.Medium
                color: "white"
            }

            DropShadow {
                anchors.fill: imageWrapper
                horizontalOffset: 2
                verticalOffset: 2
                radius: 5.0 * PlasmaCore.Units.devicePixelRatio
                samples: 17
                color: "#0c4c9e"
                source: imageWrapper
            }

            DropShadow {
                anchors.fill: userNameText
                horizontalOffset: 2
                verticalOffset: 2
                radius: 4.5 * PlasmaCore.Units.devicePixelRatio
                samples: 17
                color: "#0b4690"
                source: userNameText
            }

            onClicked: {
                KQuickAddons.KCMShell.openSystemSettings("kcm_users")
            }

            Keys.onPressed: {
                    // In search on backtab focus on search pane
                if (event.key == Qt.Key_Backtab && (root.state == "Search" || mainTabGroup.state == "top")) {
                    navigationMethod.state = "keyboard"
                    keyboardNavigation.state = "RightColumn"
                    root.currentContentView.forceActiveFocus()
                    event.accepted = true;
                    return;
                }
            }
        }

        // Item {
        //     PlasmaExtras.Heading {
        //         id: nameLabel
        //         anchors.fill: parent

        //         level: 2
        //         text: kuser.fullName
        //         elide: Text.ElideRight
        //         horizontalAlignment: Text.AlignLeft
        //         verticalAlignment: Text.AlignVCenter

        //         Behavior on opacity {
        //             NumberAnimation {
        //                 duration: PlasmaCore.Units.longDuration
        //                 easing.type: Easing.InOutQuad
        //             }
        //         }

        //         // Show the info instead of the user's name when hovering over it
        //         MouseArea {
        //             anchors.fill: nameLabel
        //             hoverEnabled: true
        //             onEntered: {
        //                 header.state = "info"
        //             }
        //             onExited: {
        //                 header.state = "name"
        //             }
        //         }
        //     }

        //     PlasmaExtras.Heading {
        //         id: infoLabel
        //         anchors.fill: parent
        //         level: 5
        //         opacity: 0
        //         text: kuser.os !== "" ? i18n("%2@%3 (%1)", kuser.os, kuser.loginName, kuser.host) : i18n("%1@%2", kuser.loginName, kuser.host)
        //         elide: Text.ElideRight
        //         horizontalAlignment: Text.AlignLeft
        //         verticalAlignment: Text.AlignVCenter

        //         Behavior on opacity {
        //             NumberAnimation {
        //                 duration: PlasmaCore.Units.longDuration
        //                 easing.type: Easing.InOutQuad
        //             }
        //         }
        //     }
        // }
    }
 }