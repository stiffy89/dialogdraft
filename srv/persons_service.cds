using persons from '../db/persons';

service personsservice {
    entity PersonSet as select from persons.PersonsSet {
        PersonId,
        People,
        EmergencyContacts,
        ItemsLoaned
    };

    entity People as projection on persons.People;

    entity ItemLoaned as projection on persons.ItemLoaned;

    entity EmergencyContacts as projection on persons.EmergencyContacts;

}