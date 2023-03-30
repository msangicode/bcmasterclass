table 50100 "Booking Header"
{
    Caption = 'Booking Header';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Booking List";
    LookupPageId = "Booking List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Booking No.';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin

                if "No." <> xRec."No." then begin
                    TransportSetup.Get();
                    NoSeriesMgt.TestManual(TransportSetup."Booking Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                if xRec."Customer No." <> "Customer No." then begin
                    Cust.Get("Customer No.");
                    "Customer Name" := Cust.Name;
                    "Customer Phone Number" := Cust."Phone No.";
                end;

            end;
        }
        field(3; "Customer Name"; Text[150])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Customer Phone Number"; Code[15])
        {
            Caption = 'Customer Phone Number';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                if FA.Get("Vehicle No.") then begin
                    "Vehicle Description" := FA.Description;
                end;
            end;
        }
        field(7; "Vehicle Description"; Text[100])
        {
            Caption = 'Vehicle Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Driver ID"; Code[20])
        {
            Caption = 'Driver ID';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                Employee.Get("Driver ID");
                "Driver Name" := Employee.FullName();
            end;
        }
        field(9; "Approval Status"; Enum "Custom Approval Enum")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                if "Approval Status" = "Approval Status"::Approved then begin
                    "Approved By" := UserId;
                    "DateTime Approved" := CurrentDateTime;
                end;
            end;
        }
        field(10; "Booking Status"; Enum "Booking Status Enum")
        {
            Caption = 'Booking Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; Posted; Boolean)
        {
            Editable = false;
        }
        field(12; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(13; "Time Posted"; Time)
        {
            Editable = false;

        }
        field(14; "Document Type"; Enum "Sales Document Type")
        {

        }
        field(15; "Document No."; Code[20])
        {

        }
        field(16; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(17; "Driver Name"; Text[100])
        {
            Editable = false;
        }
        field(18; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "DateTime Approved"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(21; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Booking Line".Amount where("Document No." = field("No.")));
            Editable = false;
        }
        field(22; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            TransportSetup.Get();
            TransportSetup.TestField("Booking Nos.");
            NoSeriesMgt.InitSeries(TransportSetup."Booking Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    procedure ValidatePreApproval()
    var
        BookingLn: Record "Booking Line";
        NoLinesError: Label 'Please enter at least one entry in the booking line table!';
        BookingLineExits: Boolean;
    begin

        Rec.TestField("Customer No.");
        Rec.TestField("Posting Date");
        Rec.TestField("Approval Status", Rec."Approval Status"::Open);
        Rec.TestField("Vehicle No.");
        BookingLn.Reset();
        BookingLn.SetRange("Document No.", "No.");
        BookingLineExits := BookingLn.FindSet();


        if BookingLineExits then begin
            repeat
                BookingLn.TestField("Pickup Address");
                BookingLn.TestField("Pickup Address Weather");
                BookingLn.TestField("Delivery Address");
                BookingLn.TestField("Delivery Address Weather");
                BookingLn.TestField(Amount);
                BookingLn.TestField("Pickup Date");
            until BookingLn.Next() = 0;

        end else
            Error(NoLinesError);


    end;

    var
        TransportSetup: Record "Transport Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
