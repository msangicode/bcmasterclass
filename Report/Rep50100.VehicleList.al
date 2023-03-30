report 50100 "Vehicle List"
{
    ApplicationArea = All;
    Caption = 'Vehicle List';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = 'ReportLayout/vehiclelist.docx';
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            //DataItemTableView = where("Vehicle Type" = filter(<> ''));
            RequestFilterFields = "No.", "Vehicle Type";
            column(CompanyName; CompInfo.Name) { }
            column(CompanyPic; CompInfo.Picture) { }
            column(No; "No.")
            {
            }
            column(CarryingCapacity; "Carrying Capacity")
            {
            }
            column(Location; Location)
            {
            }
            column(Status; Status)
            {
            }
            column(MaintenanceHistory; "Maintenance History")
            {
            }
            column(CurrentMilleage; "Current Milleage")
            {
            }
            column(Description; Description)
            {
            }
            column(LicensePlateNumber; "License Plate Number")
            {
            }
            column(Filters; Filters)
            {

            }

            trigger OnPreDataItem()
            begin
                Filters := FixedAsset.GetFilters;
            end;
        }
    }

    trigger OnPreReport()
    begin

        // Init => request => onpre => onpredataitem (add filter via code) => onaftergetrecord  => onpostdataitem => onpost report

        CompInfo.Get;
        CompInfo.CalcFields(Picture);

    end;

    var

        CompInfo: Record "Company Information";
        Filters: Text;
}
