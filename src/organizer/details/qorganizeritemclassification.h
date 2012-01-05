/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Pim module.
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

#ifndef QORGANIZERITEMCLASSIFICATION_H
#define QORGANIZERITEMCLASSIFICATION_H

#include <qorganizeritemdetail.h>

QTORGANIZER_BEGIN_NAMESPACE

class Q_ORGANIZER_EXPORT QOrganizerItemClassification : public QOrganizerItemDetail
{
public:
    Q_DECLARE_CUSTOM_ORGANIZER_DETAIL(QOrganizerItemClassification, "Classification")
    const static QString FieldClassification;

    const static QString Public;
    const static QString Private;
    const static QString Confidential;

    void setClassification(const QString &classification);
    QString classification() const;
};

QTORGANIZER_END_NAMESPACE

#endif// QORGANIZERITEMCLASSIFICATION_H
