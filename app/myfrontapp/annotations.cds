using SalesService as sales from '../../srv/service';
//using MasterDataService as master from '../../srv/service';


/* ===============================
   OBJECT PAGE FIELD GROUP
=================================*/

annotate sales.SalesOrders with @(
    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Order ID', Value : ID },
            { $Type : 'UI.DataField', Label : 'Order Number', Value : orderNumber },
            { $Type : 'UI.DataField', Label : 'Customer', Value : customer_ID },
            { $Type : 'UI.DataField', Label : 'Order Date', Value : orderDate },
            { $Type : 'UI.DataField', Label : 'Delivery Date', Value : deliveryDate },
            { $Type : 'UI.DataField', Label : 'Net Amount', Value : netAmount },
            { $Type : 'UI.DataField', Label : 'Tax Amount', Value : taxAmount },
            { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
            { $Type : 'UI.DataField', Label : 'Currency', Value : currency_code },
            { $Type : 'UI.DataField', Label : 'Status', Value : statusText },
            { $Type : 'UI.DataField', Label : 'Priority', Value : priorityText }
        ]
    },


/* ===============================
   OBJECT PAGE FACETS
=================================*/

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneralInfoFacet',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneralInformation'
        }
    ],


/* ===============================
   LIST REPORT TABLE
=================================*/

    UI.LineItem : [

        { $Type : 'UI.DataField', Label : 'Order ID', Value : ID },

        { $Type : 'UI.DataField', Label : 'Order Number', Value : orderNumber },

        { $Type : 'UI.DataField', Label : 'Customer', Value : customer_ID },

        { $Type : 'UI.DataField', Label : 'Order Date', Value : orderDate },

        { $Type : 'UI.DataField', Label : 'Delivery Date', Value : deliveryDate },


/* ===============================
   ACTION BUTTON (Approve Order)
   Visible only if user has role
=================================*/

        {
            $Type : 'UI.DataFieldForAction',
            Action : 'SalesService.approveOrder',
            Label : 'Approve Order',
            Inline : false
        },


/* ===============================
   FUNCTION BUTTON (Get Orders)
=================================*/

        {
            $Type : 'UI.DataFieldForAction',
            Action : 'SalesService.getTotalOrders',
            Label : 'Total Orders',
            Inline : false
        }

    ]
);



/* ===============================
   VALUE HELP FOR CUSTOMER
=================================*/

annotate sales.SalesOrders with {

    customer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters : [

            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : customer_ID,
                ValueListProperty : 'ID'
            },

            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'customerNumber'
            },

            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name'
            },

            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'country'
            },

            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'city'
            }

        ]
    };

};



/* ===============================
   ACTION ENABLE / DISABLE
   Based on Order Status
=================================*/

annotate sales.approveOrder with @(
    Core.OperationAvailable : true
);



/* ===============================
   CRITICALITY COLOR
=================================*/

annotate sales.SalesOrders with {

    criticality @UI.Criticality : criticality

};