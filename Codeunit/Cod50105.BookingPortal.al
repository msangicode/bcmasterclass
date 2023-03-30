codeunit 50105 "Booking Portal"
{
    procedure GetBookingAmount(BookingNo: Code[20]) BoookingAmount: Decimal
    var
        BookingHdr: Record "Booking Header";
        BookingLn: Record "Booking Line";
    begin

        if BookingHdr.Get(BookingNo) then begin
            BookingHdr.CalcFields("Total Amount");
            BoookingAmount := BookingHdr."Total Amount";
        end;
    end;

}
