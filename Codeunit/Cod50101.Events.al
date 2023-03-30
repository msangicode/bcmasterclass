codeunit 50101 Events
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostInvoice', '', true, true)]
    local procedure ValidateTheCustomerOnBeforePostInvoice()
    begin
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', true, true)]
    local procedure MessageOutTheLineNoOnBeforePostGenJnlLine()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforePostSalesLine', '', false, false)]
    local procedure TestSomethingOnPostSalesLineOnBeforePostSalesLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean)
    begin
        Message(SalesHeader."No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Fixed Asset", 'OnBeforeInitFANo', '', false, false)]
    local procedure SetVehicleNoSeriesOnBeforeInitFANo(var FixedAsset: Record "Fixed Asset"; xFixedAsset: Record "Fixed Asset"; var IsHandled: Boolean)
    var
        TransportSetup: Record "Transport Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if FixedAsset."Vehicle Type" <> FixedAsset."Vehicle Type"::" " then begin
            if FixedAsset."No." = '' then begin
                TransportSetup.Get();
                TransportSetup.TestField("Vehicle Nos.");
                NoSeriesMgt.InitSeries(TransportSetup."Vehicle Nos.", xFixedAsset."No. Series", 0D, FixedAsset."No.",
                 FixedAsset."No. Series");
            end;
            IsHandled := true;
        end;
    end;

}

