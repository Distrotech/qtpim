/****************************************************************************
**
** Copyright (C) 2009 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QCONTACTJSONDBREQUESTHANDLER_H
#define QCONTACTJSONDBREQUESTHANDLER_H

#include <QThread>
#include <QMutex>
#include <QWaitCondition>
#include "qcontactabstractrequest.h"
#include "qcontact.h"
#include "qcontactchangeset.h"

QTPIM_USE_NAMESPACE

#include <jsondb-global.h>
Q_ADDON_JSONDB_BEGIN_NAMESPACE
class JsonDbClient;
class JsonDbConnection;
Q_ADDON_JSONDB_END_NAMESPACE
Q_USE_JSONDB_NAMESPACE

class QContactJsonDbRequestManager;
class QContactJsonDbEngine;
class QContactJsonDbConverter;
class QContactJsonDbRequestHandler : public QObject
{
    Q_OBJECT
public:
    QContactJsonDbRequestHandler();
    virtual ~QContactJsonDbRequestHandler();

    void setEngine(QContactJsonDbEngine* engine);

public slots:
    bool waitForRequestFinished(QContactAbstractRequest* req, int msecs);
    void handleRequest(QContactAbstractRequest* req);
    void onNotified(const QString& notifyUuid, const QVariant& object, const QString& action);
    void onResponse(int id, const QVariant& object);
    void onError(int id, int code, const QString& message);
    void init();
public slots:
  void removeDestroyed(QObject *);
private:
    QContactJsonDbEngine* m_engine;
    JsonDbClient* m_jsonDb;
    JsonDbConnection* m_jsonConnection;
    QContactJsonDbRequestManager* m_requestMgr;
    // Mutex to make the request state changes atomic
    QMutex* m_reqStateMutex;
    QContactJsonDbConverter* m_converter;
    QList <QContactAbstractRequest*> m_reqList;
    QContactChangeSet m_ccs;

};

#endif // QCONTACTJSONDBREQUESTHANDLER_H
