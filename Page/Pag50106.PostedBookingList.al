page 50106 "Posted Booking List"
{
    ApplicationArea = All;
    Caption = 'Posted Booking List';
    PageType = List;
    SourceTable = "Booking Header";
    UsageCategory = History;
    CardPageId = "Booking Header";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Booking No. field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Booking Status"; Rec."Booking Status")
                {
                    ToolTip = 'Specifies the value of the Booking Status field.';
                }
                field("Driver ID"; Rec."Driver ID")
                {
                    ToolTip = 'Specifies the value of the Driver ID field.';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                }
            }
        }
    }
}
