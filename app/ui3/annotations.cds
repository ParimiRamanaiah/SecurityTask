using MasterDataService as service from '../../srv/service';

annotate service.Products with @(
    UI.LineItem #products : [
    {
    $Type: 'UI.DataField',
    Label: 'Product ID',
    Value: ID
    },
    {
    $Type: 'UI.DataField',
    Label: 'Product Code',
    Value: productCode
    },
    {
    $Type: 'UI.DataField',
    Label: 'Description',
    Value: description
    },
    {
    $Type: 'UI.DataField',
    Label: 'Category',
    Value: category
    },
    {
    $Type: 'UI.DataField',
    Label: 'Price',
    Value: price
    }
],

UI.HeaderInfo:{
    TypeName: 'Products',
    TypeNamePlural: 'Products'
},
);

annotate service.Products with @(
    UI.SelectionPresentationVariant #productsTable:{
        $Type: 'UI.SelectionPresentationVariantType',
        Text: 'Products (Table)',
        SelectionVariant:{
            $Type: 'UI.SelectionVariantType',
            Text: 'Products (Table)',
            SelectOptions:[{
                $Type: 'UI.SelectOptionType',
                PropertyName: category,
                Ranges: [{
                    Sign:#I,
                    Option:#NE,
                    Low:'Groceries'
                }]
            }]
        },
        PresentationVariant:{
            $Type: 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#products']
        }
    }
);

annotate service.Products with @(

    Aggregation.ApplySupported : {
    Transformations : ['aggregate','groupby'],
    GroupableProperties : [category],
    AggregatableProperties : [{
        Property : price,
        SupportedAggregationMethods : ['sum']
    }]
},


    Analytics.AggregatedProperty #totalPrice_sum:{
        $Type:'Analytics.AggregatedPropertyType',
        Name:'totalPrice_sum',
        AggregatableProperty:price,
        AggregationMethod:'sum',
        ![@Common.Label]:'totalprice (sum)',
    },

    UI.Chart #productChart:{
    $Type: 'UI.ChartDefinitionType',
    Title: 'Products by Category',
    ChartType: #Bar,

    Dimensions:[
        category
    ],

    DimensionAttributes:[{
        $Type:'UI.ChartDimensionAttributeType',
        Dimension: category,
        Role: #Category
    }],

    DynamicMeasures:[
        '@Analytics.AggregatedProperty#totalPrice_sum'
    ]
}
);

annotate service.Products with @(
    UI.SelectionPresentationVariant #ProductsChart:{
        $Type:'UI.SelectionPresentationVariantType',
        Text:'Products (Chart)',
        SelectionVariant:{
            $Type:'UI.SelectionVariantType',
            SelectOptions:[{
                $Type:'UI.SelectOptionType',
                PropertyName:price,
                Ranges:[{
                    $Type:'UI.SelectionRangeType',
                    Sign:#I,
                    Option:#EQ,
                    Low:'price'
                }]
            }]
        },
        PresentationVariant:{
            $Type:'UI.PresentationVariantType',
            Visualizations:['@UI.Chart#productChart']
        }
    }
)