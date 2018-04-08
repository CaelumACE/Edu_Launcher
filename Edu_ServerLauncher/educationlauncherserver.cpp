#include "educationlauncherserver.h"
#include "server.h"
#include<QProcess>
#include<QQuickView>


educationlauncherserver::educationlauncherserver(QObject *parent) : QObject(parent)
{


    port=6666;
    timer=new QTimer(this);
    udpSocket=new QUdpSocket(this);
    messageNo=10;
    connect(timer,SIGNAL(timeout()),this,SLOT(broadcastDatagram()));


}




void educationlauncherserver::startBroadcasting()//触发点击Start按钮后调用此槽函数开始计时
{
  timer->start(1000);
if(teacherServer==nullptr)
   slotCreatServer();

}


void educationlauncherserver::broadcastDatagram()//计时开始时触发此槽函数
{
  //ui->statusLabel->setText(tr("Now broadcasting datagram:   %1").arg(messageNo));
   //QString broadcastStr=messageNo;//tr(("Now broadcasting datagram:   %1").arg(messageNo));


  QByteArray datagram=QByteArray::number(messageNo);

  udpSocket->writeDatagram(datagram.data(),datagram.size(),QHostAddress::LocalHost,port);//udp广播
  emit qmlUpdateUdpBroadcast(datagram);
  --messageNo;
  if(messageNo<=0)
  {
      udpSocket->close();
      timer->stop();
      messageNo=10;
      emit qmlClosePopup();



  }

}




void educationlauncherserver::slotCreatServer()//创建服务器
{

   teacherServer=new Server(this,port);
   connect(teacherServer,SIGNAL(signalUpdateServer(QString)),this,SLOT(slotUpdateServer(QString)));
   connect(teacherServer,SIGNAL(signalDisconnected(int)),this,SLOT(slotDisconnected(int)));
   connect(this,&educationlauncherserver::signalControlProject,teacherServer,&Server::slotBroadcastOpenProject);

//   QString programAddress="C:/Users/wzh/AppData/Local/Google/Chrome/Application/chrome.exe";  //打开程序的路径
//   QStringList arguments;  //命令参数

//   QProcess *chromeProcess = new QProcess(this);
//   chromeProcess->start(programAddress,arguments);// 此处第二个参数为空，如果用一个参数，要保证programAddress中没有空格
}

void educationlauncherserver::slotUpdateServer(QString msg)//客户端新信息触发UI界面信息更新
{

    //  ui->listWidget->addItem(msg);

    emit qmlUpdateTcpConnectionMessage(msg);


}


void educationlauncherserver::slotDisconnected(int i)//客户端断开连接后，触发此函数，将Listwidget对应数据移除
{
  // ui->listWidget->takeItem(i);
   // ui ->listWidget->clear();

    emit qmlDisconnectedTcp(i);


}

void educationlauncherserver::controlProject()
{

   emit signalControlProject();
}




