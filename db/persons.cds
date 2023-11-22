using {sap} from '@sap/cds/common';
using {gwsample} from '../srv/external/gwsample';
using {z_crud_test_srv} from '../srv/external/z_crud_test_srv';

namespace persons;

entity PersonsSet {
    key PersonId : UUID;
        People : Association to one People;
        EmergencyContacts : Association to many EmergencyContacts;
        ItemsLoaned : Association to many ItemLoaned;
}

entity People as projection on z_crud_test_srv.People;

entity ItemLoaned {
    key ItemLoanedId : UUID;
        Item : Association to one gwsample.ProductSet;
        StartDate : Date;
        EndDate : Date;
}

entity EmergencyContacts {
    key EmergencyContactId : cds.UUID;
        Contact : Association to one gwsample.ContactSet;
        PrimaryContact : Boolean;
        Relationship : String (60);
}