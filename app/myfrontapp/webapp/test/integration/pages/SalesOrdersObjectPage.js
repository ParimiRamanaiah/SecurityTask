sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.myfrontapp',
            componentId: 'SalesOrdersObjectPage',
            contextPath: '/SalesOrders'
        },
        CustomPageDefinitions
    );
});