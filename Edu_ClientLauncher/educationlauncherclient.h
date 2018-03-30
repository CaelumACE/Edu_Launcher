#ifndef EDUCATIONLUNCHERCLIENT_H
#define EDUCATIONLUNCHERCLIENT_H

#include <QMainWindow>
#include <QtNetwork>

namespace Ui {
class EducationLuncherClient;
}

class EducationLuncherClient : public QMainWindow
{
    Q_OBJECT

public:
    explicit EducationLuncherClient(QWidget *parent = 0);
    ~EducationLuncherClient();



private slots:

    void processPendingDatagrams();




    void slotConnected();
    void slotreadServer();
    void slotOpenProject();
    void slotDisconnected();


private:
    QTcpSocket* tcpClient;//TCP
    QUdpSocket*  udpScoket;//UDP



private:
    Ui::EducationLuncherClient *ui;
};

#endif // EDUCATIONLUNCHERCLIENT_H
