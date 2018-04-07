#include "minimizetray.h"
#include <QApplication>
#include<QQuickItem>
#include<QQmlImageProviderBase>

MinimizeTray::MinimizeTray(QQuickWindow* root)

{
     //window=root;
    initTrayMenu();
    initTrayIcon();


}

//初始化托盘菜单
void MinimizeTray::initTrayMenu()
{
//    m_miniSizeAction=new QAction("Min(&Vx)",this);
//    m_maxSizeAction=new  QAction("Max(&X)",this);
//    m_restoreWinAction=new QAction("Reduction(&R)",this);
    m_quitAction=new QAction("Quit(&Q)",this);

//    m_miniSizeAction->setIcon(QIcon(":/image/darn cute_01.ico"));
//    m_maxSizeAction->setIcon(QIcon(":/image/darn cute_01.ico"));
    m_quitAction->setIcon(QIcon(":/image/darn cute_01.ico"));
    m_menu=new QMenu((QWidget*)QApplication::desktop());
//    m_menu->addAction(m_miniSizeAction);
//    m_menu->addAction(m_maxSizeAction);
//    m_menu->addAction(m_restoreWinAction);
//   m_menu->addSeparator();     //加入一个分隔符
    m_menu->addAction(m_quitAction);

//  connect(m_miniSizeAction,&QAction::triggered,window,&QQuickWindow::hide);
//   connect(m_maxSizeAction,&QAction::triggered,window,&QQuickWindow::showMaximized);
//   connect(m_restoreWinAction,&QAction::triggered,window,&QQuickWindow::showNormal);
//   connect(m_quitAction,&QAction::triggered,window,&QQuickWindow::close);


//  connect(m_maxSizeAction,&QAction::triggered,this,&MinimizeTray::changeMinimizeTray);
//  connect(m_restoreWinAction,&QAction::triggered,this,&MinimizeTray::changeMinimizeTray);

//   connect(window,&QQuickWindow::closing,this,&MinimizeTray::closeEvent);
   connect(m_quitAction, SIGNAL(triggered()), qApp, SLOT(quit()));




}

//初始化托盘图标和提示信息
void MinimizeTray::initTrayIcon()
{   //判断系统是否支持系统托盘图标
    if(!QSystemTrayIcon::isSystemTrayAvailable())
    {
        return;
    }
    m_myTrayIcon=new QSystemTrayIcon(this);
    QIcon tmpicon=QIcon(":/image/darn cute_01.ico");
    m_myTrayIcon->setIcon(tmpicon);
    //setWindowIcon(tmpicon);  //把图片设置到窗口上
    m_myTrayIcon->setToolTip("Teacher V1.0");//托盘时，鼠标放上去的提示信息
    m_myTrayIcon->showMessage("I am here","Hi,This is my TeacherIcon",QSystemTrayIcon::Information,5000);
    m_myTrayIcon->setContextMenu(m_menu);//设置托盘上下文菜单
    m_myTrayIcon->show();

    connect(m_myTrayIcon,SIGNAL(activated(QSystemTrayIcon::ActivationReason)),this,SLOT(iconActivated(QSystemTrayIcon::ActivationReason)));

}

void MinimizeTray::iconActivated(QSystemTrayIcon::ActivationReason reason)
{
    switch (reason) {
   // case QSystemTrayIcon::Trigger:
       //break;
    case QSystemTrayIcon::DoubleClick:
         changeMinimizeTray();//双击鼠标左键将窗口最大化显示
        break;
     case QSystemTrayIcon::MiddleClick:
            m_myTrayIcon->showMessage("I am here","Hi,This is my TeacherIcon",QSystemTrayIcon::Information,5000);
    default:
        break;
    }


}

//void MinimizeTray::closeEvent(QCloseEvent *event)
//{
//    if(m_myTrayIcon->isVisible())
//    {
//        m_myTrayIcon->showMessage("I am here","Hi,This is my TeacherIcon",QSystemTrayIcon::Information,5000);
//        window->hide();
//        event->ignore();
//    }else {
//        event->accept();
//    }


//}


//向QML发送窗口变化改变消息
void MinimizeTray::changeMinimizeTray()

{

    emit qmlChangeMinimizeTraySignal();

}
