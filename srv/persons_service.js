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

    function DisplayError(req, errmsg){
        req.error({
            message : errmsg
        })
    }

    const ArrayConversion = (x) => {
        if (Array.isArray(x)){
            return x;
        } else {
            return [x];
        }
    }

    this.on('READ', PersonSet, async(req, next) => {
        return next();
    });

    this.on('READ', EmergencyContacts, async(req, next) => {
        let oQuery = req.query;
        let oContactId = {ref:['Contact_ContactGuid']};

        if (oQuery.SELECT.columns.indexOf(oContactId) < 0){
            oQuery.SELECT.columns.push(oContactId);
        };

        let aResults = await next();

        if (aResults.length > 0){

            //get the contact id's from the data result and fetch them from our external db
            //*note this filter string is a bit diff because we're filtering on a UUID field*/
            let sUrl = "/ContactSet?$filter=(";
            aResults.forEach((element, index, array) => {
                sUrl += "ContactGuid eq guid'" + element.Contact_ContactGuid + "'";

                //if its the last one
                if (index == (aResults.length - 1)){
                    sUrl += ")";
                } else {
                    sUrl += " or ";
                }
            });

            try {
                const contacts = await gwservice.send({
                    method: 'GET',
                    path: sUrl
                });

                //create a mapping object
                let contactsmap = {};
                
                for (const contact of contacts){
                    contactsmap[contact.ContactGuid] = contact;
                }

                for (const result of aResults){
                    result.Contact = contactsmap[result.Contact_ContactGuid]
                }

                return aResults;
            } catch (error) {
                DisplayError(req, error);
            }
        }
    });

    this.on('READ', ItemsLoaned, async(req, next) => {
        //fix up the read here for the items loaned
        //need to take out the category and name columns from the select
    });

    

    
});