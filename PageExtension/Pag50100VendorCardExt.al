pageextension 50100 VendorCardExt extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("VAT Registration No.")
        {
            field("Tax Pin"; Rec."Tax Pin")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(PayVendor)
        {
            action("Populate the tax pin")
            {
                ApplicationArea = All;
                Image = TaxSetup;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec."Tax Pin" := COPYSTR('A003023' + Rec."No.", 1, 10);
                    Rec.Modify();
                    Message('Updated');
                end;
            }
        }
    }

    var
        myInt: Integer;
}