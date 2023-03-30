page 50101 "Booking Header"
{
    ApplicationArea = All;
    Caption = 'Booking Header';
    PageType = Card;
    SourceTable = "Booking Header";
    PromotedActionCategories = 'New,Process,Report,Approvals';
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
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
                field("Customer Phone Number"; Rec."Customer Phone Number")
                {
                    ToolTip = 'Specifies the value of the Customer Phone Number field.';
                }
                field("Driver ID"; Rec."Driver ID")
                {
                    ToolTip = 'Specifies the value of the Driver ID field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Booking Status"; Rec."Booking Status")
                {
                    ToolTip = 'Specifies the value of the Booking Status field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                }
                field("Vehicle Description"; Rec."Vehicle Description")
                {
                    ToolTip = 'Specifies the value of the Vehicle Description field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }

                field("Time Posted"; Rec."Time Posted")
                {
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {

                }
            }

            part(BookingLine; "Booking Line")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = field("No.");

            }
        }

    }

    actions
    {
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View approvals for the record.';
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }

                action(Importexport)
                {
                    ApplicationArea = All;
                    Caption = 'Import';
                    Image = Import;
                    ToolTip = 'View approvals for the record.';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Xmlport.Run(Xmlport::"Import Booking");
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval to change the record.';
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        Rec.ValidatePreApproval();
                        if ApprovalsMgmtExtension.CheckBookingApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmtExtension.OnSendBookingForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmtExtension.OnCancelBookingApprovalRequest(Rec);
                        //  WorkflowWebhookManagement.FindAndCancel(RecordId);
                    end;
                }
            }

            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Promoted = true;
                    Image = PostOrder;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    AboutTitle = 'When all is set, you post';
                    ToolTip = 'Finalize the posting of the booking document.';

                    trigger OnAction()
                    var
                        TransportPost: Codeunit "Transport Post";
                    begin
                        TransportPost.PostBooking(Rec);
                    end;
                }

                action(UpdateCurrentWeatherInfo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Update Weather Info';
                    Promoted = true;
                    Image = WarrantyLedger;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        BookingLn: Record "Booking Line";
                        WeatherAPI: Codeunit "Weather API";
                        ConfirmMgt: Codeunit "Confirm Management";
                    begin
                        if not ConfirmMgt.GetResponse('Sure to update weather info', false) then exit;
                        Rec.TestField(Posted, false);
                        BookingLn.Reset();
                        BookingLn.SetRange(BookingLn."Document No.", Rec."No.");
                        if BookingLn.FindSet() then
                            repeat
                                BookingLn.TestField(BookingLn."Pickup Address");
                                BookingLn.TestField(BookingLn."Delivery Address");
                                BookingLn."Pickup Address Weather" := WeatherAPI.GetCurrentWeatherInfo(BookingLn."Pickup Address");
                                BookingLn."Delivery Address Weather" := WeatherAPI.GetCurrentWeatherInfo(BookingLn."Delivery Address");
                                BookingLn.Modify();
                            until BookingLn.Next() = 0;
                        Message('Weather info updated on the lines');
                    end;
                }

            }


        }

        area(Reporting)
        {
            action(BookingReport)
            {
                ApplicationArea = Basic, Suite;
                Image = BookingsLogo;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    BookingHdr: Record "Booking Header";
                begin
                    BookingHdr.Reset();
                    BookingHdr.SetRange("No.", Rec."No.");
                    if BookingHdr.FindFirst() then
                        Report.Run(Report::"Booking Report", true, false, BookingHdr);

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecordFunc();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        OnAfterGetCurrRecordFunc();
    end;

    local procedure OnAfterGetCurrRecordFunc()
    var
        myInt: Integer;
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        //  ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        // WorkflowWebhookManagement.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;


    var
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmtExtension: Codeunit "Approvals Mgmt Extension";


}
