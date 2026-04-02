using {com.salesorders as db} from '../db/schema';

@requires: [
  'SalesUser',
  'Admin'
]
service SalesService @(path: '/odata/v4/sales') {

  entity FeatureControl as projection on db.FeatureControl;
  @restrict: [
    {
      grant: 'READ',
      to   : 'SalesUser',
      where: 'createdBy = $user'
    },
    {
      grant: 'CREATE',
      to   : 'SalesUser'
    },
    {
      grant: '*',
      to   : 'Admin'
    },
    {
      grant: 'UPDATE',
      to   : 'SalesUser',
      where: 'country = $user.attr.country'
    },
  ]
  entity SalesOrders     as projection on db.SalesOrders
  actions{
    action confirm() returns SalesOrders @restrict: [{
    grant: 'EXECUTE',
    to   : 'Admin'
  }];
  };

  @restrict: [
    {
      grant: [
        'READ',
        'CREATE'
      ],
      to   : 'SalesUser'
    },
    {
      grant: '*',
      to   : 'Admin'
    }
  ]
  entity SalesOrderItems as projection on db.SalesOrderItems;

  // ACTION
  // @requires: ['SalesUser']
  action   approveOrder(ID: Integer) returns String @restrict: [{
    grant: 'EXECUTE',
    to   : 'Admin'
  }];

  // FUNCTION
  function getTotalOrders()          returns Integer @restrict: [{
    grant: 'EXECUTE',
    to   : [
      'SalesUser',
      'Admin'
    ]
  }];

  @requires:['Admin']
  action normalAction() returns String;

  action reject(ID: Integer) returns String @restrict: [{
    grant: 'EXECUTE',
    to   : 'Admin'
  }];

}

@requires: [
  'MasterDataUser',
  'Admin'
]
service MasterDataService @(path: '/odata/v4/master') {

  @restrict: [
    {
      grant: ['READ'],
      to   : 'MasterDataUser'
    },
    {
      grant: '*',
      to   : 'Admin'
    }
  ]
  entity Customers as projection on db.Customers;

  @restrict: [
    {
      grant: ['READ'],
      to   : 'MasterDataUser'
    },
    {
      grant: '*',
      to   : 'Admin'
    }
  ]
  entity Products  as projection on db.Products;

}
