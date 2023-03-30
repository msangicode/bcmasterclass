table 50101 "Booking Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {

        }
        field(3; "Pickup Address"; Text[100])
        {
            Caption = 'Pickup Address';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Pickup Address Weather" := WeatherAPI.GetCurrentWeatherInfo("Pickup Address");
            end;
        }
        field(4; "Delivery Address"; Text[100])
        {
            Caption = 'Delivery Address';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Delivery Address Weather" := WeatherAPI.GetCurrentWeatherInfo("Delivery Address");
            end;
        }
        field(5; "Pickup Date"; Date)
        {
            Caption = 'Pickup Date';
            DataClassification = ToBeClassified;
        }
        field(6; "Cargo Type"; Enum "Cargo Type")
        {
            Caption = 'Cargo Type';
            DataClassification = ToBeClassified;
        }

        field(7; "Cargo Weight"; Decimal)
        {
            Caption = 'Cargo Weight';
            DataClassification = ToBeClassified;
        }
        field(8; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(9; Amount; Decimal)
        {

        }
        field(10; "Pickup Address Weather"; Text[100])
        {
            Editable = false;
        }
        field(11; "Delivery Address Weather"; Text[100])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        WeatherAPI: Codeunit "Weather API";

}