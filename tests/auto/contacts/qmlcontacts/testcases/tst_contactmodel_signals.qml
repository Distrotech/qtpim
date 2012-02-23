/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/
**
** This file is part of the QtPim module of the Qt Toolkit.
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
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtTest 1.0
import QtContacts 5.0

ContactsSignalingTestCase {
    name: "ContactModelSignalsTests"
    id: contactModelSignalsTests

    // This test case is a unit test for contact model
    // so it does not require updates to contacts.
    ContactModel {
        id: model
        autoUpdate: false
    }

    IdFilter {
        id: filter
        ids: []
    }

    function test_settingTheFilterSendsSignal() {
        listenToSignalFromObject("filterChanged", model)
        model.filter = filter;
        verifySignalReceived();
    }

    IdFilter {
        id: oldFilter
        ids: []
    }

    IdFilter {
        id: newFilter
        ids: []
    }

    function test_changingTheFilterSendsSignal() {
        model.filter = oldFilter;

        listenToSignalFromObject("filterChanged", model)
        model.filter = newFilter;
        verifySignalReceived();
    }

    IdFilter {
        id: nonNullFilter
        ids: []
    }

    function test_removingTheFilterSendsSignal() {
        model.filter = nonNullFilter;

        listenToSignalFromObject("filterChanged", model)
        model.filter = null;
        verifySignalReceived();
    }

    IdFilter {
        id: theSameFilter
        ids: []
    }

    function test_settingTheSameFilterDoesNotSendSignal() {
        model.filter = theSameFilter;

        listenToSignalFromObject("filterChanged", model)
        model.filter = theSameFilter;
        verifyNoSignalReceived();
    }

    function init() {
        initSignalingTest();
    }
}
