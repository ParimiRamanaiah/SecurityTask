sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/ram/ui3/test/integration/pages/ProductsList",
	"com/ram/ui3/test/integration/pages/ProductsObjectPage"
], function (JourneyRunner, ProductsList, ProductsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/ram/ui3') + '/test/flp.html#app-preview',
        pages: {
			onTheProductsList: ProductsList,
			onTheProductsObjectPage: ProductsObjectPage
        },
        async: true
    });

    return runner;
});

