const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () { 
    let srv = this;
    
    const {
        PersonSet,
        People,
        EmergencyContacts,
        ItemLoaned
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
        return next();
    });

    this.on('READ', ItemLoaned.drafts, async(req, next) => {
        if (!req.query.SELECT.columns){
            return next();
        }

        if (req.query.SELECT.columns.indexOf({ref: ['Item_ProductID']}) < 0){
            req.query.SELECT.columns.push({ref: ['Item_ProductID']});
        }

        let persistenceItemsLoaned = await next();
        persistenceItemsLoaned = ArrayConversion(persistenceItemsLoaned);
        
        //check to see if we have the items loaned already cached
        if (srv.ItemsLoaned){
            //now check to see if we are looking for the same items loaned
            let bSameItemsLoaned = persistenceItemsLoaned.every((x) => {
                if (srv.ItemsLoaned[x.Item_ProductID]){
                    return true;
                } else {
                    return false;
                }
            });

            if (bSameItemsLoaned){
                for (var ii of persistenceItemsLoaned){
                    ii.Item = srv.ItemsLoaned[ii.Item_ProductID];
                    ii.ItemCategory = ii.Item.Category;
                    ii.ItemName = ii.Item.Name;
                }

                if (!persistenceItemsLoaned['$count']){
                    persistenceItemsLoaned['$count'] = persistenceItemsLoaned.length;
                };

                return persistenceItemsLoaned;
            }
        }

        return persistenceItemsLoaned;
    })

    this.on('READ', ItemLoaned, async(req, next) => {

        if (!req.query.SELECT.columns){
            return next();
        }

        req.query.SELECT.columns.forEach (({ref}, index) => {
            if (ref[0] === 'ItemCategory' || ref[0] === 'ItemName'){
                //if we find either, just remove it
                req.query.SELECT.columns.splice(index, 1);
            }
        })

         //make sure we add the Item_ProductID 
        if (req.query.SELECT.columns.indexOf({ref: ['Item_ProductID']}) < 0){
            req.query.SELECT.columns.push({ref: ['Item_ProductID']});
        }

        let persistenceItemsLoaned = await next();
        persistenceItemsLoaned = ArrayConversion(persistenceItemsLoaned);

        //check to see if we have the external items loaned cached, so we're not reading this everytime
        if (srv.ItemsLoaned){
            //now check to see if we are looking for the same items loaned
            let bSameItemsLoaned = persistenceItemsLoaned.every((x) => {
                if (srv.ItemsLoaned[x.Item_ProductID]){
                    return true;
                } else {
                    return false;
                }
            });

            if (bSameItemsLoaned){
                for (var ii of persistenceItemsLoaned){
                    ii.Item = srv.ItemsLoaned[ii.Item_ProductID];
                    ii.ItemCategory = ii.Item.Category;
                    ii.ItemName = ii.Item.Name;
                }

                if (!persistenceItemsLoaned['$count']){
                    persistenceItemsLoaned['$count'] = persistenceItemsLoaned.length;
                };

                return persistenceItemsLoaned;
            }
        }

        //build filter string
        let sUrl = "/ProductSet?$filter=";

        persistenceItemsLoaned.forEach((element, index, array) => {
            sUrl += ("ProductID eq '" + element.Item_ProductID + "'");
            if (index < array.length - 1){
                sUrl += " or ";
            }
        });

        try {
            let externalItemsLoaned = await gwservice.send({
                method: 'GET',
                path: sUrl
            });

            if (externalItemsLoaned.length == 0){
                DisplayError(req, "Loaned Items external service error");
            }

            let itemMap = {};

            for (var i of externalItemsLoaned){
                itemMap[i.ProductID] = i;
            }

            srv.ItemsLoaned = itemMap;

            for (var ii of persistenceItemsLoaned){
                ii.Item = itemMap[ii.Item_ProductID];
                ii.ItemCategory = ii.Item.Category;
                ii.ItemName = ii.Item.Name;
            }
        } catch (error){
            //DisplayError(req, error);
        }

        //just make sure we have the $count otherwise our table wont populate
        if (!persistenceItemsLoaned['$count']){
            persistenceItemsLoaned['$count'] = persistenceItemsLoaned.length;
        };

        return persistenceItemsLoaned;
    });
    
    

    
});