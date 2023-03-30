codeunit 50100 "Event Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Fixed Asset", 'OnBeforeInitFANo', '', false, false)]
    local procedure UpdateVehicleNoSeriesOnBeforeInitFANo(var FixedAsset: Record "Fixed Asset"; xFixedAsset: Record "Fixed Asset"; var IsHandled: Boolean)
    begin
        if FixedAsset."Vehicle Type" = FixedAsset."Vehicle Type"::Truck then begin

        end;
    end;

}