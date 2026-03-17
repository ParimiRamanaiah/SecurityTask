sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.ram.ui2',
            componentId: 'SalesOrdersObjectPage',
            contextPath: '/SalesOrders'
        },
        CustomPageDefinitions
    );
});