/*codeunit 50102 "Custom Approvals"
{
    procedure CheckWorkflowEnabled(var variant: variant): Boolean
    var
        RecRef: RecordRef;
        AVariant: Variant;
    begin
        RecRef.GetTable(variant);
        case RecRef.Number of
            Database::"Booking Header":
                exit(CheckIfApprovalWorkflowCodeIsEnabled(variant, RunWorkflowonSendBookingForApprovalCode));
        end;
    end;

    procedure CheckIfApprovalWorkflowCodeIsEnabled(var Variant: Variant; Workflowtext: Text): Boolean
    var
        TheWorkflowIsNotEnabled: Label 'This record is not supported by the related aproval workflow';
    begin
        if not WorkFlowManagement.CanExecuteWorkflow(Variant, Workflowtext) then
            Error(TheWorkflowIsNotEnabled);
        exit(true);
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendDocForApproval(var Variant: Variant)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelDocForApproval(var Variant: Variant)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddWorkFlowEventsToLibrary()
    var
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowonSendBookingForApprovalCode, Database::"Booking Header", OnSendBookingAppApproval, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(
            RunWorkflowonCancelBookingForApprovalCode, Database::"Booking Header", OnCancelBookingAppApproval, 0, false);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals", 'OnSendDocForApproval', '', false, false)]
    local procedure RunWorkflowOnSendApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Booking Header":
                WorkFlowManagement.HandleEvent(RunWorkflowonSendBookingForApprovalCode, Variant);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Custom Approvals", 'OnCancelDocForApproval', '', false, false)]
    local procedure RunWorkflowOnCancleApprovalRequest(var Variant: Variant)
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Booking Header":
                WorkFlowManagement.HandleEvent(RunWorkflowonCancelBookingForApprovalCode, Variant);
        end;
    end;

    procedure ReOpen(Var Variant: Variant)
    var
        RecRef: RecordRef;
        BookingHdr: record "Booking Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    BookingHdr.Validate("Approval Status", BookingHdr."Approval Status"::Open);
                    BookingHdr.Modify();
                    Variant := BookingHdr;
                end;
        end
    end;

    procedure Release(Var Variant: Variant)
    var
        RecRef: RecordRef;
        BookingHdr: record "Booking Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    BookingHdr.Validate("Approval Status", BookingHdr."Approval Status"::Approved);
                    BookingHdr.Modify();
                    Variant := BookingHdr;
                end;
        end
    end;

    procedure SetStatusToPending(Var Variant: Variant)
    var
        RecRef: RecordRef;
        BookingHdr: record "Booking Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    BookingHdr.Validate("Approval Status", BookingHdr."Approval Status"::Open);
                    BookingHdr.Modify();
                    Variant := BookingHdr;
                end;
        end
    end;

    procedure Reject(Var Variant: Variant)
    var
        RecRef: RecordRef;
        BookingHdr: record "Booking Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of
            Database::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    BookingHdr.Validate("Approval Status", BookingHdr."Approval Status"::Rejected);
                    BookingHdr.Modify();
                    Variant := BookingHdr;
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure PopulateApprovalEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        BookingHdr: Record "Booking Header";
    begin
        case RecRef.Number of
            Database::"Booking Header":
                begin
                    RecRef.SetTable(BookingHdr);
                    ApprovalEntryArgument."Document No." := BookingHdr."No.";
                end;
        end;
    end;

    var
        WorkFlowManagement: Codeunit "Workflow Management";
        WorkFlowResponseHandling: Codeunit "Workflow Response Handling";
        OnSendBookingAppApproval: Label 'Approval of a booking application is requested';
        RunWorkflowonSendBookingForApprovalCode: Label 'RUNWORKFLOWONSENDBOOKINGMEMBERFORAPPROVAL';
        OnCancelBookingAppApproval: Label 'Approval of a booking application is canceled';
        RunWorkflowonCancelBookingForApprovalCode: Label 'RUNWORKFLOWONCANCELBOOKINGFORAPPROVAL';
        BookingHdr: Record "Booking Header";


}*/