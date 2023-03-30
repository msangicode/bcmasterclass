codeunit 50104 "Booking Codeunit"
{

    procedure BookARoom(roomNo: Integer): Integer
    begin
        exit(roomNo);
    end;

    procedure TheApi(): Text
    begin
        exit('{  "employee": {  "name":       "sonoo",   "salary":      56000,    "married":    true }  }  ');
    end;

}
