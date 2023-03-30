codeunit 50102 "Transport Post"
{
    procedure PostBooking(var BookingHdr: Record "Booking Header")
    var
        CnfmPost: Label 'Sure to post booking %1 for customer %2?';
        TransportSetup: Record "Transport Setup";
        GenJnlLn: Record "Gen. Journal Line";
        LineNo: Integer;
    begin
        if not Confirm(StrSubstNo(CnfmPost, BookingHdr."No.", BookingHdr."Customer Name"), false) then exit;

        BookingHdr.TestField("Approval Status", BookingHdr."Approval Status"::Approved);
        BookingHdr.CalcFields("Total Amount");
        TransportSetup.Get();
        TransportSetup.TestField("Booking Income Account");
        TransportSetup.TestField("Booking Batch");
        TransportSetup.TestField("Booking Template Name");

        LineNo += 1000;
        GenJnlLn.Init();
        GenJnlLn."Line No." := LineNo;
        GenJnlLn."Journal Template Name" := TransportSetup."Booking Template Name";
        GenJnlLn."Journal Batch Name" := TransportSetup."Booking Batch";
        GenJnlLn."Document No." := BookingHdr."No.";
        GenJnlLn."Posting Date" := BookingHdr."Posting Date";
        GenJnlLn."Account Type" := GenJnlLn."Account Type"::Customer;
        GenJnlLn.Validate("Account No.", BookingHdr."Customer No.");
        GenJnlLn."Document Type" := GenJnlLn."Document Type"::Invoice;
        GenJnlLn.Description := CopyStr('Invoice to Customer ' + BookingHdr."Customer Name", 1, 100);
        GenJnlLn.Validate(Amount, BookingHdr."Total Amount");
        GenJnlLn."Bal. Account Type" := GenJnlLn."Bal. Account Type"::"G/L Account";
        GenJnlLn.Validate("Bal. Account No.", TransportSetup."Booking Income Account");
        if GenJnlLn.Amount <> 0 then begin
            GenJnlLn.Insert();
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJnlLn);
        end;

        BookingHdr.Posted := true;
        BookingHdr."Date Posted" := Today;
        BookingHdr."Time Posted" := Time;
        BookingHdr."Posted By" := UserId;
        BookingHdr.Modify();

        Message('Posted successfully!');


    end;

}
