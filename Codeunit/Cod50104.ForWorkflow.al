/*codeunit 50104 "For Workflow"
{
    // Create events for workflow
    [IntegrationEvent(false, false)]
    procedure OnSendForWorkflowForApproval(ForWorkflow: Record "For Workflow")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelForWorkflowForApproval(ForWorkflow: Record "For Workflow")
    begin
    end;

    procedure RunWorkflowOnSendForWorkflowForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendForWorkflowForApprovalCode'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"For Workflow", 'OnSendForWorkflowForApproval', '', false, false)]
    procedure HandleEventOnSendForWorkflowForApproval()
    begin
    end;

    procedure RunWorkflowOnCancelForWorkflowForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelForWorkflowForApprovalCode'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"For Workflow", 'OnCancelForWorkflowForApproval', '', false, false)]
    procedure HandleEventOnCancelForWorkflowForApproval()
    begin
    end;

    procedure CheckForWorkflowWorkflowEnabled(var ForWorkflow: Record "For Workflow"): Boolean
    begin
    end;

    procedure IsForWorkflowDocApprovalsWorkflowEnabled(var ForWorkflow: Record "For Workflow"): Boolean
    begin
        if ForWorkflow.Status <> ForWorkflow.Status::Open then
            exit(false);
        exit(WorkflowMgt.CanExecuteWorkflow(ForWorkflow, RunWorkflowOnSendForWorkflowForApprovalCode()));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ForWorkflow: Record "For Workflow";
    begin
        case RecRef.Number of
            Database::"For Workflow":
                begin
                    RecRef.SetTable(ForWorkflow);
                    ApprovalEntryArgument."Document No." := ForWorkflow."No.";
                end;
        end;
    end;

    // Workflow event handling;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendForWorkflowForApprovalCode(), Database::"For Workflow",
        ForWorkflowSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelForWorkflowForApprovalCode(), Database::"For Workflow",
        ForWorkflowCancelApprovalEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkflowOnCancelForWorkflowForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelForWorkflowForApprovalCode(),
                RunWorkflowOnSendForWorkflowForApprovalCode());
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(),
                RunWorkflowOnSendForWorkflowForApprovalCode());
        end;
    end;

    // Workflow Response Handling;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ForWorkflow: Record "For Workflow";
    begin
        case RecRef.Number of
            Database::"For Workflow":
                begin
                    RecRef.SetTable(ForWorkflow);
                    ForWorkflow.Status := ForWorkflow.Status::Approved;
                    ForWorkflow.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ForWorkflow: Record "For Workflow";
    begin
        case RecRef.Number of
            Database::"For Workflow":
                begin
                    RecRef.SetTable(ForWorkflow);
                    ForWorkflow.Status := ForWorkflow.Status::Approved;
                    ForWorkflow.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ForWorkflow: Record "For Workflow";
    begin
        case RecRef.Number of
            Database::"For Workflow":
                begin
                    RecRef.SetTable(ForWorkflow);
                    ForWorkflow.Status := ForWorkflow.Status::Pending;
                    ForWorkflow.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    begin
        case ResponseFunctionName of
            WorkflowRspHandling.SetStatusToPendingApprovalCode():
                WorkflowRspHandling.AddResponsePredecessor(WorkflowRspHandling.SetStatusToPendingApprovalCode(),
                RunWorkflowOnSendForWorkflowForApprovalCode());
            WorkflowRspHandling.SendApprovalRequestForApprovalCode():
                WorkflowRspHandling.AddResponsePredecessor(WorkflowRspHandling.SendApprovalRequestForApprovalCode(),
                RunWorkflowOnSendForWorkflowForApprovalCode());
            WorkflowRspHandling.CancelAllApprovalRequestsCode():
                WorkflowRspHandling.AddResponsePredecessor(WorkflowRspHandling.CancelAllApprovalRequestsCode(),
                RunWorkflowOnCancelForWorkflowForApprovalCode());
            WorkflowRspHandling.OpenDocumentCode():
                WorkflowRspHandling.AddResponsePredecessor(WorkflowRspHandling.OpenDocumentCode(),
                RunWorkflowOnCancelForWorkflowForApprovalCode());
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', false, false)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowCategory(ForWorkflowCategoryDescTxt, ForWorkflowCategoryDescTxt);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', false, false)]
    local procedure OnAfterInsertApprovalsTableRelations()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkflowSetup.InsertTableRelation(Database::"For Workflow", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', false, false)]
    local procedure OnInsertWorkflowTemplates()
    begin

    end;

    local procedure InsertForWorkflowTemplate()
    var
        Workflow: Record Workflow;
    begin
        WorkflowSetup.InsertWorkflowTemplate(Workflow, ForWorkflowApprovalCodeTxt, ForWorkflowCategoryDescTxt, ForWorkflowCategoryDescTxt);
    end;

    procedure InsertForWorkFlowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        BlankDateFormula: DateFormula;
        ForWorkflow: Record "For Workflow";
    begin
        WorkflowSetup.PopulateWorkflowStepArgument(WorkflowStepArgument,
        WorkflowStepArgument."Approver Type"::Approver, WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildForWorkflowEventConditions(ForWorkflow.Status::Open),
            RunWorkflowOnSendForWorkflowForApprovalCode(),
            BuildForWorkflowEventConditions(ForWorkflow.Status::Pending),
            RunWorkflowOnCancelForWorkflowForApprovalCode(),
            WorkflowStepArgument,
            true
        );
    end;

    local procedure BuildForWorkflowEventConditions(Status: Integer): Text
    var
        ForWorkflow: Record "For Workflow";
    begin
        ForWorkflow.SetRange(Status, Status);
        exit(StrSubstNo(ForWorkFlowTypeCondTxt, WorkflowSetup.Encode(ForWorkflow.GetView(false))))
    end;

    var
        ForWorkflowSendForApprovalEventDescTxt: Label 'Approval of a for workflow is requested.';
        ForWorkflowCancelApprovalEventDescTxt: Label 'Approval of a for workflow is canceled.';
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowRspHandling: Codeunit "Workflow Response Handling";
        WorkflowMgt: Codeunit "Workflow Management";
        WorkflowSetup: Codeunit "Workflow Setup";
        ForWorkflowCategoryTxt: Label 'FW';
        ForWorkflowCategoryDescTxt: Label 'For Workflow Doc';
        ForWorkflowApprovalCodeTxt: Label 'For Workflow Document Approval';
        ForWorkFlowApprovalWorkfowDescTxt: Label 'For workflow Approval';
        ForWorkFlowTypeCondTxt: Label '<?xml version = “1.0” encoding=”utf-8” standalone="yes"?><ReportParameters><DataItems><DataItem name="For WorkFlow">%1</DataItem></DataItems></ReportParameters>';

}


*/