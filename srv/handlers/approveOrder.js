const cds = require('@sap/cds');

async function approveOrder() {
    const { SalesOrders } = cds.entities('com.salesorders')

    if (!req.user.is('Admin')) {
        req.reject(403, 'You are not authorized to approve orders');
    }

    const { ID } = req.data;

    await UPDATE(SalesOrders)
        .set({ status: 'A', statusText: 'Approved' })
        .where({ ID });

    return "Approved";
}

module.exports = { approveOrder }