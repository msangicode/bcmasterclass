page 50103 "Booking Line"
{
    ApplicationArea = All;
    Caption = 'Booking Line';
    PageType = ListPart;
    SourceTable = "Booking Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Pickup Address"; Rec."Pickup Address")
                {
                    ToolTip = 'Specifies the value of the Pickup Address field.';
                }
                field("Source Address Weather"; Rec."Pickup Address Weather")
                {

                }
                field("Pickup Date"; Rec."Pickup Date")
                {
                    ToolTip = 'Specifies the value of the Pickup Date field.';
                }
                field("Delivery Address"; Rec."Delivery Address")
                {
                    ToolTip = 'Specifies the value of the Delivery Address field.';
                }
                field("Destination Address Weather"; Rec."Delivery Address Weather")
                {

                }
                field("Cargo Type"; Rec."Cargo Type")
                {
                    ToolTip = 'Specifies the value of the Cargo Type field.';
                }
                field("Cargo Weight"; Rec."Cargo Weight")
                {
                    ToolTip = 'Specifies the value of the Cargo Weight field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }


            }
        }
    }
}
