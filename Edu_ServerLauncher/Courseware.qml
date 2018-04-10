import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


CoursewareForm
{
   anchors.fill: parent

    property int courseLengthData:courseNameData.length
    property var courseNameData:["光学1","光学2","光学3","光学4","光学5","力学1","力学2","力学3","力学4","力学5","电学1","电学2"]
    property var imagePathData:"qrc:/image/diban.png"
    Component.onCompleted:initial()

    function initial()
    {
        initialCourse();

    }

    function clearModelList()
    {
       courseListmodel.clear();

    }


    function initialCourse()
    {
        for(var i=0;i<courseLengthData;i++)
        {


           courseListmodel.append({courseName:courseNameData[i],imagePath:imagePathData});

        }

    }


//    GridView.onAdd: SequentialAnimation {
//                     NumberAnimation {
//                         target:courseDelegate;
//                         property: "scale";
//                         from: 0;//开始值
//                         to: 1;
//                         duration: 250;
//                         easing.type: Easing.InOutQuad;
//                     }
//                }





    //课程目录排版
    GridView
    {
        id:couresGridView
       // anchors.fill: parent
        delegate:courseDelegate
        model:courseListmodel
        cellHeight: 240
        cellWidth: 320
        clip: true
        width: parent.width-100
        height: parent.height
        x:parent.x+277.8
        y:parent.y+113.95


        add: Transition
        {


          NumberAnimation
          {
              property: "opacity";
              from:0;to:1.0;duration: 400;

          }
          NumberAnimation
          {
              property: "scale";
              from:0;to:1.0;duration: 400;

          }


           NumberAnimation
            {
                  property:"rotation"
                  from:90;to:360;
                  duration: 400;


             }



          }




    }

   //课程目录模型
    ListModel
    {
        id:courseListmodel


    }

   //课程目录delegate
    Component
    {
        id:courseDelegate


        Column{
            spacing: -35

        Image {
            id: courseNameImage
            source:imagePath
            anchors.horizontalCenter: parent.horizontalCenter
           MouseArea
           {
             anchors.fill: parent
             onClicked:console.log("CLICK")


           }




              }

        Label
        {
            text:courseName
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 16

        }


            }
    }





}

//              Column
//              {
//                spacing:2

//                TabButton{text: qsTr("习题")}
//                TabButton{text: qsTr("习题")}
//                TabButton{text: qsTr("习题")}

//              }




//     id: course
//    default property alias content:stack.children

//    property int current: 0

//    onCurrentChanged:setVisible()
//    Component.onCompleted: setVisible()

//    function setVisible()
//    {
//        for (var i=0;i<stack.children.length;++i)
//        {
//            //stack.children[i].opacity=(i==current ? 1:0);
//           stack.children[i].visible=(i==current ? 1:0)

//        }


//    }

//    Row
//    {
//        id:header
//        Repeater
//        {
//            model:stack.children.length
//            delegate:Rectangle
//            {

//                width:course.width/stack.children.length;height:36

//                Rectangle
//                {
//                    width: parent.width;height: 1
//                    anchors{bottom: parent.bottom;bottomMargin: 1 }
//                }


////                BorderImage {
////                    anchors { fill: parent; leftMargin: 2; topMargin: 5; rightMargin: 1 }
////                    border { left: 7; right: 7 }
////                    source: "tab.png"
////                    visible: course.current == index
////                }
//                Text {

//                    horizontalAlignment: Qt.AlignHCenter; verticalAlignment: Qt.AlignVCenter
//                    anchors.fill: parent
//                    text: stack.children[index].title

//                    elide: Text.ElideRight
//                    font.bold: course.current == index
//                    font.pointSize:course.current==index ? 16:13


//                }
//                MouseArea {
//                    id:mousearea
//                    anchors.fill: parent
//                    onClicked: course.current = index

//                }






//            }
//        }

//    }


//    Item {
//        id: stack
//        width: course.width
//        anchors.top:header.bottom; anchors.bottom:course.bottom
//         }

























