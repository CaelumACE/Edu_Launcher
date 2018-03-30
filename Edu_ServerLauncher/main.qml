import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import an.QT.EDU 1.0

ApplicationWindow {
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Teacher")



    //定义qml中信号函数
    signal qmlSignal();

    signal qmlOpenProjectSignal();

    property string buttonText:"开始(10s)"

   //c++类在qml中的对象
    EducationLauncherServer
    {
        id:teacherServer
    }


Component.onCompleted:setPhysicCourse();

  function setListModel()
  {

     for(var i=0;i<50;i++)
     {
         popupListModel.append({name:"客户端",codecolor:"black"});

     }
  }

  function setPhysicCourse()
  {
      for(var i=0;i<50;i++)
      {
          courseModel.append({name: "电学",colorcode:"lightgreen"});

      }
      setListModel();

  }









    //菜单栏
    header: TabBar{
        id: tabBar
        currentIndex: swipeView.currentIndex
        font.pointSize: 22
        TabButton {
            text: qsTr("课件")

        }
        TabButton {
            text: qsTr("题库")

        }

        TabButton {
            text: qsTr("数据")
        }
    }



//页面滚动效果

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        //课程页面
       Courseware{


           //物理
           Rectangle {
               property string title: "物理"

               anchors.fill: parent
               radius: 8
               color: "#e3e3e3"

               Rectangle {
                   anchors.fill: parent; anchors.margins: 40
                   radius: 8






                   Label
                   {
                       id: udpConnectionMessage
                       font.pointSize: 20
                       text: qsTr("Udp广播信息")
                       anchors.bottom: parent.bottom
                       anchors.horizontalCenter: parent.horizontalCenter

                       Label
                       {
                           id:tcpConnectionMessage
                           font.pointSize:20
                           text: qsTr("Tcp连接信息")
                           anchors.bottom: parent.top
                           anchors.bottomMargin:20
                       }

                   }



                   //网格布局
                   GridView {
                       id: gridView
                       x:parent.x+30
                       focus: true
                       width: parent.width
                       height: parent.height
                       cellWidth: 200
                       cellHeight:200
                       interactive:true
                       clip: true




                       delegate: Item {
                           x: 5
                           height: 50
                           width: 50
                           Column {          //列组件
                               spacing:5
                               Rectangle {
                                   id:myIcon
                                   width: 100
                                   height: 100
                                   color: colorcode
                                   //source: icon
                                   anchors.horizontalCenter: parent.horizontalCenter
                                   MouseArea
                                   {

                                       anchors.fill: parent
                                       hoverEnabled: true
                                       onClicked:
                                       {
                                           popup.open();

                                         teacherServer.startBroadcasting();
                                       // teacherServer.slotCreatServer();

                                      //   qmlSignal();


                                       }
                                       onEntered:{console.log("entered")}
                                       onExited: console.log("Exited")

                                   }


                                   }

                               Text {
                                   x: 5
                                   text: name
                                   font.bold: true
                                   anchors.horizontalCenter: parent.horizontalCenter
                                   }


                                    }



                       }
                       //数据模型，物理课程
                       model: ListModel{
                           id:courseModel
//                           ListElement{name: "电学" ;colorcode:"green"}
//                           ListElement{name: "力学浮力" ;colorcode:"black"}
//                           ListElement{name: "摩擦力" ;colorcode:"red"}
//                           ListElement{name: "光学" ;colorcode:"pink"}

                      }

                   }


                    }
             }


           //化学
           Rectangle {
               property string title: "化学"
               anchors.fill: parent
               color: "#e3e3e3"

               Rectangle {
                   anchors.fill: parent; anchors.margins: 20
                   color: "#7fff7f"
//                   Text {
//                       width: parent.width - 20
//                       anchors.centerIn: parent; horizontalAlignment: Qt.AlignHCenter
//                       text: "Flower stems are green"
//                       font.pixelSize: 20
//                       wrapMode: Text.WordWrap
//                   }
               }
           }
           //生物
           Rectangle {
               property string title: "生物"
               anchors.fill: parent; color: "#e3e3e3"

               Rectangle {
                   anchors.fill: parent; anchors.margins: 20
                   color: "#7f7fff"
//                   Text {
//                       width: parent.width - 20
//                       anchors.centerIn: parent; horizontalAlignment: Qt.AlignHCenter
//                       text: "Violets are blue"
//                       font.pixelSize: 20
//                       wrapMode: Text.WordWrap
//                   }
               }
           }



       }






       //练习题
       TestLibray
       {

       }


       //数据统计
        Database{


                }
  }



//页标识组件
    PageIndicator
    {
        id:pageIndicator
        interactive: false
        count: swipeView.count
        currentIndex: swipeView.currentIndex

        anchors.bottom: parent.bottom
        anchors.horizontalCenter:parent.horizontalCenter


    }




//点击课程后 ，弹出连接客户端的连接情况
        Popup {
            id: popup
            leftMargin: parent.width/2-parent.width/4
            topMargin:  parent.height/2-parent.height/4
            width: parent.width/2
            height: parent.height/2
            modal: true



            leftPadding: 0;rightPadding: 0;topPadding: 0;bottomPadding:0;
            closePolicy: Popup.CloseOnPressOutsideParent


            Rectangle
            {
                width:parent.width-10
                height:parent.height-10
                anchors.fill: parent
                color:"lightblue"
                //anchors.margins: 10
                radius:10








                 GridView
                 {

                     id:popupGridview
                     width: parent.width
                     height: parent.height
                     x:parent.x+45
                     y:parent.y+25
                     cellHeight: 90
                     cellWidth: 90
                     clip:true
                     interactive: false
                     model: popupListModel
                     delegate:popupDelegate



                 Component
                 {
                   id:popupDelegate


                   Column
                   {
                       spacing: 5
                   Rectangle
                   {
                       width: 60
                       height: 60
                       color:codecolor
                       radius: 10
                       anchors.horizontalCenter: parent.horizontalCenter

                   }

                   Text {

                       text:name+(index+1)
                       font.pointSize:10
                       font.bold: false
                       anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                 }




                   ListModel
                {
                    id:popupListModel


 //                ListElement{name:"客户端1";codecolor:"black"}
//                 ListElement{name:"客户端2";codecolor:"black"}
//                 ListElement{name:"客户端3";codecolor:"black"}
//                 ListElement{name:"客户端4";codecolor:"black"}



                 }





              }



                   Button
                   {

                       id:openProject
                       width: 110
                       height: 50
                       font.pointSize: 15
                       font.bold:true
                       text:buttonText
                       enabled: false
                       anchors.bottom: parent.bottom
                       anchors.horizontalCenter: parent.horizontalCenter
                       anchors.bottomMargin: 0

                       onClicked:
                       {
                           console.log("开始")
                           popup.close()
                           teacherServer.controlProject();
                           openProject.enabled=false;


                       }

                   }


}


}


//绑定c++信号
        Connections
        {
            target:teacherServer;
            onQmlUpdateUdpBroadcast:
            {

              //udpConnectionMessage.text=broadcastStr;
              buttonText="开始"+"("+broadcastStr+"s)"

            }

            onQmlUpdateTcpConnectionMessage:
            {
               tcpConnectionMessage.text=connectionMessageStr;


            }

            onQmlClosePopup:
            {
              buttonText="开始(10s)";
              openProject.enabled=true;


            }

            onQmlDisconnectedTcp:
            {


            }

        }


}

