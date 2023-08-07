/*
    SPDX-FileCopyrightText: 2014 Aleix Pol Gonzalez <aleixpol@blue-systems.com>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick 2.2
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.12 as QQC2
import QtGraphicalEffects 1.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.kcoreaddons 1.0 as KCoreAddons

import "../components"
import "timer.js" as AutoTriggerTimer

import org.kde.plasma.private.sessions 2.0

PlasmaCore.ColorScope {
    id: root
    colorGroup: PlasmaCore.Theme.ComplementaryColorGroup
    height: screenGeometry.height
    width: screenGeometry.width

    signal logoutRequested()
    signal haltRequested()
    signal suspendRequested(int spdMethod)
    signal rebootRequested()
    signal rebootRequested2(int opt)
    signal cancelRequested()
    signal lockScreenRequested()

    function sleepRequested() {
        root.suspendRequested(2);
    }

    function hibernateRequested() {
        root.suspendRequested(4);
    }

    property var currentAction: {
        switch (sdtype) {
            case ShutdownType.ShutdownTypeReboot:
                return root.rebootRequested;
            case ShutdownType.ShutdownTypeHalt:
                return root.haltRequested;
            default:
                return root.logoutRequested;
        }
    }

    KCoreAddons.KUser {
        id: kuser
    }

    // For showing a "other users are logged in" hint
    SessionsModel {
        id: sessionsModel
        includeUnusedSessions: false
    }

    QQC2.Action {
        onTriggered: root.cancelRequested()
        shortcut: "Escape"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.cancelRequested()
    }

    Rectangle {
        anchors {
            top: parent.top
            topMargin: parent.height / 4.0
            horizontalCenter: parent.horizontalCenter
        }
        height: 200
        width: 314

        color: "black"

        Image {
            id: header
            source: "top.svg"
            anchors {
                topMargin: 1
                leftMargin: 1
                rightMargin: 1
                top: parent.top
                left: parent.left
                right: parent.right
            }
            height: 45

            Text {
                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin: 12
                    topMargin: 8
                }
                font.family: "Tahoma"
                font.pointSize: 14
                color: "white"
                text: "Σβήσιμο του υπολογιστή"
            }
            Image {
                anchors {
                    verticalCenter: parent.verticalCenter
                    rightMargin: 7
                    right: parent.right
                }
                height: 37
                width: 37
                source: "default-logo.svg"
            }
        }
        Image {
            id: center
            source: "center.svg"
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                leftMargin: 1
                rightMargin: 1
            }
            height: 110

            RowLayout {
                anchors{
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: 8
                Layout.alignment: Qt.AlignHCenter
                LogoutButton {
                    id: suspendButton
                    iconSource: "system-suspend"
                    text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "Suspend to RAM", "Sleep")
                    action: root.sleepRequested
                    KeyNavigation.left: logoutButton
                    KeyNavigation.right: hibernateButton
                    visible: spdMethods.SuspendState
                }
                LogoutButton {
                    id: hibernateButton
                    iconSource: "system-suspend-hibernate"
                    text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Hibernate")
                    action: root.hibernateRequested
                    KeyNavigation.left: suspendButton
                    KeyNavigation.right: rebootButton
                    visible: spdMethods.HibernateState
                }
                LogoutButton {
                    id: shutdownButton
                    iconSource: "system-shutdown"
                    text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Shut Down")
                    action: root.haltRequested
                    KeyNavigation.left: rebootButton
                    KeyNavigation.right: logoutButton
                    focus: sdtype === ShutdownType.ShutdownTypeHalt
                    visible: maysd
                }
                LogoutButton {
                    id: rebootButton
                    iconSource: "system-reboot"
                    text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Restart")
                    action: root.rebootRequested
                    KeyNavigation.left: hibernateButton
                    KeyNavigation.right: shutdownButton
                    focus: sdtype === ShutdownType.ShutdownTypeReboot
                    visible: maysd
                }
                LogoutButton {
                    id: logoutButton
                    iconSource: "system-log-out"
                    text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Log Out")
                    action: root.logoutRequested
                    KeyNavigation.left: shutdownButton
                    KeyNavigation.right: suspendButton
                    focus: sdtype === ShutdownType.ShutdownTypeNone
                    visible: canLogout
                }
            }

        }
        Image {
            id: footer
            source: "bottom.svg"
            anchors {
                top: center.bottom
                left: parent.left
                right: parent.right
                leftMargin: 1
                rightMargin: 1
                bottomMargin: 1
            }
            height: 43
            QQC2.Button {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 11
                }
                implicitWidth: text.implicitWidth + 24
                height: 18
                //text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Cancel")
                onClicked: root.cancelRequested()

                Text {
                    id: text
                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    font.pointSize: 10
                    font.family: "Tahoma"
                    text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Cancel")
                }
            }
        }
    }
}
