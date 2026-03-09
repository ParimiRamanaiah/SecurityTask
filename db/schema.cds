namespace com.salesorders;

using { managed, Currency } from '@sap/cds/common';

entity Customers : managed {
  key ID         : Integer;
  customerNumber : String(10);
  name           : String(100);
  country        : String(3);
  city           : String(50);
}

entity Products : managed {
  key ID         : Integer;
  productCode : String(20);
  description : String(200);
  category    : String(50);
  price       : Decimal(13,2);
  currency    : Currency;
}

entity SalesOrders : managed {
  key ID         : Integer;
  orderNumber  : String(15);
  customer     : Association to Customers;
  orderDate    : Date;
  deliveryDate : Date;
  netAmount    : Decimal(13,2);
  taxAmount    : Decimal(13,2);
  totalAmount  : Decimal(13,2);
  currency     : Currency;
  status       : String(1);
  statusText   : String(20);
  priority     : String(1);
  priorityText : String(10);
  criticality  : Integer;
  items        : Composition of many SalesOrderItems on items.order = $self;
}

entity SalesOrderItems {
  key ID         : Integer;
  order      : Association to SalesOrders;
  itemNumber : Integer;
  product    : Association to Products;
  quantity   : Integer;
  unitPrice  : Decimal(13,2);
  netAmount  : Decimal(13,2);
  currency   : Currency;
}
