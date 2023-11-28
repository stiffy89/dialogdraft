const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () { 
    let srv = this;
    
    const {
        PersonSet,
        People,
        EmergencyContacts,
        ItemsLoaned
    } = srv.entities;

    const gwservice = await cds.connect.to('gwsample');

    this.on('READ', PersonSet, async(req, next) => {
        return next();
    });

    

    
});