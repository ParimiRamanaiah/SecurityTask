const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

async function getTotalOrders(req){
    const { SalesOrders } = cds.entities('com.salesorders')
    // const result = await SELECT.from(SalesOrders);
    //const result = await SELECT.from(SalesOrders).count(); //not working --> wrong syntax
    const result= await SELECT.from(SalesOrders).columns('count(*) as count');
    console.log(result[0].count);
    // req.info(`Total Orders: ${result.length}`);
    req.info(`Total Orders: ${result[0].count}`);
    return result[0].count;
}

module.exports = { getTotalOrders }