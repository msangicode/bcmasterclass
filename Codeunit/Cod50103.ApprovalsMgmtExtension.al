codeunit 50103 "Approvals Mgmt Extension"
{

    //  create events => handle events => handle responses;4
    // Approval MGMT => work event handling => workflow response handling.

    procedure CheckBookingApprovalsWorkflowEnabled(var BookingHeader: Record "Booking Header"): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(BookingHeader, RunWorkflowOnSendBookingForApprovalCode()) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendBookingForApproval(var BookingHeader: Record "Booking Header")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt Extension", 'OnSendBookingForApproval', '', false, false)]
    local procedure RunWorkFlowOnSendBookingForApproval(var BookingHeader: Record "Booking Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendBookingForApprovalCode(), BookingHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt Extension", 'OnCancelBookingApprovalRequest', '', false, false)]
    local procedure RunWorkFlowOnCancelBookingApprovalRequest(var BookingHeader: Record "Booking Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancleBookingForApprovalCode(), BookingHeader);
    end;


    [IntegrationEvent(false, false)]
    procedure OnCancelBookingApprovalRequest(var BookingHeader: Record "Booking Header")
    begin
    end;

    // add events to the library;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin

        WorkflowEventHandling.AddEventToLibrary(
          RunWorkflowOnSendBookingForApprovalCode(), DATABASE::"Booking Header",
          BookingSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(
          RunWorkflowOnCancleBookingForApprovalCode(), DATABASE::"Booking Header",
          BookingApprovalRequestCancelEventDescTxt, 0, false);
    end;

    procedure RunWorkflowOnSendBookingForApprovalCode(): Code[128]
    begin
        exit('RUNWORKFLOWONSENDBOOKINGFORAPPROVAL');
    end;

    procedure GetSum(num1: Integer; num2: Integer): Integer
    begin
        exit(num1 + num2);
    end;

    procedure RunWorkflowOnCancleBookingForApprovalCode(): Code[128]
    begin
        exit('RUNWORKFLOWONCANCELBOOKINGFORAPPROVAL');
    end;

    /// Handle our response
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BookingHdr: Record "Booking Header";
    begin
        case RecRef.Number of
            Database::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    BookingHdr.Validate("Approval Status", BookingHdr."Approval Status"::Open);
                    BookingHdr.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        BookingHdr: Record "Booking Header";
    begin
        case RecRef.Number of
            Database::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    BookingHdr.Validate("Approval Status", BookingHdr."Approval Status"::Approved);
                    BookingHdr.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        BookingHdr: Record "Booking Header";
    begin
        case RecRef.Number of
            Database::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    BookingHdr.Validate("Approval Status", BookingHdr."Approval Status"::Pending);
                    BookingHdr.Modify();
                    Variant := BookingHdr;
                    IsHandled := true;
                end;
        end;
    end;


    // populate workflow argument

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        BookingHdr: Record "Booking Header";
    begin
        case RecRef.Number of
            DATABASE::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    ApprovalEntryArgument."Document No." := BookingHdr."No.";
                end;
        end;

    end;

    // reject;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin
        case ApprovalEntry."Table ID" of
            DataBase::"Booking Header":
                begin
                    if BookingHdr.Get(ApprovalEntry."Document No.") then begin
                        BookingHdr."Approval Status" := BookingHdr."Approval Status"::Rejected;
                        BookingHdr.Modify();
                    end;
                end;
        end;

    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';

        BookingSendForApprovalEventDescTxt: Label 'Approval of a booking is requested.';
        BookingApprovalRequestCancelEventDescTxt: Label 'An approval request for a booking is canceled.';

        BookingHdr: Record "Booking Header";
}
