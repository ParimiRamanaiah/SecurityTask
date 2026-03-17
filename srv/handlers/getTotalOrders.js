const cds = require('@sap/cds');

async function getTotalOrders(){
    const { SalesOrders } = cds.entities('com.salesorders')
    const result = await SELECT.from(SalesOrders);
    req.info(`Total Orders: ${result.length}`);

    return result.length;
}

module.exports = { getTotalOrders }