tableextension 50100 "Vendor Table Extension" extends Vendor
{
    fields
    {
        field(50100; "Tax Pin"; Code[10])
        {
            Caption = 'Tax Pin';
            DataClassification = ToBeClassified;
        }
    }

}
