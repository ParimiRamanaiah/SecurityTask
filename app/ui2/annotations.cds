using {SalesService as sales} from '../../srv/service';
using from '../myfrontapp/annotations';


annotate sales.SalesOrders with @(
    UI.SelectionPresentationVariant #ConfirmedOrders:{
        $Type:'UI.SelectionPresentationVariantType',
        Text: 'Confirmed Orders',
        SelectionVariant:{
            $Type:'UI.SelectionVariantType',
            Text: 'Confirmed Orders',
            SelectOptions:[{
                $Type:'UI.SelectOptionType',
                PropertyName: status,
                Ranges:[{
                    $Type:'UI.SelectionRangeType',
                    Sign:#I,
                    Option:#EQ,
                    Low:'CONFIRMED'
                }]
            }]
        },
        PresentationVariant:{
            $Type:'UI.PresentationVariantType',
            Visualizations:['@UI.LineItem'],
        }
    },

    UI.SelectionPresentationVariant #WaitedOrders:{
        $Type:'UI.SelectionPresentationVariantType',
        Text: 'Waited Orders',
        SelectionVariant:{
            $Type:'UI.SelectionVariantType',
            Text: 'Waited Orders',
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
        PresentationVariant:{
            $Type:'UI.PresentationVariantType',
            Visualizations:['@UI.LineItem'],
        }
    },

    UI.SelectionPresentationVariant #AllOrders:{
        $Type:'UI.SelectionPresentationVariantType',
        Text: 'All Orders',
        SelectionVariant:{
            $Type:'UI.SelectionVariantType',
            SelectOptions:[{

            }]
        },
        PresentationVariant:{
            $Type:'UI.PresentationVariantType',
            Visualizations:['@UI.LineItem'],
            SortOrder:[{
                $Type:'Common.SortOrderType',
                Property:netAmount,
                Descending:false
            }],
            GroupBy:[priorityText]
        }
    }
);

