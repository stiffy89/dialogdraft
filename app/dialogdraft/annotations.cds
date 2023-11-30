using personsservice as service from '../../srv/persons_service';

//enable the editing for these two services
annotate service.PersonSet with @odata.draft.enabled;
annotate service.PersonalDetail with @odata.draft.enabled;

//hide the default create buttons for the table entities, we are going to use custom ones
annotate service.EmergencyContacts with @(
    UI.CreateHidden : true
);

annotate service.ItemLoaned with @(
    UI.CreateHidden : true
);

annotate service.PersonSet with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PersonalDetail.FirstName,
            Label : 'FirstName',
        },
        {
            $Type : 'UI.DataField',
            Value : PersonalDetail.LastName,
            Label : 'LastName',
        },
    ]
);
annotate service.PersonSet with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Personal Details',
            ID : 'PersonalDetails',
            Target : '@UI.FieldGroup#PersonalDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Emergency Contacts',
            ID : 'EmergencyContacts',
            Target : 'EmergencyContacts/@UI.LineItem#EmergencyContacts',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items on loan',
            ID : 'Itemsonloan',
            Target : 'ItemsLoaned/@UI.LineItem#Itemsonloan',
        }
    ]
);


annotate service.EmergencyContacts with @(
    UI.LineItem #EmergencyContacts : [
        {
            $Type : 'UI.DataField',
            Value : FirstName,
            Label : 'First Name',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : LastName,
            Label : 'Last Name',
        },
        {
            $Type : 'UI.DataField',
            Value : Email,
            Label : 'Email',
        },
        {
            $Type : 'UI.DataField',
            Value : Mobile,
            Label : 'Mobile',
            ![@UI.Importance] : #High,
        },  
        {
            $Type : 'UI.DataField',
            Value : PrimaryContact,
            Label : 'Primary Contact',
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : Relationship,
            Label : 'Relationship',
            ![@UI.Importance] : #Low
        } 
    ]
);

annotate service.PersonSet with @(
    UI.FieldGroup #PersonalDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PersonalDetail.ContactNumber,
                Label : 'ContactNumber',
            },{
                $Type : 'UI.DataField',
                Value : PersonalDetail.Email,
                Label : 'Email',
            },{
                $Type : 'UI.DataField',
                Value : PersonalDetail.FirstName,
                Label : 'FirstName',
            },{
                $Type : 'UI.DataField',
                Value : PersonalDetail.LastName,
                Label : 'LastName',
            },],
    }
);
annotate service.ItemLoaned with @(
    UI.LineItem #Itemsonloan : [
        {
            $Type : 'UI.DataField',
            Value : StartDate,
            Label : 'StartDate',
        },
        {
            $Type : 'UI.DataField',
            Value : EndDate,
            Label : 'EndDate',
        },
        {
            $Type : 'UI.DataField',
            Value : Item.Category,
            Label : 'Category',
        },
        {
            $Type : 'UI.DataField',
            Value : Item.Name,
            Label : 'Name',
        },
        {
            $Type : 'UI.DataField',
            Value : Item.ProductID,
            Label : 'ProductID',
        }]
);
