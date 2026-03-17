const cds = require('@sap/cds');
const { approveOrder } = require('./handlers/approveOrder')
const { getTotalOrders } = require('./handlers/getTotalOrders')

module.exports = cds.service.impl(async function () {

  this.on('approveOrder', async (req) => {
    await approveOrder();
  });

  this.on('getTotalOrders', async (req) => {
    await getTotalOrders();
  });

})