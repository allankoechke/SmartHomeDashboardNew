#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QFont>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    int id = QFontDatabase::addApplicationFont(":/SmartDashboard/assets/fonts/CodecPro-Regular.ttf");

    QFont font("Codec Pro");
    // font.setStyleHint(QFont::Normal);
    QGuiApplication::setFont(font);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/SmartDashboard/qml/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
