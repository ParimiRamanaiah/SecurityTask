const cds = require('@sap/cds');
const { approveOrder, rejectOrder, confirmOrder } = require('./handlers/approveOrder')
const { getTotalOrders } = require('./handlers/getTotalOrders');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');


module.exports = cds.service.impl(async function () {
  const { SalesOrders, FeatureControl } = cds.entities('com.salesorders');

  //const salesAndItems = await SELECT.from(SalesOrders).expand('items'); //.expand() is not a valid CAP Query API method.

  //In CAP you must use .columns() with expand, not .expand() directly.
  /*Use columns with lambda function because:
    Better performance
    Clear structure
    Allows nested expand
    Industry standard CAP pattern*/
  const salesAndItems = await SELECT.from(SalesOrders).columns(s => {
    s('*'),
      s.items(i => {
        i('*');
      })
  })
  //console.log("salesAndItems", salesAndItems);
  //console.log(JSON.stringify(salesAndItems, null, 2));

  //Expand with columns
  const salesOrdersAndItems = await SELECT.from(SalesOrders).columns([
    '*',
    {ref: ['items'], expand:['*']}
  ])
  //console.log("salesOrdersAndItems",salesOrdersAndItems);
  //console.log("salesOrdersAndItemsStructure", JSON.stringify(salesOrdersAndItems,null,2));

  const salesAndItemsCustomers = await SELECT.from(SalesOrders).columns(so=>{
    so('*'),
    so.items(i=>{
      i('*')
    }),
    so.customer(c=>{
      c('*')
    })
  })
  //console.log("salesAndItemsCustomers",salesAndItemsCustomers);
  //console.log("salesAndItemsCustomersStructure",JSON.stringify(salesAndItemsCustomers,null,2));

  const salesAndItemsAndCustomers = await SELECT.from(SalesOrders).columns([
    '*',
    {ref: ['items'], expand:['*']},
    {ref: ['customer'], expand:['*']}
  ])
  //console.log("salesAndItemsAndCustomers",salesAndItemsAndCustomers);
  //console.log("salesAndItemsAndCustomersStructure",JSON.stringify(salesAndItemsAndCustomers,null,2));

  const sics = await SELECT.from(SalesOrders).columns(so=>{
    so.ID,so.orderNumber,so.statusText,so.priorityText,
    so.items(i=>{
      i.itemNumber, i.netAmount
    }),
    so.customer(c=>{
      c.name, c.city
    })
  })
  //console.log("sics",JSON.stringify(sics,null,2));

  const filteredData = await SELECT.from(SalesOrders).columns(so=>{
    so('*'),
    so.items(i=>{
      i('*')
    }),
    so.customer(c=>{
      c('*')
    })
  }
  ).where({statusText : 'Confirmed'});

  //console.log("filteredData",JSON.stringify(filteredData,null,2));
  //console.log("filteredData",filteredData.length);



  this.on('approveOrder', async (req) => {
    //console.log(req.data);
    await approveOrder(req);
  });

  this.on('getTotalOrders', async (req) => {
    await getTotalOrders(req);
  });

  this.on('reject',async(req)=>{
    await rejectOrder(req)
  })

  this.on('confirm',async(req)=>{
    console.log("req",req);
    await confirmOrder(req);
  })

  // this.after('READ','SalesOrders',(each,req)=>{
  //   // console.log("hello");
  //   // console.log(req.user);
  //   each.isSalesUser = 'true';//req.user.is('SalesUser');
  //   // console.log(each.isSalesUser);
  // })

  this.on('normalAction', async(req)=>{
    //console.log(req.user);
    if(!req.user.is('SalesUser')){
      req.reject(403,'You are not the concerned person to do this. Please contact admin!!');
    }
  })

  this.on('READ','FeatureControl',async(req)=>{
    let operationHidden  = false;
    if(req.user.is('Admin')){
      operationHidden  = true;
    }

    return{
      operationHidden :operationHidden ,
      operationEnabled:!operationHidden 
    }
  })

})