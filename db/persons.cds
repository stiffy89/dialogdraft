using {sap} from '@sap/cds/common';
using {gwsample} from '../srv/external/gwsample';

namespace persons;

//use contacts and business partner

entity PersonsSet {
    key PersonId : UUID;
        PersonalDetail : Association to one PersonalDetail;
        EmergencyContacts : Association to many EmergencyContacts;
        ItemsLoaned : Association to many ItemLoaned;
}

entity PersonalDetail {
    key PersonalDetId : UUID;
        FirstName : String (60);
        LastName : String (60);
        Email : String (255);
        ContactNumber : String (255);
        Image : LargeString;
}

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