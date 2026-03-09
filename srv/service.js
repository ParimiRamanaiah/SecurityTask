const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { SalesOrders } = this.entities;

  // ACTION
  this.on('approveOrder', async (req) => {
    const { SalesOrders } = cds.entities('com.salesorders')

    if (!req.user.is('Admin')) {
      req.reject(403, 'You are not authorized to approve orders');
    }

    const { ID } = req.data;

    await UPDATE(SalesOrders)
      .set({ status: 'A', statusText: 'Approved' })
      .where({ ID });

    return "Order Approved Successfully";
  });


  // FUNCTION
  this.on('getTotalOrders', async (req) => {
    console.log("inside gettotal");
 const { SalesOrders } = cds.entities('com.salesorders')
    const result = await SELECT.from(SalesOrders);
    req.info(`Total Orders: ${result.length}`);
    console.log("length",result.length);

    return result.length;

  });

})