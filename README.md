# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.
///////////////////////////////////////////////////////

Sales App
(1).multple tabs for different entities on list report page 

 "defaultTemplateAnnotationPath": "com.sap.vocabularies.UI.v1.SelectionPresentationVariant#tableView" --> manifest.json
  --> under targets 
"views": {
                "paths": [
                  {
                    "key": "tableView",
                    "annotationPath": "com.sap.vocabularies.UI.v1.SelectionPresentationVariant#Orders"
                  },
                  {
                    "key": "tableView1",
                    "annotationPath": "com.sap.vocabularies.UI.v1.SelectionPresentationVariant#tableView1"
                  }
                ]
              }
            } --> manifest.json

annotate sales.SalesOrders with @(
        UI.SelectionPresentationVariant #Orders : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Sales Orders',
    },
    UI.LineItem #tableView : [
    ],
    
    UI.SelectionPresentationVariant #Items : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Items',
    },
    ); --> annotations.cds

It is not possible to keep multiple tabs to different pages on list report page.
In Fiori elements for OData V4, a List Report (LR) is bound to one entity set.
The built‑in “multiple views/tabs” feature (tabs or segmented buttons) can show different views of the same entity set
e.g., different filters, sortings, or visualizations—but cannot bind each tab to a different entity set.

possibility ways
Multiple Views (Tabs) for the same entity set

Use annotations like UI.SelectionVariant, UI.PresentationVariant, and UI.SelectionPresentationVariant to define each view/tab (e.g., “Open”, “Closed”, “Mine”).
Great when the underlying entity is the same and only the filter/columns differ.

Multiple List Reports in one app (routing)

Create separate LR pages (each bound to its own entity set) and offer navigation between them via shell navigation, a start page, or a menu.
Feels like “tabs” at the app level rather than inside the LR.

Baisc/freestyle --> Freestyle (SAPUI5) shell with IconTabBar

Note:- entity SalesOrders : managed { key ID : Integer; orderNumber : String(15); customer : Association to Customers; orderDate : Date; deliveryDate : Date; netAmount : Decimal(13,2); taxAmount : Decimal(13,2); totalAmount : Decimal(13,2); currency : Currency; status : String(1); statusText : String(20); priority : String(1); priorityText : String(10); criticality : Integer; items : Composition of many SalesOrderItems on items.order = $self; } here relationship to customer & items there --> so we can create na customers tab and items tab, is it possible?
What you are thinking is correct conceptually, but the place where it is possible is the Object Page, not the List Report.
List Report = one entity only
Object Page = related entities as tabs (via associations/compositions)
Even if entities have associations or compositions, Fiori Elements List Report cannot show different entities as tabs.
This is a framework limitation, not a CAP limitation.
List Report is always bound to one EntitySet from the OData service.(/odata/v4/sales/SalesOrders)
Tabs in List Report only switch filters, not entities.(They only change query conditions.)
Relationships work in Object Page, not List Report.

I have created a view by different entities data, can i keep this view on list report page?
this is the correct approach if you want to show data from multiple entities in one List Report.
If you create a CDS view (projection or database view) combining multiple entities, then that view becomes a single entity, and List Report can bind to it.
This is a valid and commonly used CAP pattern.

we will create one view with entites data then keep this view as bound to list report --> now it is like single entity list report page, by using this bound view we can create multiple tabs and show each entity data on different tabs why because total data is available in view. am i correct & is it good approach?
conceptually you are correct, but there is an important architectural clarification.
This is partially correct, but depends on how you structure the view.
This is not ideal, because:
All data loads every time
Many NULL columns
Bad performance
Hard filtering
Not SAP standard design
SAP normally does not design UI like this.
----------------------------------------------------------------------------------------------------------------------------------------------


(2).Multiple tabs with same entity on list report page 
--> Scenario 1: Single Table - Segmented View
--> Scenario 2: Multiple Table - Tab View


    



