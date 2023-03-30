tableextension 50101 "Fixed Asset Table Extension" extends "Fixed Asset"
{
    fields
    {
        field(50100; "Vehicle Type"; Enum "Vehicle Type")
        {
            Caption = 'Vehicle Type';
            DataClassification = ToBeClassified;
        }
        field(50101; "Carrying Capacity"; Decimal)
        {
            Caption = 'Carrying Capacity';
            DataClassification = ToBeClassified;
        }
        field(50102; Location; Code[20])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
        }
        field(50103; Status; Enum "Approval Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(50104; "Maintenance History"; Text[250])
        {
            Caption = 'Maintenance History';
            DataClassification = ToBeClassified;
        }
        field(50105; "License Plate Number"; Code[8])
        {
            Caption = 'License Plate Number';
            DataClassification = ToBeClassified;
        }
        field(50106; Model; Code[20])
        {
            Caption = 'Model';
            DataClassification = ToBeClassified;
        }
        field(50107; Make; Code[20])
        {
            Caption = 'Make';
            DataClassification = ToBeClassified;
        }
        field(50108; Weight; Decimal)
        {
            Caption = 'Weight';
            DataClassification = ToBeClassified;
        }
        field(50109; Height; Decimal)
        {
            Caption = 'Height';
            DataClassification = ToBeClassified;
        }
        field(50110; Color; Text[10])
        {
            Caption = 'Color';
            DataClassification = ToBeClassified;
        }
        field(50111; "No of Wheels"; Integer)
        {
            Caption = 'No of Wheels';
            DataClassification = ToBeClassified;
        }
        field(50112; "Initial Milleage"; Integer)
        {
            Caption = 'Initial Milleage';
            DataClassification = ToBeClassified;
        }
        field(50113; "Current Milleage"; Integer)
        {
            Caption = 'Current Milleage';
            DataClassification = ToBeClassified;
        }
        field(50114; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
    }


}
