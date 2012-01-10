/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
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
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtTest 1.0
import QtContacts 5.0

ContactsSavingTestCase {
    name: "ContactsSortingTests"

    ContactModel {
        id: modelSortedByFirstName
        autoUpdate:true
        sortOrders: [
            SortOrder {
                detail: ContactDetail.Name
                field: Name.FirstName
                direction: Qt.AscendingOrder
            }
        ]
    }

    Contact {
        id: contact1
        Name {
            firstName: "A"
        }
    }

    Contact {
        id: contact2
        Name {
            firstName: "B"
        }
    }

    function test_sortByFirstName()
    {
        initTestForModel(modelSortedByFirstName);

        emptyContacts(modelSortedByFirstName);

        modelSortedByFirstName.saveContact(contact2);
        waitForContactsChanged();
        modelSortedByFirstName.saveContact(contact1);
        waitForContactsChanged();

        compareContactArrays(modelSortedByFirstName.contacts, [contact1, contact2]);

        emptyContacts(modelSortedByFirstName);
    }

    ContactModel {
        id: modelSortedByLastName
        autoUpdate:true
        sortOrders: [
            SortOrder {
                detail: ContactDetail.Name
                field: Name.LastName
                direction: Qt.AscendingOrder
            }
        ]
    }

    Contact {
        id: contactWithLastName1
        Name {
            lastName: "A"
        }
    }

    Contact {
        id: contactWithLastName2
        Name {
            lastName: "B"
        }
    }

    function test_sortByLastName()
    {
        initTestForModel(modelSortedByLastName);

        emptyContacts(modelSortedByLastName);

        modelSortedByLastName.saveContact(contactWithLastName2);
        waitForContactsChanged();
        modelSortedByLastName.saveContact(contactWithLastName1);
        waitForContactsChanged();

        compareContactArrays(modelSortedByLastName.contacts, [contactWithLastName1, contactWithLastName2]);

        emptyContacts(modelSortedByLastName);
    }

    ContactModel {
        id: modelSortedByEmailAddress
        autoUpdate:true
        sortOrders: [
            SortOrder {
                detail: ContactDetail.Email
                field: EmailAddress.EmailAddress
                direction: Qt.AscendingOrder
            }
        ]
    }

    Contact {
        id: contactWithEmailAddress1
        EmailAddress {
            emailAddress: "a@a"
        }
    }

    Contact {
        id: contactWithEmailAddress2
        EmailAddress {
            emailAddress: "b@b"
        }
    }

    function test_sortByEmail()
    {
        initTestForModel(modelSortedByEmailAddress);

        emptyContacts(modelSortedByEmailAddress);

        modelSortedByEmailAddress.saveContact(contactWithEmailAddress2);
        waitForContactsChanged();
        modelSortedByEmailAddress.saveContact(contactWithEmailAddress1);
        waitForContactsChanged();

        compareContactArrays(modelSortedByEmailAddress.contacts, [contactWithEmailAddress1, contactWithEmailAddress2]);

        emptyContacts(modelSortedByEmailAddress);
    }

    ContactModel {
        id: modelSortedByLastAndFirstName
        autoUpdate:true
        sortOrders: [
            SortOrder {
                detail: ContactDetail.Name
                field: Name.FirstName
                direction: Qt.AscendingOrder
            },
            SortOrder {
                detail: ContactDetail.Name
                field: Name.LastName
                direction: Qt.AscendingOrder
            }
        ]
    }

    Contact {
        id: contactWithFirstAndLastName1
        Name {
            lastName: "A"
            firstName: "E"
        }
    }

    Contact {
        id: contactWithFirstAndLastName2
        Name {
            lastName: "B"
            firstName: "C"
        }
    }

    Contact {
        id: contactWithFirstAndLastName3
        Name {
            lastName: "B"
            firstName: "D"
        }
    }

    function test_sortByLastAndFirstName()
    {
        initTestForModel(modelSortedByLastAndFirstName);

        emptyContacts(modelSortedByLastAndFirstName);

        modelSortedByLastAndFirstName.saveContact(contactWithFirstAndLastName3);
        waitForContactsChanged();
        modelSortedByLastAndFirstName.saveContact(contactWithFirstAndLastName2);
        waitForContactsChanged();
        modelSortedByLastAndFirstName.saveContact(contactWithFirstAndLastName1);
        waitForContactsChanged();

        compareContactArrays(modelSortedByLastAndFirstName.contacts,
                             [contactWithFirstAndLastName1, contactWithFirstAndLastName2,
                             contactWithFirstAndLastName3]);

        emptyContacts(modelSortedByLastAndFirstName);
    }

    function initTestCase() {
        var spy1 = initTestForModel(modelSortedByFirstName);
        var spy2 = initTestForModel(modelSortedByLastName);
        var spy3 = initTestForModel(modelSortedByEmailAddress);
        var spy4 = initTestForModel(modelSortedByLastAndFirstName);

        spy1.wait();
        spy2.wait();
        spy3.wait();
        spy4.wait();
    }

    function cleanupTestCase() {
        finishTestForModel(modelSortedByFirstName);
        finishTestForModel(modelSortedByLastName);
        finishTestForModel(modelSortedByEmailAddress);
        finishTestForModel(modelSortedByLastAndFirstName);
    }

    function compareContactArrays(actual, expected) {
        compare(actual.length, expected.length, "length");
        for (var i = 0; i < expected.length; i++) {
            compareContacts(actual[i], expected[i], "index " + i);
        }
    }

    function compareContacts(actual, expected, message) {
        if (expected.name) {
            compare(actual.name.firstName, expected.name.firstName, message + ': name.firstName');
            compare(actual.name.lastName, expected.name.lastName, message + ': name.lastName');
        }
        if (expected.email) {
            compare(actual.email.emailAddress, expected.email.emailAddress,
                    message + ': email.emailAddress');
        }
    }
}
