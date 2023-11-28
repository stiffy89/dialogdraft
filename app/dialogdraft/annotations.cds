using personsservice as service from '../../srv/persons_service';

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
            Value : Contact.FirstName,
            Label : 'First Name',
        }, 
        {
            $Type : 'UI.DataField',
            Value : Contact.LastName,
            Label : 'First Name',
        }, 
        {
            $Type : 'UI.DataField',
            Value : Contact.PhoneNumber,
            Label : 'Phone number',
        },
        {
            $Type : 'UI.DataField',
            Value : PrimaryContact,
            Label : 'PrimaryContact',
        },
        {
            $Type : 'UI.DataField',
            Value : Relationship,
            Label : 'Relationship',
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
            Value : Item.Name,
            Label : 'Item name',
        },
        {
            $Type : 'UI.DataField',
            Value : Item.Category,
            Label : 'Category',
        },
        {
            $Type : 'UI.DataField',
            Value : StartDate,
            Label : 'StartDate',
        },
        {
            $Type : 'UI.DataField',
            Value : EndDate,
            Label : 'EndDate',
        } 
    ]
);
