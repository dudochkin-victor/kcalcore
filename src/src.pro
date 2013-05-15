# QMake project file for kcalcore sources. (For Harmmatan)
# make coverage
coverage.CONFIG += recursive
QMAKE_EXTRA_TARGETS += coverage \
    ovidebug
CONFIG(debug,debug|release) { 
    QMAKE_EXTRA_TARGETS += cov_cxxflags \
        cov_lflags \
        ovidebug
    cov_cxxflags.target = coverage
    cov_cxxflags.depends = CXXFLAGS \
        += \
        -fprofile-arcs \
        -ftest-coverage \
        -O0
    cov_lflags.target = coverage
    cov_lflags.depends = LFLAGS \
        += \
        -lgcov \
        -fprofile-arcs \
        -ftest-coverage
    coverage.commands = @echo \
        "Built with coverage support..."
    build_pass|!debug_and_release:coverage.depends = all
    QMAKE_CLEAN += $(OBJECTS_DIR)/*.gcda \
        $(OBJECTS_DIR)/*.gcno
}
TEMPLATE = lib
TARGET = kcalcoren
VER_MAJ = ${VER_MAJ}
VER_MIN = ${VER_MIN}
VER_PAT = ${VER_PAT}
DEPENDPATH += . \
    klibport \
    versit
INCLUDEPATH += . \
    .. \
    klibport \
    versit \
    kdedate \
    qtlockedfile/src \
    /usr/include/libical \
    /usr/include/glib-2.0 \
    /usr/lib/glib-2.0/include \
    /usr/include/dbus-1.0 \
    /usr/include/qt4/QtDBus
DEFINES += MEEGO \
    UUID \
    KCALCORE_FOR_MEEGO \
#    TIMED_SUPPORT \
    KCALCORE_FOR_SYMBIAN

LIBS += -lQtDBus \
    -lical \
    -licalss
QMAKE_CLEAN += lib*.so*
libraries.path += /usr/lib
libraries.files += lib*.so.*.*.*
headers.path += /usr/include/kcalcoren
headers.files += *.h \
    kdedate/*.h \
    kdedate/KDateTime \
    kdedate/KSystemTimeZone \
    kdedate/KSystemTimeZones \
    klibport/KCodecs \
    klibport/KConfig \
    klibport/KCondigGroup \
    klibport/KDebug \
    klibport/KRandom \
    klibport/KSaveFile \
    klibport/KStandardDirs \
    klibport/KUrl \
    klibport/*.h
kpimutils.path += /usr/include/kcalcoren/kpimutils
kpimutils.files += klibport/kpimutils/*.h
pkgconfig.path += /usr/lib/pkgconfig
pkgconfig.files += ../*.pc

contains (DEFINES, TIMED_SUPPORT) {
     LIBS += -ltimed
}
contains (DEFINES, KCALCORE_FOR_MEEGO) {
    LIBS += -luuid
}

INSTALLS += libraries \
    headers \
    kpimutils \
    pkgconfig
QMAKE_CXXFLAGS += -Werror
HEADERS += alarm.h \
    attachment.h \
    attendee.h \
    calendar.h \
    calfilter.h \
    calformat.h \
    calstorage.h \
    compat.h \
    customproperties.h \
    duration.h \
    event.h \
    exceptions.h \
    filestorage.h \
    freebusy.h \
    freebusycache.h \
    freebusyperiod.h \
    icalformat.h \
    icalformat_p.h \
    icaltimezones.h \
    incidence.h \
    incidencebase.h \
    journal.h \
    kdedate/kcalendarsystem.h \
    kdedate/KSystemTimeZone \
    kdedate/kcalendarsystemgregorian.h \
    kdedate/kcalendarsystemhebrew.h \
    kdedate/kcalendarsystemhijri.h \
    kdedate/kcalendarsystemjalali.h \
    kcodecs.h \
    kdedate/kdatetime.h \
    klibport/meego_port.h \
    kdedate/ksystemtimezone.h \
    kdedate/ktimezone.h \
    kdedate/ktzfiletimezone.h \
    period.h \
    person.h \
    recurrence.h \
    recurrencerule.h \
    sortablelist.h \
    todo.h \
    vcalformat.h \
    klibport/kapplication.h \
    klibport/kcmdlineargs.h \
    klibport/kcomponentdata.h \
    klibport/KConfig \
    klibport/kde_static.h \
    versit/port.h \
    versit/vcc.h \
    versit/vobject.h \
    klibport/KDebug \
    klibport/kdebug.h \
    klibport/klocale.h \
    calendar.moc \
    klibport/KRandom \
    klibport/global.h \
    klibport/kglobal.h \
    klibport/KSaveFile \
    klibport/KCodecs  \
    klibport/KUrl \
    klibport/config.h \
    klibport/kstringhandler.h \
    klibport/ktemporaryfile.h \
    klibport/KConfigGroup \
    klibport/kconfiggroup.h \
    klibport/kpimutils/email.h \
    klibport/KStandardDirs \
    klibport/kaboutdata.h \
    klibport/qtest_kde.h \
    klibport/incidenceformatter.h \
    sorting.h \
    memorycalendar.h \
    visitor.h \
    schedulemessage.h \
    invitationhandlerif.h \
    klibport/kdemacros.h \
    klibport/qtest_kde.h \
    klibport/meego_port.h \
    klibport/ktemporaryfile.h \
    klibport/kstringhandler.h \
    klibport/klocale.h \
    klibport/kde_static.h \
    klibport/kdemacros.h \
    klibport/kdecore_export.h \
    klibport/kcomponentdata.h \
    klibport/KCodecs \
    klibport/kcmdlineargs.h \
    klibport/kapplication.h \
    klibport/kaboutdata.h \
    klibport/incidenceformatter.h \
    klibport/config.h

SOURCES += alarm.cpp \
    klibport/meego_port.cpp \
    attachment.cpp \
    attendee.cpp \
    calendar.cpp \
    calfilter.cpp \
    calformat.cpp \
    calstorage.cpp \
    compat.cpp \
    customproperties.cpp \
    duration.cpp \
    event.cpp \
    exceptions.cpp \
    filestorage.cpp \
    freebusy.cpp \
    freebusyperiod.cpp \
    icalformat.cpp \
    icalformat_p.cpp \
    icaltimezones.cpp \
    incidence.cpp \
    incidencebase.cpp \
    journal.cpp \
    kdedate/kcalendarsystem.cpp \
    kdedate/kcalendarsystemgregorian.cpp \
    kdedate/kcalendarsystemhebrew.cpp \
    kdedate/kcalendarsystemhijri.cpp \
    kdedate/kcalendarsystemjalali.cpp \
    kdedate/kdatetime.cpp \
    kdedate/ksystemtimezone.cpp \
    kdedate/ktimezone.cpp \
    kdedate/ktzfiletimezone.cpp \
    period.cpp \
    person.cpp \
    recurrence.cpp \
    recurrencerule.cpp \
    todo.cpp \
    vcalformat.cpp \
    versit/vcc.c \
    versit/vobject.c \
    qtlockedfile/src/qtlockedfile.cpp \
    qtlockedfile/src/qtlockedfile_unix.cpp \
    sorting.cpp \
    memorycalendar.cpp \
    schedulemessage.cpp \
    visitor.cpp \
    klibport/kcodecs.cpp \
    klibport/global.cpp
