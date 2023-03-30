table 50102 "Transport Setup"
{
    Caption = 'Transport Setup';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Transport Setup";
    LookupPageId = "Transport Setup";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Booking Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Vehicle Nos."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(4; "Booking Income Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(5; "Booking Template Name"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(6; "Booking Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Booking Template Name"));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
