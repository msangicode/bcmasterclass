/*dotnet
{
    assembly(mscorlib)
    {
        type(System.DateTime; MyDateTime){}
    }
}

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        now: DotNet MyDateTime;
    begin
        now := now.UtcNow();
        Message('Hello, world! It is: %1 ' + now.ToString());
    end;
}*/