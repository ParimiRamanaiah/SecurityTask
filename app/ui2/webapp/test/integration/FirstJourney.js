sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheSalesOrdersList.iSeeThisPage();
            Then.onTheSalesOrdersList.onTable().iCheckColumns(9, {"ID":{"header":"Order ID"},"orderNumber":{"header":"Order Number"},"orderDate":{"header":"Order Date"},"deliveryDate":{"header":"Delivery Date"},"netAmount":{"header":"Net Amount"},"taxAmount":{"header":"Tax Amount"},"totalAmount":{"header":"Total Amount"},"statusText":{"header":"Status"},"priorityText":{"header":"Priority"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheSalesOrdersList.onFilterBar().iExecuteSearch();
            
            Then.onTheSalesOrdersList.onTable().iCheckRows();

            When.onTheSalesOrdersList.onTable().iPressRow(0);
            Then.onTheSalesOrdersObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});