#ifndef MINIMIZETRAY_H
#define MINIMIZETRAY_H
#include <QObject>
#include<QMainWindow>
#include<QQuickWindow>
#include <QWidget>
#include <QMenu>
#include <QSystemTrayIcon>
//#include <QCloseEvent>

class MinimizeTray : public QObject
{
    Q_OBJECT
public:
    explicit MinimizeTray();


public:

    QSystemTrayIcon *m_myTrayIcon= nullptr;
    QMenu *m_menu= nullptr;
    QAction *m_miniSizeAction= nullptr;
    QAction *m_maxSizeAction= nullptr;
    QAction *m_restoreWinAction= nullptr;
    QAction *m_quitAction= nullptr;
private:
    void initTrayMenu();
    void initTrayIcon();
private slots:
    void iconActivated(QSystemTrayIcon::ActivationReason reason);





public slots:
    void qmlDoubleClickChangeWindow();
    void qmlChangeHideWindow();
    void qmlChangeRestoreWindow();
    void qmlChangeMaximizeWindow();

signals:
    void qmlChangeMinimizeTraySignal();
    void qmlHideWindowSignal();
    void qmlChangeRestoreWindowSignal();
    void qmlChangeMaximizeWindowSignal();


};

#endif // MINIMIZETRAY_H
