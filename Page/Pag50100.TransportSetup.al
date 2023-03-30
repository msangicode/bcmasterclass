page 50100 "Transport Setup"
{
    ApplicationArea = Administration;
    Caption = 'Transport Setup';
    PageType = Card;
    SourceTable = "Transport Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Booking Nos."; Rec."Booking Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Vehicle Nos."; Rec."Vehicle Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Booking Income Account"; Rec."Booking Income Account")
                {
                    ApplicationArea = Basic;
                }
                field("Booking Template Name"; Rec."Booking Template Name")
                {
                    ApplicationArea = Basic;
                }
                field("Booking Batch"; Rec."Booking Batch")
                {
                    ToolTip = 'Specifies the value of the Booking Batch field.';
                    ApplicationArea = Basic;
                }


            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}






