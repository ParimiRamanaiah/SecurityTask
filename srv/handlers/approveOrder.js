const cds = require('@sap/cds');

async function approveOrder(req) {
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

async function rejectOrder(req) {
    const { SalesOrders } = cds.entities('com.salesorders')

    if (!req.user.is('Admin')) {
        req.reject(403, 'You are not authorized to reject orders');
    }

    const { ID } = req.data;

    await UPDATE(SalesOrders)
        .set({ status: 'R', statusText: 'Rejected' })
        .where({ ID });

    return "Rejected";
}

async function confirmOrder(req) {
    const { SalesOrders } = cds.entities('com.salesorders')

    if (!req.user.is('Admin')) {
        req.reject(403, 'You are not authorized to reject orders');
    }

    const { ID } = req.params[0];
    console.log("ID",ID);

    await UPDATE(SalesOrders)
        .set({ status: 'C', statusText: 'Confirmed' })
        .where({ ID });

    return "Confirmed";
}


module.exports = { approveOrder, rejectOrder, confirmOrder }