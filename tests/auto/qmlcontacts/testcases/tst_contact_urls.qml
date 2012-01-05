/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
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

TestCase {
    name: "ContactsUrlsTests"

    TestCase {
        name: "ContactsUrlsTests::NoUrl"

        Contact {
            id: contactWithoutUrl
        }

        Contact {
            id: anotherContactWithoutUrl
        }

        Contact {
            id: yetAnotherContactWithoutUrl
        }

        function test_urlOfContactWithoutUrlIsDefined() {
            verifyIsDefined(contactWithoutUrl.url);
        }

        function test_urlOfContactWithoutUrlIsEmpty() {
            verifyIsUndefined(contactWithoutUrl.url.url);
            verifyIsUndefined(contactWithoutUrl.url.subType);
        }

        function test_urlsCountOfAnotherContactWithoutUrlIsZero() {
            // we do not access the url property of the contact,
            // so in this case the expected length is 0
            compare(anotherContactWithoutUrl.urls.length, 0);
        }

        function test_urlsCountOfYetAnotherContactWithoutUrlIsOne() {
            // we first access the url property of the contact,
            // so in this case the expected length is 1
            verifyIsDefined(yetAnotherContactWithoutUrl.url);
            compare(yetAnotherContactWithoutUrl.urls.length, 1);
        }
    }

    TestCase {
        name: "ContactsUrlsTests::OneUrl"

        Contact {
            id: contactWithOneUrl

            Url {
                url: "http://myUrl.com"
            }
        }

        function test_accessUrlThroughUrl() {
            compare(contactWithOneUrl.url.url, "http://myUrl.com");
        }

        function test_UrlCount() {
            compare(contactWithOneUrl.urls.length, 1);
        }

        function test_accessUrlThroughUrls() {
            compare(contactWithOneUrl.urls[0].url, "http://myUrl.com");
        }

        function test_accessUrlThroughDetails() {
            compare(contactWithOneUrl.details(
                        ContactDetail.Url)[0].url, "http://myUrl.com");
        }
    }

    TestCase {
        name: "ContactsUrlsTests::MultipleUrls"

        Contact {
            id: contactWithUrls

            Url {
                url: "http://myUrl.com"
            }

            Url {
                url: "http://myUrl2.com"
            }
        }

        function test_accessUrlThroughUrl() {
            compare(contactWithUrls.url.url, "http://myUrl.com");
        }

        function test_urlCount() {
            compare(contactWithUrls.urls.length, 2);
        }

        function test_accessUrlThroughUrls() {
            compare(contactWithUrls.urls[0].url, "http://myUrl.com");
            compare(contactWithUrls.urls[1].url, "http://myUrl2.com");
        }

        function test_accessUrlThroughDetails() {
            compare(contactWithUrls.details(
                        ContactDetail.Url)[0].url, "http://myUrl.com");
            compare(contactWithUrls.details(
                        ContactDetail.Url)[1].url, "http://myUrl2.com");
        }
    }

    TestCase {
        name: "ContactsUrlsTests::DynamicallyAdded::MultipleUrls"

        Contact {
            id: contact1
        }

        Url {
            id: url1
            url: "http://myUrl.com"
        }

        Url {
            id: url2
            url: "http://myUrl2.com"
        }

        function init() {
            contact1.clearDetails();
            contact1.addDetail(url1);
            contact1.addDetail(url2);
        }

        function test_accessUrlThroughUrl() {
            compare(contact1.url.url, "http://myUrl.com");
        }

        function test_urlCount() {
            verify(contact1.urls);
            compare(contact1.urls.length, 2);
        }

        function test_accessUrlThroughUrls() {
            compare(contact1.urls[0].url, "http://myUrl.com");
            compare(contact1.urls[1].url, "http://myUrl2.com");
        }

        function test_accessUrlThroughDetails() {
            compare(contact1.details(
                        ContactDetail.Url)[0].url, "http://myUrl.com");
            compare(contact1.details(
                        ContactDetail.Url)[1].url, "http://myUrl2.com");
        }

        function cleanup () {
            contact1.clearDetails();
        }
    }

    TestCase {
        name: "ContactsUrlsTests::ModificationSignaling"

        Contact {
            id: contactWithUrl
            Url {
                url: "http://old"
            }
        }

        function test_changeToDetailThroughUrlsEmitsSignal()
        {
            listenToSignalFromObject("contactChanged", contactWithUrl);
            contactWithUrl.urls[0].url = "http://new";
            verifySignalReceived();
        }

        function init() {
            spy = Qt.createQmlObject("import QtTest 1.0;" +
                                     "SignalSpy {}",
                                     this);
        }
    }

    property SignalSpy spy

    function listenToSignalFromObject(signalName, object) {
        spy.target = object;
        spy.signalName = signalName;
        spy.clear();
    }

    function verifySignalReceived() {
        spy.wait();
    }

    function verifyNoSignalReceived() {
        verify(spy.count == 0, "no signal was received");
    }

    function verifyIsUndefined(object) {
        verify(!object, "Object " + object + " is undefined");
    }

    function verifyIsDefined(object) {
        verify(object, "Object " + object + " is defined");
    }
}

