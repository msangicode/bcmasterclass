page 50104 "Vehicle Card"
{
    ApplicationArea = All;
    Caption = 'Vehicle Card';
    PageType = Card;
    SourceTable = "Fixed Asset";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the fixed asset.';
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                    ToolTip = 'Specifies the value of the Vehicle Type field.';
                }
                field("No of Wheels"; Rec."No of Wheels")
                {
                    ToolTip = 'Specifies the value of the No of Wheels field.';
                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ToolTip = 'Specifies the next scheduled service date for the fixed asset. This is used as a filter in the Maintenance - Next Service report.';
                }
                field("Initial Milleage"; Rec."Initial Milleage")
                {
                    ToolTip = 'Specifies the value of the Initial Milleage field.';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Vehicle Type" := Rec."Vehicle Type"::Trailer;
    end;
}
