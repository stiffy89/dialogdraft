sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/ComboBox"
], function(MessageToast) {
    'use strict';

    return {
        editItemsOnLoan: function(oContext, aSelectedContexts) {
            if (aSelectedContexts.length == 0){
                MessageToast.show('Please select an item to edit')
            }
            else {
                //get our odata v4 instance from context and bind the combobox
    
                let oComboBox = new sap.m.ComboBox({
                    id: 'DialogComboBox'
                });

                

                let oVBox = new sap.m.VBox({
                    items:[
                        oComboBox
                    ]
                }).addStyleClass('itemsOnLoanDialogContainer');

                let oDialog = new sap.m.Dialog({
                    content:[
                        oVBox
                    ],
                    buttons:[
                        new sap.m.Button({
                            text: "Close",
                            press: function(){
                                oDialog.close();
                            }
                        })
                    ],
                    afterClose: function (){
                        oDialog.close();
                    }
                }).addStyleClass('itemsOnLoanDialog');

                oDialog.open();
            }
        },
        createItemsOnLoan: function (oEvent) {
            
        },
        editEmergencyContact: function (oEvent) {

        },
        createEmergencyContact: function (oEvent) {

        },
        onDialogShow: function () {
            //this will create the dialog and show it
        }
    };
});
