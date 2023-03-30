XmlPort 50100 "Import Booking"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Booking Header"; "Booking Header")
            {
                XmlName = 'BufferLines';
                fieldattribute(HNo; "Booking Header"."No.")
                {
                }
                fieldattribute(AccountNo; "Booking Header"."Customer No.")
                {
                    FieldValidate = yes;
                }
            }
        }

    }


    trigger OnPostXmlPort()
    begin
        Message('Buffer Uploaded Successfuly');
    end;
}

