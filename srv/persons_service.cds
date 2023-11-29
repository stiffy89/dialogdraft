using persons from '../db/persons';

service personsservice {
    entity PersonSet as select from persons.PersonsSet {
        PersonId,
        PersonalDetail,
        EmergencyContacts,
        ItemsLoaned
    };


    entity People as projection on persons.PersonalDetail;

    entity ItemLoaned as select from persons.ItemLoaned {
        ItemLoanedId,
        MainPerson,
        Item.Category as ItemCategory,
        Item.Name as ItemName,
        Item,
        StartDate,
        EndDate
    };

    entity EmergencyContacts as projection on persons.EmergencyContacts;

}