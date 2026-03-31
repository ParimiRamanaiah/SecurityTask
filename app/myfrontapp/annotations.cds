using SalesService as sales from '../../srv/service';

//adding lineitems on list report page
annotate sales.SalesOrders with @(
UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Label: 'Order ID',
        Value: ID
    },
    {
        $Type: 'UI.DataField',
        Label: 'Order Number',
        Value: orderNumber
    },
    {
        $Type: 'UI.DataField',
        Label: 'Order Date',
        Value: orderDate
    },
    {
        $Type: 'UI.DataField',
        Label: 'Delivery Date',
        Value: deliveryDate
    },
    {
        $Type: 'UI.DataField',
        Label: 'Net Amount',
        Value: netAmount
    },
    {
        $Type: 'UI.DataField',
        Label: 'Tax Amount',
        Value: taxAmount
    },
    {
        $Type: 'UI.DataField',
        Label: 'Total Amount',
        Value: totalAmount
    },
    {
        $Type: 'UI.DataField',
        Label: 'Status',
        Value: statusText,
    },
    {
        $Type: 'UI.DataField',
        Label: 'Priority',
        Value: priorityText,
        Criticality:priority,
        CriticalityRepresentation:#WithIcon
    }
]
 );

//adding header on list report page
annotate sales.SalesOrders with @(
    UI.HeaderInfo: {
        TypeName:'SalesOrders',
        TypeNamePlural:'Sales Orders',

        // Title:{
        //     Value:netAmount
        // },
        // Description:{
        //     Value:statusText
        // } these are related to object page, when we will click on line item, it will go object page
        //there we will see title with description
    }
);

//single table - segmented view
annotate sales.SalesOrders with @(
    UI.SelectionVariant #AllOrders:{
        $Type:'UI.SelectionVariantType',
        Text:'All Orders',
        SelectOptions:[{
            $Type:'UI.SelectOptionType',
        }]
    },

    UI.SelectionVariant #PendingOrders:{
        $Type:'UI.SelectionVariantType',
        Text:'Pending Orders',
        SelectOptions:[{
            $Type:'UI.SelectOptionType',
            PropertyName: status,
            Ranges:[{
                $Type:'UI.SelectionRangeType',
                Sign:#I,
                Option:#EQ,
                Low:'PENDING'
            }]
        }]
    },

    UI.SelectionVariant #ApprovedOrders:{
        $Type:'UI.SelectionVariantType',
        Text: 'Approved Orders',
        SelectOptions:[{
            $Type:'UI.SelectOptionType',
            PropertyName:status,
            Ranges:[{
                Sign:#I,
                Option:#EQ,
                Low:'CONFIRMED'
            }]
        }]
    },
)
