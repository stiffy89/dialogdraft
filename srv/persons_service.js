const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () { 
    let srv = this;
    
    const {
        PersonSet,
        People,
        EmergencyContacts,
        ItemsLoaned
    } = srv.entites;

    const gwservice = await cds.connect.to('gwsample');

    
});