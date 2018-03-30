#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QtQml>
#include<QObject>
#include"educationlauncherserver.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<educationlauncherserver>("an.QT.EDU",1,0,"EducationLauncherServer");//在QML中注册

   QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


     QObject* root=engine.rootObjects().first();
     educationlauncherserver* teacherserver=new educationlauncherserver;
     QObject::connect(root, SIGNAL(qmlSignal()), teacherserver, SLOT(startBroadcasting()));
     QObject::connect(root, SIGNAL(qmlSignal()), teacherserver, SLOT(slotCreatServer()));

    return app.exec();
}
