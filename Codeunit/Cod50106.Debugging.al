codeunit 50106 Debugging
{

    trigger OnRun()
    var
        BookingHdr: Record "Booking Header";
        myCode: Code[20];
    begin
        BookingHdr.Reset();
        if BookingHdr.FindFirst() then
            repeat
                // do something
                myCode := BookingHdr."No.";
            until BookingHdr.Next() = 0;

        // 20 records = 20 queries

        BookingHdr.Reset();
        if BookingHdr.FindSet() then
            repeat
                // do something
                myCode := BookingHdr."No.";

            // 1 query;

            until BookingHdr.Next() = 0;

    end;
}

