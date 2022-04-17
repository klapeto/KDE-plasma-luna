import QtQuick 2.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaCore.FrameSvgItem {
        id: baseFrame
        
        property double targetScale: PlasmaCore.Units.devicePixelRatio;
        
        property double topMargin: 0.0
        property double bottomMargin: 0.0
        
        property double borderSizeTop: 3.0
        property double borderSizeBottom: 3.0
        
        property string image

        anchors {
            fill: parent

            topMargin: topMargin * targetScale
            bottomMargin: bottomMargin * targetScale
            leftMargin: 0
            rightMargin: 0
        }
            
        PlasmaCore.FrameSvgItem {
            id: frmTopLeft
            anchors {
                top: parent.top
                left: parent.left
            }
            
            width: Math.round(borderSizeTop * baseFrame.targetScale)
            height: Math.round(borderSizeTop * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "TopLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmTopRight
            anchors {
                top: parent.top
                right: parent.right
            }
            
            width: Math.round(borderSizeTop * baseFrame.targetScale)
            height: Math.round(borderSizeTop * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "TopRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmBottomLeft
            anchors {
                bottom: parent.bottom
                left: parent.left
            }
            
            width: Math.round(borderSizeBottom * baseFrame.targetScale)
            height: Math.round(borderSizeBottom * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "BottomLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmBottomRight
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            
            width: Math.round(borderSizeBottom * baseFrame.targetScale)
            height: Math.round(borderSizeBottom * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "BottomRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmTop
            anchors {
                top: frmTopLeft.top
                left: frmTopLeft.right
                right: frmTopRight.left
                bottom: frmTopLeft.bottom
            }
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Top"
        }
        
        
        PlasmaCore.FrameSvgItem {
            id: frmLeft
            anchors {
                top: frmTopLeft.bottom
                left: frmTopLeft.left
                right: frmTopLeft.right
                bottom: frmBottomLeft.top
            }
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Left"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmRight
            anchors {
                top: frmTopRight.bottom
                right: frmTopRight.right
                left: frmTopRight.left
                bottom: frmBottomRight.top
            }
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Right"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmBottom
            anchors {
                bottom: frmBottomLeft.bottom
                left: frmBottomLeft.right
                right: frmBottomRight.left
                top: frmBottomLeft.top
            }
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Bottom"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmCenter
            anchors {
                top: frmTopLeft.bottom
                left: frmTopLeft.right
                right: frmBottomRight.left
                bottom: frmBottomRight.top
            }
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Center"
        }
        
        property bool isHovered: false
        property string basePrefix: "Normal"
        
}
