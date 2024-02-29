/*
    SPDX-FileCopyrightText: 2012 Martin Gräßlin <mgraesslin@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/
import QtQuick 2.0
import org.kde.kwin.decoration
import org.kde.plasma.core as PlasmaCore
import org.kde.ksvg 1.0 as KSvg
import org.kde.kirigami as Kirigami

import Qt5Compat.GraphicalEffects
//import QtGraphicalEffects 1.15

Decoration {
    id: root
    property bool animate: false
    property int titleBarCornerWidth: calculateSize(29)
    Component.onCompleted: {
        borders.left   = Qt.binding(function() { return Math.max(0, auroraeTheme.borderLeft);});
        borders.right  = Qt.binding(function() { return Math.max(0, auroraeTheme.borderRight);});
        borders.top    = Qt.binding(function() { return Math.max(0, auroraeTheme.borderTop);});
        borders.bottom = Qt.binding(function() { return Math.max(0, auroraeTheme.borderBottom);});
        maximizedBorders.left   = Qt.binding(function() { return Math.max(0, auroraeTheme.borderLeftMaximized);});
        maximizedBorders.right  = Qt.binding(function() { return Math.max(0, auroraeTheme.borderRightMaximized);});
        maximizedBorders.bottom = Qt.binding(function() { return Math.max(0, auroraeTheme.borderBottomMaximized);});
        maximizedBorders.top    = Qt.binding(function() { return Math.max(0, auroraeTheme.borderTopMaximized);});
        padding.left   = auroraeTheme.paddingLeft;
        padding.right  = auroraeTheme.paddingRight;
        padding.bottom = auroraeTheme.paddingBottom;
        padding.top    = auroraeTheme.paddingTop;
        root.animate = true;
    }
    function calculateSize(pixels) {
        return Math.round((Kirigami.Units.gridUnit / 16.0) * pixels);
    }
    function calculateSizeFloor(pixels) {
        return Math.floor((Kirigami.Units.gridUnit / 16.0) * pixels);
    }
    DecorationOptions {
        id: options
        deco: decoration
    }
    Item {
        id: titleRect
        x: decoration.client.maximized ? maximizedBorders.left : borders.left
        y: decoration.client.maximized ? 0 : root.borders.bottom
        width: decoration.client.width//parent.width - x - (decoration.client.maximized ? maximizedBorders.right : borders.right)
        height: decoration.client.maximized ? maximizedBorders.top : borders.top
        Component.onCompleted: {
            decoration.installTitleItem(titleRect);
        }
    }
    KSvg.FrameSvg {
        property bool supportsInactive: true //hasElementPrefix("decoration-inactive")
        property bool supportsMaximized: true //hasElementPrefix("decoration-maximized")
        property bool supportsMaximizedInactive: true //hasElementPrefix("decoration-maximized-inactive")
        property bool supportsInnerBorder: hasElementPrefix("innerborder")
        property bool supportsInnerBorderInactive: hasElementPrefix("innerborder-inactive")
        id: backgroundSvg
        imagePath: auroraeTheme.decorationPath
    }

    
    
    //==============================
    // Active
    //==============================

    Item {
        id: titleBarPlaceholder

        anchors {
           top: root.top
           left: root.left
           right: root.right
        }
        height: titleBarCornerWidth
    }
    
    Item {
        id: decorationActiveContainer
        property bool shown: (!decoration.client.maximized || !backgroundSvg.supportsMaximized) && (decoration.client.active || !backgroundSvg.supportsInactive)
        anchors.fill: parent
        opacity: shown ? 1 : 0
        
        KSvg.FrameSvgItem {
            id: decorationActiveBarLeft
    
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
        
            width: titleBarCornerWidth
            height: titleBarCornerWidth
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBarLeft"
        }
        
        KSvg.FrameSvgItem {
            id: decorationActiveBarRight
        
            anchors {
                right: parent.right
                top: parent.top
                bottom: decorationActiveBarTop.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
        
            width: titleBarCornerWidth
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBarRight"
        }
        
        KSvg.FrameSvgItem {
            id: decorationActiveBarTop
        
            anchors {
                left: decorationActiveBarLeft.right
                right: decorationActiveBarRight.left
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBarCenter"
        }
        
        KSvg.FrameSvgItem {
            id: decorationActiveBorderLeft
        
            
            anchors {
                left: parent.left
                top: decorationActiveBarLeft.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.left
            height: parent.height - borders.top - borders.bottom
            
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderLeft"
        }
        
        KSvg.FrameSvgItem {
            id: decorationActiveBorderRight
            
            anchors {
                right: parent.right
                top: decorationActiveBarLeft.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.right
            height: parent.height - borders.top - borders.bottom
            
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderRight"
        }
        
        KSvg.FrameSvgItem {
            id: decorationActiveBorderBottomRight
            
            anchors {
                right: parent.right
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.right
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderBottomRight"
        }
        
        KSvg.FrameSvgItem {
            id: decorationActiveBorderBottomLeft
            
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.left
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderBottomLeft"
        }
        
        KSvg.FrameSvgItem {
            id: decorationActiveBorderBottom
            
            anchors {
                left: decorationActiveBorderBottomLeft.right
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: parent.width - borders.right - borders.left
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderBottom"

        }
        
        KSvg.FrameSvgItem {
            id: decorationActiveCenter
        
            anchors {
                left: decorationActiveBorderLeft.right
                right: decorationActiveBorderRight.left
                top: decorationActiveBarTop.bottom
                bottom: decorationActiveBorderBottom.Top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveWindow"
        }
        
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
        
    }

    
    
    //==============================
    // Inactive
    //==============================
    
    Item {
        id: decorationInactiveContainer
        anchors.fill: parent
        opacity: (!decoration.client.active && backgroundSvg.supportsInactive) ? 1 : 0
        
        KSvg.FrameSvgItem {
            id: decorationInactiveBarLeft
            
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: titleBarCornerWidth
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBarLeft"
        }
        
        KSvg.FrameSvgItem {
            id: decorationInactiveBarRight
            anchors {
                right: parent.right
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: titleBarCornerWidth
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBarRight"
        }
        
        KSvg.FrameSvgItem {
            id: decorationInactiveBarTop
            
            anchors {
                left: decorationInactiveBarLeft.right
                right: decorationInactiveBarRight.left
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBarCenter"
        }
        
        KSvg.FrameSvgItem {
            id: decorationInactiveBorderLeft
            
            anchors {
                left: parent.left
                top: decorationInactiveBarLeft.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.left
            height: parent.height - borders.top - borders.bottom
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderLeft"
        }
        
        KSvg.FrameSvgItem {
            id: decorationInactiveBorderRight

            anchors {
                right: parent.right
                top: decorationInactiveBarLeft.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.right
            height: parent.height - borders.top - borders.bottom
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderRight"
        }
        
        
        KSvg.FrameSvgItem {
            id: decorationInactiveBorderBottomRight
            
            anchors {
                right: parent.right
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.right
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderBottomRight"
        }
        
        KSvg.FrameSvgItem {
            id: decorationInactiveBorderBottomLeft
            
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.left
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderBottomLeft"
        }
        
        KSvg.FrameSvgItem {
            id: decorationInactiveBorderBottom
            
            anchors {
                left: decorationInactiveBorderBottomLeft.right
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: parent.width - borders.right - borders.left
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderBottom"
        }
        
        KSvg.FrameSvgItem {
            id: decorationInactiveCenter
            
            anchors {
                left: decorationInactiveBorderLeft.right
                right: decorationInactiveBorderRight.left
                top: decorationInactiveBarTop.bottom
                bottom: decorationInactiveBorderBottom.Top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
        
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveWindow"
        }
        
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    

    
    //==============================
    // Maximized Active
    //==============================
    
    KSvg.FrameSvgItem {
        id: decorationActiveMaximizedBarLeft
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: titleBarCornerWidth
        
        imagePath: backgroundSvg.imagePath
        prefix: "ActiveMaximizedBarLeft"
        height: parent.maximizedBorders.top
        opacity: shown ? 1 : 0
        enabledBorders: KSvg.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    
    KSvg.FrameSvgItem {
        id: decorationActiveMaximizedBarRight
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            right: parent.right
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: titleBarCornerWidth
        
        imagePath: backgroundSvg.imagePath
        prefix: "ActiveMaximizedBarRight"
        height: parent.maximizedBorders.top
        opacity: shown ? 1 : 0
        enabledBorders: KSvg.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }

    
    KSvg.FrameSvgItem {
        id: decorationActiveMaximizedBarTop
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            left: decorationActiveMaximizedBarLeft.right
            right: decorationActiveMaximizedBarRight.left
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: titleBarCornerWidth
        
        imagePath: backgroundSvg.imagePath
        prefix: "ActiveMaximizedBarCenter"
        height: parent.maximizedBorders.top
        opacity: shown ? 1 : 0
        enabledBorders: KSvg.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    
    
    //==============================
    // Maximized Inactive
    //==============================

    
    KSvg.FrameSvgItem {
        id: decorationInactiveMaximizedBarLeft
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: titleBarCornerWidth
        
        imagePath: backgroundSvg.imagePath
        prefix: "InactiveMaximizedBarLeft"
        height: parent.maximizedBorders.top
        opacity: (!decoration.client.active && decoration.client.maximized && backgroundSvg.supportsMaximizedInactive) ? 1 : 0
        enabledBorders: KSvg.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    
    KSvg.FrameSvgItem {
        id: decorationInactiveMaximizedBarRight
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            right: parent.right
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: titleBarCornerWidth
        
        imagePath: backgroundSvg.imagePath
        prefix: "InactiveMaximizedBarRight"
        height: parent.maximizedBorders.top
        opacity: (!decoration.client.active && decoration.client.maximized && backgroundSvg.supportsMaximizedInactive) ? 1 : 0
        enabledBorders: KSvg.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }

    
    KSvg.FrameSvgItem {
        id: decorationInactiveMaximizedBarTop
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            left: decorationInactiveMaximizedBarLeft.right
            right: decorationInactiveMaximizedBarRight.left
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: titleBarCornerWidth
        
        imagePath: backgroundSvg.imagePath
        prefix: "InactiveMaximizedBarCenter"
        height: parent.maximizedBorders.top
        opacity: (!decoration.client.active && decoration.client.maximized && backgroundSvg.supportsMaximizedInactive) ? 1 : 0
        enabledBorders: KSvg.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    
    AuroraeButtonGroup {
        id: leftButtonGroup
        buttons: options.titleButtonsLeft
        animate: root.animate
        anchors {
            left: root.left
            top: root.top
            bottom: titleBarPlaceholder.bottom
            topMargin: decoration.client.maximized ? calculateSize(6) : calculateSize(8)
            leftMargin: decoration.client.maximized ? calculateSize(2) : calculateSize(6)
            bottomMargin: decoration.client.maximized ? calculateSize(8) : calculateSize(6)
        }
    }
    AuroraeButtonGroup {
        id: rightButtonGroup
        buttons: options.titleButtonsRight
        animate: root.animate

        anchors {
            right: root.right
            top: root.top
            bottom: titleBarPlaceholder.bottom
            rightMargin: decoration.client.maximized ? calculateSize(2) : calculateSize(6)
            topMargin: decoration.client.maximized ? calculateSize(4) : calculateSize(5)
            bottomMargin: decoration.client.maximized ? calculateSize(4) : calculateSize(3)
        }
    }
    Text {
        id: caption
        text: getCleanText(decoration.client.caption)
        textFormat: Text.StyledText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignBottom
        elide: Text.ElideRight
        color: decoration.client.active ? auroraeTheme.activeTextColor : auroraeTheme.inactiveTextColor
        font.family: "Trebuchet MS"
        font.pointSize: 10.2 //+ ((1 - 1.0) / 10.0) //magic calculation to make size consistent across scallings
        font.weight: Font.Bold
        renderType: Text.NativeRendering
        //style: decoration.client.active ? Text.Raised : Text.Normal;
        font.hintingPreference: Font.PreferFullHinting
        //Rectangle {anchors.fill:parent}
        lineHeight: 1.0
        anchors {
            left: leftButtonGroup.right
            right: rightButtonGroup.left
            //verticalCenter: titleBarPlaceholder.verticalCenter
            bottom: leftButtonGroup.bottom
            bottomMargin: calculateSize(-2.0)
            //bottomMargin: calculateSize(5)
            //top: leftButtonGroup.top
            top: leftButtonGroup.top
            leftMargin: calculateSize(4)
            rightMargin: auroraeTheme.titleBorderRight
        }
        Behavior on color {
            enabled: root.animate
            ColorAnimation {
                duration: auroraeTheme.animationTime
            }
        }
        
        function getCleanText(text){
         return text.replace(/([\u2700-\u27BF]|[\uE000-\uF8FF]|\uD83C[\uDC00-\uDFFF]|\uD83D[\uDC00-\uDFFF]|[\u2011-\u26FF]|\uD83E[\uDD10-\uDDFF])/g, '');  // Remove emojis to avoid crash
        }
    }

    DropShadow {
        anchors.fill: caption
        horizontalOffset: 1
        verticalOffset: 1
        radius: 1
        //samples: 17
        color: "#ff0a1883"
        visible: decoration.client.active
        source: caption
    }


    KSvg.FrameSvgItem {
        id: innerBorder
        anchors {
            fill: parent
            leftMargin: parent.padding.left + parent.borders.left - margins.left
            rightMargin: parent.padding.right + parent.borders.right - margins.right
            topMargin: parent.padding.top + parent.borders.top - margins.top
            bottomMargin: parent.padding.bottom + parent.borders.bottom - margins.bottom
        }
        visible: parent.borders.left > fixedMargins.left
            && parent.borders.right > fixedMargins.right
            && parent.borders.top > fixedMargins.top
            && parent.borders.bottom > fixedMargins.bottom

        imagePath: backgroundSvg.imagePath
        prefix: "innerborder"
        opacity: (decoration.client.active && !decoration.client.maximized && backgroundSvg.supportsInnerBorder) ? 1 : 0
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    KSvg.FrameSvgItem {
        id: innerBorderInactive
        anchors {
            fill: parent
            leftMargin: parent.padding.left + parent.borders.left - margins.left
            rightMargin: parent.padding.right + parent.borders.right - margins.right
            topMargin: parent.padding.top + parent.borders.top - margins.top
            bottomMargin: parent.padding.bottom + parent.borders.bottom - margins.bottom
        }

        visible: parent.borders.left > fixedMargins.left
            && parent.borders.right > fixedMargins.right
            && parent.borders.top > fixedMargins.top
            && parent.borders.bottom > fixedMargins.bottom

        imagePath: backgroundSvg.imagePath
        prefix: "innerborder-inactive"
        opacity: (!decoration.client.active && !decoration.client.maximized && backgroundSvg.supportsInnerBorderInactive) ? 1 : 0
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
}
