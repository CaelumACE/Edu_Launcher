import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


CoursewareForm{
     id: course
    default property alias content:stack.children

    property int current: 0

    onCurrentChanged:setVisible()
    Component.onCompleted: setVisible()

    function setVisible()
    {
        for (var i=0;i<stack.children.length;++i)
        {
            //stack.children[i].opacity=(i==current ? 1:0);
           stack.children[i].visible=(i==current ? 1:0)

        }


    }

    Row
    {
        id:header
        Repeater
        {
            model:stack.children.length
            delegate:Rectangle
            {

                width:course.width/stack.children.length;height:36

                Rectangle
                {
                    width: parent.width;height: 1
                    anchors{bottom: parent.bottom;bottomMargin: 1 }
                }


//                BorderImage {
//                    anchors { fill: parent; leftMargin: 2; topMargin: 5; rightMargin: 1 }
//                    border { left: 7; right: 7 }
//                    source: "tab.png"
//                    visible: course.current == index
//                }
                Text {

                    horizontalAlignment: Qt.AlignHCenter; verticalAlignment: Qt.AlignVCenter
                    anchors.fill: parent
                    text: stack.children[index].title

                    elide: Text.ElideRight
                    font.bold: course.current == index
                    font.pointSize:course.current==index ? 16:13


                }
                MouseArea {
                    id:mousearea
                    anchors.fill: parent
                    onClicked: course.current = index

                }






            }
        }

    }


    Item {
        id: stack
        width: course.width
        anchors.top:header.bottom; anchors.bottom:course.bottom
         }
















    }








