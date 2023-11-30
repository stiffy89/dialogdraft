using {sap} from '@sap/cds/common';
using {gwsample} from '../srv/external/gwsample';

namespace persons;

//use contacts and business partner

entity PersonsSet {
    key PersonId : UUID;
        PersonalDetail : Association to PersonalDetail;
        EmergencyContacts : Composition of many EmergencyContacts on EmergencyContacts.MainPerson = $self;
        ItemsLoaned : Composition of many ItemLoaned on ItemsLoaned.MainPerson = $self;
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
        MainPerson : Association to PersonsSet;
        Item : Association to one Product;
        StartDate : Date;
        EndDate : Date;
}

entity EmergencyContacts {
    key EmergencyContactId : cds.UUID;
        MainPerson : Association to PersonsSet;
        PrimaryContact : Boolean;
        Relationship : String (60);
        FirstName : String (60);
        LastName : String (60);
        Email : String (120);
        Mobile : String (20);
}

entity Product as projection on gwsample.ProductSet;