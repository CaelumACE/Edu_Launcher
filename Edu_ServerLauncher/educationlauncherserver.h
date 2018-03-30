#ifndef EDUCATIONLUNCHERSERVER_H
#define EDUCATIONLUNCHERSERVER_H
#include<QtNetwork>
#include<QTimer>
#include <QObject>
#include"server.h"

class educationlauncherserver : public QObject
{
    Q_OBJECT
public:
    explicit educationlauncherserver(QObject *parent = nullptr);




public:
    int port;
    Server* teacherServer=nullptr;



public slots:
    void slotCreatServer();
    void slotUpdateServer(QString msg);
    void slotDisconnected(int i);

    void startBroadcasting();
    void broadcastDatagram();

    void controlProject();


signals:
    void qmlUpdateUdpBroadcast(QString broadcastStr); //用于qml的信号，UDP广播信息更新
    void qmlUpdateTcpConnectionMessage(QString connectionMessageStr);//用于QML信号，当服务器与客户端
    void qmlDisconnectedTcp(int i);
    void qmlClosePopup();

signals:
    void signalControlProject();






private:

    QUdpSocket* udpSocket;

private:
  //  QPushButton* startButton;
   // QPushButton* closeButton;
    QTimer* timer;
    int messageNo;


};

#endif // EDUCATIONLUNCHERSERVER_H
