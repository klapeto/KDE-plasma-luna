
import org.kde.ksvg 1.0 as KSvg

KSvg.FrameSvgItem {
    id: baseFrame

    property double targetScale: 1.0;
    property string image
    property double borderSize: 3.0
    property double marginTop: 0
    property double marginBottom: 0
    property bool isHovered: false
    property string basePrefix: "Normal"

    anchors {
        fill: parent
    }

    KSvg.FrameSvgItem {
        id: frmTopLeft

        anchors {
            top: parent.top
            left: parent.left
            topMargin: marginTop
        }

        width: Math.round(borderSize * baseFrame.targetScale)
        height: Math.round(borderSize * baseFrame.targetScale)

        imagePath: image
        prefix: baseFrame.basePrefix + "TopLeft"
    }
        KSvg.FrameSvgItem {
            id: frmTopRight
            anchors {
                top: parent.top
                right: parent.right
                topMargin: marginTop
            }

            width: Math.round(borderSize * baseFrame.targetScale)
            height: Math.round(borderSize * baseFrame.targetScale)

            imagePath: image
            prefix: baseFrame.basePrefix + "TopRight"
        }

        KSvg.FrameSvgItem {
            id: frmBottomLeft
            anchors {
                bottom: parent.bottom
                left: parent.left
                bottomMargin: marginBottom
            }

            width: Math.round(borderSize * baseFrame.targetScale)
            height: Math.round(borderSize * baseFrame.targetScale)

            imagePath: image
            prefix: baseFrame.basePrefix + "BottomLeft"
        }

        KSvg.FrameSvgItem {
            id: frmBottomRight
            anchors {
                bottom: parent.bottom
                right: parent.right
                bottomMargin: marginBottom
            }

            width: Math.round(borderSize * baseFrame.targetScale)
            height: Math.round(borderSize * baseFrame.targetScale)

            imagePath: image
            prefix: baseFrame.basePrefix + "BottomRight"
        }

        KSvg.FrameSvgItem {
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


        KSvg.FrameSvgItem {
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

        KSvg.FrameSvgItem {
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

        KSvg.FrameSvgItem {
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

        KSvg.FrameSvgItem {
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
}
