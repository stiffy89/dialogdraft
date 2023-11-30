using persons from '../db/persons';

service personsservice {
    entity PersonSet as select from persons.PersonsSet {
        PersonId,
        PersonalDetail,
        EmergencyContacts,
        ItemsLoaned
    };

    entity PersonalDetail as select from persons.PersonalDetail {
        PersonalDetId,
        FirstName,
        LastName,
        Email,
        ContactNumber,
        Image
    };

    //add core.computed because we dont want the fields to be inline edit, it will be via a custom dialog
    entity ItemLoaned as select from persons.ItemLoaned {
        ItemLoanedId,
        MainPerson @Core.Computed,
        Item @Core.Computed,
        StartDate @Core.Computed,
        EndDate @Core.Computed
    };

    entity EmergencyContacts as select from persons.EmergencyContacts{
        EmergencyContactId,
        MainPerson @Core.Computed,
        PrimaryContact @Core.Computed,
        Relationship @Core.Computed,
        FirstName @Core.Computed,
        LastName @Core.Computed,
        Email @Core.Computed,
        Mobile @Core.Computed
    };

    entity Product as select from persons.Product {
        ProductID @Core.Computed,
        Category @Core.Computed,
        Name @Core.Computed
    }
}