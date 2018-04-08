#include <QGuiApplication>
#include<QApplication>
#include <QQmlApplicationEngine>
#include<QtQml>
#include<QObject>
#include<QQuickWindow>
#include<QDebug>
#include"educationlauncherserver.h"
#include"minimizetray.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //QGuiApplication app(argc, argv);
    QApplication app1(argc, argv);//此处修改为QApplication,否则无法用最小化托盘功能


    qmlRegisterType<educationlauncherserver>("an.QT.EDU",1,0,"EducationLauncherServer");//在QML中注册educationLauncher类
    qmlRegisterType<MinimizeTray>("an.QT.WindowControl",1,0,"MinimizeTray");//在QML中注册Minizetray类

   QQmlApplicationEngine engine;

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


//     QQuickWindow* root=static_cast<QQuickWindow*>(engine.rootObjects().first());
//    MinimizeTray* tray=new MinimizeTray(root);

//     educationlauncherserver* teacherserver=new educationlauncherserver;
//     QObject::connect(root, SIGNAL(qmlSignal()), teacherserver, SLOT(startBroadcasting()));
//     QObject::connect(root, SIGNAL(qmlSignal()), teacherserver, SLOT(slotCreatServer()));

    return app1.exec();
}
