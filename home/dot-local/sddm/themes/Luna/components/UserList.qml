/*
    SPDX-FileCopyrightText: 2014 David Edmundson <davidedmundson@kde.org>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick 2.15
import QtQuick.Window 2.15

import org.kde.plasma.core 2.0 as PlasmaCore

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

ListView {
    id: view
    readonly property string selectedUser: currentItem ? currentItem.userName : ""
    readonly property int userItemWidth: 352
    readonly property int userItemHeight: 70
    readonly property bool constrainText: count > 1
    property int fontSize: PlasmaCore.Theme.defaultFont.pointSize + 2

    implicitHeight: (userItemHeight + 20) * model.count
    spacing: 20

    activeFocusOnTab: true

    /*
     * Signals that a user was explicitly selected
     */
    signal loginRequest(string username, string password)

    delegate: UserDelegate {
        avatarPath: model.icon || ""
        iconSource: model.iconName || "user-identity"
        fontSize: view.fontSize
        needsPassword: model.needsPassword !== undefined ? model.needsPassword : true
        vtNumber: model.vtNumber

        name: {
            const displayName = model.realName || model.name

            if (model.vtNumber === undefined || model.vtNumber < 0) {
                return displayName
            }

            if (!model.session) {
                return i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "Nobody logged in on that session", "Unused")
            }


            let location = undefined
            if (model.isTty) {
                location = i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "User logged in on console number", "TTY %1", model.vtNumber)
            } else if (model.displayNumber) {
                location = i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "User logged in on console (X display number)", "on TTY %1 (Display %2)", model.vtNumber, model.displayNumber)
            }

            if (location !== undefined) {
                return i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "Username (location)", "%1 (%2)", displayName, location)
            }

            return displayName
        }

        userName: model.name

        width: userItemWidth
        height: userItemHeight

        //if we only have one delegate, we don't need to clip the text as it won't be overlapping with anything
        constrainText: view.constrainText

        isCurrent: ListView.isCurrentItem

        onLoginRequest: {
            ListView.view.loginRequest(username, password)
        }
        onClicked: {
            ListView.view.currentIndex = index;
        }
    }

    Keys.onEscapePressed: view.userSelected()
    Keys.onEnterPressed: view.userSelected()
    Keys.onReturnPressed: view.userSelected()
}

