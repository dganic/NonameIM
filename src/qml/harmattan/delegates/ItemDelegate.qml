// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../components"

Item {
    id: root
    property alias imageSize: avatar.width
    property alias imageSource: avatar.source
    property url imageUrl
    property Item item: null
    property bool clickable: true
    property bool horizontalLine: true
    property int __spacing: 6
    property int __minHeight: 100

    function getMinHeight() {
        var itemHeight = item ? item.y + item.height + __spacing : 0
        return Math.max(itemHeight, __minHeight)
    }
    function __checkItem() {
        if (item) {
            item.parent = root
            item.anchors.top = root.top
            item.anchors.topMargin = 12
            item.anchors.left = avatar.right
            item.anchors.leftMargin = 12
            item.anchors.right = arrow.left
        }
    }

    signal clicked

    //ListView.onRemove: SequentialAnimation {
    //    PropertyAction { target: root; property: "ListView.delayRemove"; value: true }
    //    NumberAnimation { target: root; property: "scale"; to: 0; duration: 300; easing.type: Easing.InOutQuad }
    //    PropertyAction { target: root; property: "ListView.delayRemove"; value: false }
    //}

    //ListView.onAdd: ParallelAnimation {
    //    NumberAnimation { target: root; property: "opacity"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutQuad }
    //    NumberAnimation { target: root; property: "scale"; from: 0; to: 1; duration: 1000; easing.type: Easing.InOutQuad }
    //}

    Component.onCompleted: __checkItem()
    onItemChanged: __checkItem()

    width: parent ? parent.width : 600
    height: getMinHeight()

    Avatar {
        id: avatar

        onClicked: {
            if (imageUrl)
                appWindow.showPhoto(imageUrl)
        }

        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.top: item ? item.top : parent.top
        anchors.topMargin: item ? __spacing/2 : 0
        width: 80
        height: 80
    }

    Arrow {
        id: arrow
        visible: clickable
        opacity: 0.5
        anchors.right: parent.right
        anchors.rightMargin: visible ? 12 : 0
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        enabled: clickable
        anchors.fill: parent
        onClicked: root.clicked();
    }

    Rectangle {
        id: hr

        visible: horizontalLine

        anchors {
            bottom: root.bottom
            left: parent.left
            right: parent.right
        }

        height: 1
        color: "#c0c0c0"
    }
}
