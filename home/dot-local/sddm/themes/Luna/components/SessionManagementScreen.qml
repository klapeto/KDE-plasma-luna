/*
    SPDX-FileCopyrightText: 2016 David Edmundson <davidedmundson@kde.org>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick 2.15

import QtQuick.Layouts 1.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

FocusScope {
    id: root

    /*
     * Any message to be displayed to the user, visible above the text fields
     */
    property alias notificationMessage: notificationsLabel.text

    /*
     * A list of Items (typically ActionButtons) to be shown in a Row beneath the prompts
     */
    property alias actionItems: actionItemsLayout.children

    /*
     * Whether to show or hide the list of action items as a whole.
     */
    property alias actionItemsVisible: actionItemsLayout.visible

    /*
     * A model with a list of users to show in the view.
     * There are different implementations in sddm greeter (UserModel) and
     * KScreenLocker (SessionsModel), so some roles will be missing.
     *
     * type: {
     *  name: string,
     *  realName: string,
     *  homeDir: string,
     *  icon: string,
     *  iconName?: string,
     *  needsPassword?: bool,
     *  displayNumber?: string,
     *  vtNumber?: int,
     *  session?: string
     *  isTty?: bool,
     * }
     */
    property alias userListModel: userListView.model

    /*
     * Self explanatory
     */
    property alias userListCurrentIndex: userListView.currentIndex
    property alias userListCurrentItem: userListView.currentItem
    property bool showUserList: true

    property alias userList: userListView

    property int fontSize: PlasmaCore.Theme.defaultFont.pointSize + 2

    default property alias _children: innerLayout.children

    signal loginRequest(string username, string password)

    ColumnLayout {
        Rectangle {
            Layout.fillHeight: true
        }

        UserList {
            id: userListView
            fontSize: root.fontSize

            // bubble up the signal
            onLoginRequest: root.loginRequest(username, password)
        }

        Rectangle {
            Layout.fillHeight: true
        }
    }
    // FIXME: move this component into a layout, rather than abusing
    // anchors and implicitly relying on other components' built-in
    // whitespace to avoid items being overlapped.


    //goal is to show the prompts, in ~16 grid units high, then the action buttons
    //but collapse the space between the prompts and actions if there's no room
    //ui is constrained to 16 grid units wide, or the screen
    ColumnLayout {
        id: prompts
        anchors.top: parent.verticalCenter
        anchors.topMargin: PlasmaCore.Units.gridUnit * 0.5
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        PlasmaComponents3.Label {
            id: notificationsLabel
            font.pointSize: root.fontSize
            Layout.maximumWidth: PlasmaCore.Units.gridUnit * 16
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            font.italic: true
        }
        ColumnLayout {
            Layout.minimumHeight: implicitHeight
            Layout.maximumHeight: PlasmaCore.Units.gridUnit * 10
            Layout.maximumWidth: PlasmaCore.Units.gridUnit * 16
            Layout.alignment: Qt.AlignHCenter
            ColumnLayout {
                id: innerLayout
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
            }
            Item {
                Layout.fillHeight: true
            }
        }
        Item {
            Layout.alignment: Qt.AlignHCenter
            implicitHeight: actionItemsLayout.implicitHeight
            implicitWidth: actionItemsLayout.implicitWidth
            Row { //deliberately not rowlayout as I'm not trying to resize child items
                id: actionItemsLayout
                anchors.verticalCenter: parent.top
                spacing: PlasmaCore.Units.largeSpacing / 2
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
