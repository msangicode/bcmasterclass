report 50101 "Booking Report"
{
    ApplicationArea = All;
    Caption = 'Booking Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout/bookingreport.rdlc';
    dataset
    {
        dataitem(BookingHeader; "Booking Header")
        {
            column(No; "No.")
            {
            }
            column(CompanyName; CompInfo.Name) { }
            column(CompanyPic; CompInfo.Picture) { }
            column(Filters; Filters) { }
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(CustomerPhoneNumber; "Customer Phone Number")
            {
            }
            column(DriverID; "Driver ID")
            {
            }
            column(DriverName; "Driver Name")
            {
            }
            column(VehicleNo; "Vehicle No.")
            {
            }
            column(VehicleDescription; "Vehicle Description")
            {
            }
            column(TotalAmount; "Total Amount")
            {
            }
            column(BookingStatus; "Booking Status")
            {
            }
            column(DatePosted; "Date Posted")
            {
            }
            dataitem("Booking Line"; "Booking Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(PickupDate_BookingLine; "Pickup Date")
                {
                }
                column(Amount_BookingLine; Amount)
                {
                }
                column(CargoType_BookingLine; "Cargo Type")
                {
                }
                column(CargoWeight_BookingLine; "Cargo Weight")
                {
                }
                column(DeliveryAddress_BookingLine; "Delivery Address")
                {
                }
                column(DocumentNo_BookingLine; "Document No.")
                {
                }
                column(PickupAddress_BookingLine; "Pickup Address")
                {
                }
            }
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



reportextension 50100 "Vendor List Report Extension" extends "Vendor - List"
{
    dataset
    {
        // Add changes to dataitems and columns here
        add(Vendor)
        {
            column(Tax_Pin; "Tax Pin")
            {
            }
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'ReportLayout/vendorreport.rdlc';
        }
    }
}
