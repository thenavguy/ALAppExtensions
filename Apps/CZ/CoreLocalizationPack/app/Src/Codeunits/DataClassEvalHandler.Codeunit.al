codeunit 11710 "Data Class. Eval. Handler CZL"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Data Class. Eval. Data Country", 'OnAfterClassifyCountrySpecificTables', '', false, false)]
    local procedure ApplyEvaluationClassificationsForPrivacyOnAfterClassifyCountrySpecificTables()
    begin
        ApplyEvaluationClassificationsForPrivacy();
    end;

    procedure ApplyEvaluationClassificationsForPrivacy()
    var
        AccScheduleLine: Record "Acc. Schedule Line";
        AccScheduleName: Record "Acc. Schedule Name";
        Company: Record Company;
        CompanyInformation: Record "Company Information";
        Contact: Record Contact;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        FinanceChargeMemoHeader: Record "Finance Charge Memo Header";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJournalLine: Record "Gen. Journal Line";
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        InventorySetup: Record "Inventory Setup";
        InvoicePostBuffer: Record "Invoice Post. Buffer";
        IssuedFinChargeMemoHeader: Record "Issued Fin. Charge Memo Header";
        IssuedReminderHeader: Record "Issued Reminder Header";
        Item: Record Item;
        ItemJournalLine: Record "Item Journal Line";
        JobJournalLine: Record "Job Journal Line";
        PhysInvtOrderLine: Record "Phys. Invt. Order Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeaderArchive: Record "Purchase Header Archive";
        PurchaseLine: Record "Purchase Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ReminderHeader: Record "Reminder Header";
        Resource: Record Resource;
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnShipmentHeader: Record "Return Shipment Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesHeader: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesLine: Record "Sales Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
        ServiceCrMemoLine: Record "Service Cr.Memo Line";
        ServiceHeader: Record "Service Header";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ServiceInvoiceLine: Record "Service Invoice Line";
        ServiceLine: Record "Service Line";
        ServiceMgtSetup: Record "Service Mgt. Setup";
        ServiceShipmentHeader: Record "Service Shipment Header";
        ServiceShipmentLine: Record "Service Shipment Line";
        SourceCodeSetup: Record "Source Code Setup";
        StockkeepingUnit: Record "Stockkeeping Unit";
        TariffNumber: Record "Tariff Number";
        UserSetup: Record "User Setup";
        VATEntry: Record "VAT Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        VATStatementLine: Record "VAT Statement Line";
        VATStatementName: Record "VAT Statement Name";
        VATStatementTemplate: Record "VAT Statement Template";
        Vendor: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
    begin
        Company.Get(CompanyName());
        if not Company."Evaluation Company" then
            exit;

        DataClassificationMgt.SetTableFieldsToNormal(Database::"Acc. Schedule File Mapping CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Commodity CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Commodity Setup CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Company Official CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Document Footer CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Excel Template CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Invt. Movement Template CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Registration Log CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Reg. No. Service Config CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Statistic Indication CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Statutory Reporting Setup CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Stockkeeping Unit Template CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Unreliable Payer Entry CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"Unrel. Payer Service Setup CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Attribute Code CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Ctrl. Report Buffer CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Ctrl. Report Ent. Link CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Ctrl. Report Header CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Ctrl. Report Line CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Ctrl. Report Section CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Period CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Statement Attachment CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VAT Statement Comment Line CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VIES Declaration Header CZL");
        DataClassificationMgt.SetTableFieldsToNormal(Database::"VIES Declaration Line CZL");

        DataClassificationMgt.SetFieldToNormal(Database::"Acc. Schedule Line", AccScheduleLine.FieldNo("Calc CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Acc. Schedule Line", AccScheduleLine.FieldNo("Row Correction CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Acc. Schedule Line", AccScheduleLine.FieldNo("Assets/Liabilities Type CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Acc. Schedule Name", AccScheduleName.FieldNo("Acc. Schedule Type CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Company Information", CompanyInformation.FieldNo("Default Bank Account Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Company Information", CompanyInformation.FieldNo("Bank Branch Name CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Company Information", CompanyInformation.FieldNo("Bank Account Format Check CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Company Information", CompanyInformation.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Contact, Contact.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Contact, Contact.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Cust. Ledger Entry", CustLedgerEntry.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Customer, Customer.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Customer, Customer.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Finance Charge Memo Header", FinanceChargeMemoHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Finance Charge Memo Header", FinanceChargeMemoHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"General Ledger Setup", GeneralLedgerSetup.FieldNo("Allow VAT Posting From CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"General Ledger Setup", GeneralLedgerSetup.FieldNo("Allow VAT Posting To CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"General Ledger Setup", GeneralLedgerSetup.FieldNo("Use VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"General Ledger Setup", GeneralLedgerSetup.FieldNo("Do Not Check Dimensions CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("VAT Delay CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("Original Doc. Partner Type CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("Original Doc. Partner No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Gen. Journal Line", GenJournalLine.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"G/L Account", GLAccount.FieldNo("G/L Account Group CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"G/L Account", GLAccount.FieldNo("Net Change (VAT Date) CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"G/L Account", GLAccount.FieldNo("Debit Amount (VAT Date) CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"G/L Account", GLAccount.FieldNo("Credit Amount (VAT Date) CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"G/L Entry", GLEntry.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Inventory Setup", InventorySetup.FieldNo("Def.Tmpl. for Phys.Pos.Adj CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Inventory Setup", InventorySetup.FieldNo("Def.Tmpl. for Phys.Neg.Adj CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Invoice Post. Buffer", InvoicePostBuffer.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Invoice Post. Buffer", InvoicePostBuffer.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Issued Fin. Charge Memo Header", IssuedFinChargeMemoHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Issued Fin. Charge Memo Header", IssuedFinChargeMemoHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Issued Reminder Header", IssuedReminderHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Issued Reminder Header", IssuedReminderHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Item, Item.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Item Journal Line", ItemJournalLine.FieldNo("Invt. Movement Template CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Job Journal Line", JobJournalLine.FieldNo("Invt. Movement Template CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Phys. Invt. Order Line", PhysInvtOrderLine.FieldNo("Invt. Movement Template CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("Last Unreliab. Check Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("VAT Unreliable Payer CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("Third Party Bank Account CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("EU 3-Party Trade CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header", PurchaseHeader.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header Archive", PurchaseHeaderArchive.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header Archive", PurchaseHeaderArchive.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header Archive", PurchaseHeaderArchive.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header Archive", PurchaseHeaderArchive.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header Archive", PurchaseHeaderArchive.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header Archive", PurchaseHeaderArchive.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Header Archive", PurchaseHeaderArchive.FieldNo("EU 3-Party Trade CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Line", PurchaseLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchase Line", PurchaseLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchases & Payables Setup", PurchasesPayablesSetup.FieldNo("Default VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purchases & Payables Setup", PurchasesPayablesSetup.FieldNo("Def. Orig. Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr.FieldNo("EU 3-Party Trade CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Line", PurchCrMemoLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Cr. Memo Line", PurchCrMemoLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Header", PurchInvHeader.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Header", PurchInvHeader.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Header", PurchInvHeader.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Header", PurchInvHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Header", PurchInvHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Header", PurchInvHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Header", PurchInvHeader.FieldNo("EU 3-Party Trade CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Header", PurchInvHeader.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Line", PurchInvLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Inv. Line", PurchInvLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Rcpt. Header", PurchRcptHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Rcpt. Header", PurchRcptHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Rcpt. Header", PurchRcptHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Rcpt. Header", PurchRcptHeader.FieldNo("EU 3-Party Trade CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Rcpt. Header", PurchRcptHeader.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Rcpt. Line", PurchRcptLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Purch. Rcpt. Line", PurchRcptLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Reminder Header", ReminderHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Reminder Header", ReminderHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Resource, Resource.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Return Receipt Header", ReturnReceiptHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Return Receipt Header", ReturnReceiptHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Return Receipt Header", ReturnReceiptHeader.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Return Shipment Header", ReturnShipmentHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Return Shipment Header", ReturnShipmentHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Return Shipment Header", ReturnShipmentHeader.FieldNo("EU 3-Party Trade CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Cr.Memo Header", SalesCrMemoHeader.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Cr.Memo Header", SalesCrMemoHeader.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Cr.Memo Header", SalesCrMemoHeader.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Cr.Memo Header", SalesCrMemoHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Cr.Memo Header", SalesCrMemoHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Cr.Memo Header", SalesCrMemoHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Cr.Memo Line", SalesCrMemoLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Cr.Memo Line", SalesCrMemoLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header", SalesHeader.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header", SalesHeader.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header", SalesHeader.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header", SalesHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header", SalesHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header", SalesHeader.FieldNo("Credit Memo Type CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header", SalesHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header", SalesHeader.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header Archive", SalesHeaderArchive.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header Archive", SalesHeaderArchive.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header Archive", SalesHeaderArchive.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header Archive", SalesHeaderArchive.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header Archive", SalesHeaderArchive.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Header Archive", SalesHeaderArchive.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Invoice Header", SalesInvoiceHeader.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Invoice Header", SalesInvoiceHeader.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Invoice Header", SalesInvoiceHeader.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Invoice Header", SalesInvoiceHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Invoice Header", SalesInvoiceHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Invoice Header", SalesInvoiceHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Invoice Line", SalesInvoiceLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Invoice Line", SalesInvoiceLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Line", SalesLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Line", SalesLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales & Receivables Setup", SalesReceivablesSetup.FieldNo("Default VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Shipment Header", SalesShipmentHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Shipment Header", SalesShipmentHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Shipment Header", SalesShipmentHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Shipment Line", SalesShipmentLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Sales Shipment Line", SalesShipmentLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Cr.Memo Header", ServiceCrMemoHeader.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Cr.Memo Header", ServiceCrMemoHeader.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Cr.Memo Header", ServiceCrMemoHeader.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Cr.Memo Header", ServiceCrMemoHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Cr.Memo Header", ServiceCrMemoHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Cr.Memo Header", ServiceCrMemoHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Cr.Memo Line", ServiceCrMemoLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Cr.Memo Line", ServiceCrMemoLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Header", ServiceHeader.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Header", ServiceHeader.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Header", ServiceHeader.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Header", ServiceHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Header", ServiceHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Header", ServiceHeader.FieldNo("Credit Memo Type CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Header", ServiceHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Invoice Header", ServiceInvoiceHeader.FieldNo("VAT Currency Factor CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Invoice Header", ServiceInvoiceHeader.FieldNo("VAT Currency Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Invoice Header", ServiceInvoiceHeader.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Invoice Header", ServiceInvoiceHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Invoice Header", ServiceInvoiceHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Invoice Header", ServiceInvoiceHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Invoice Line", ServiceInvoiceLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Invoice Line", ServiceInvoiceLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Line", ServiceLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Line", ServiceLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Mgt. Setup", ServiceMgtSetup.FieldNo("Default VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Shipment Header", ServiceShipmentHeader.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Shipment Header", ServiceShipmentHeader.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Shipment Header", ServiceShipmentHeader.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Shipment Line", ServiceShipmentLine.FieldNo("Tariff No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Service Shipment Line", ServiceShipmentLine.FieldNo("Statistic Indication CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Source Code Setup", SourceCodeSetup.FieldNo("Purchase VAT Delay CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Source Code Setup", SourceCodeSetup.FieldNo("Sales VAT Delay CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Stockkeeping Unit", StockkeepingUnit.FieldNo("Gen. Prod. Posting Group CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Tariff Number", TariffNumber.FieldNo("Statement Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Tariff Number", TariffNumber.FieldNo("VAT Stat. UoM Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Tariff Number", TariffNumber.FieldNo("Allow Empty UoM Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Tariff Number", TariffNumber.FieldNo("Statement Limit Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"User Setup", UserSetup.FieldNo("Allow VAT Posting From CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"User Setup", UserSetup.FieldNo("Allow VAT Posting To CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("VAT Settlement No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("VAT Delay CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("VAT Ctrl. Report No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("VAT Ctrl. Report Line No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Entry", VATEntry.FieldNo("Original Doc. VAT Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("Reverse Charge Check CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("Purch. VAT Curr. Exch. Acc CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("Sales VAT Curr. Exch. Acc CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("VIES Purchase CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("VIES Sales CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("VAT Rate CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("Supplies Mode Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("Ratio Coefficient CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Posting Setup", VATPostingSetup.FieldNo("Corrections Bad Receivable CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("Attribute Code CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("G/L Amount Type CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("Gen. Bus. Posting Group CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("Gen. Prod. Posting Group CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("Show CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("EU 3-Party Intermed. Role CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("EU-3 Party Trade CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("VAT Ctrl. Report Section CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Line", VATStatementLine.FieldNo("Ignore Simpl. Doc. Limit CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Name", VATStatementName.FieldNo("Comments CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Name", VATStatementName.FieldNo("Attachments CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Template", VATStatementTemplate.FieldNo("XML Format CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"VAT Statement Template", VATStatementTemplate.FieldNo("Allow Comments/Attachments CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Vendor, Vendor.FieldNo("Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Vendor, Vendor.FieldNo("Tax Registration No. CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Vendor, Vendor.FieldNo("Last Unreliab. Check Date CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Vendor, Vendor.FieldNo("VAT Unreliable Payer CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::Vendor, Vendor.FieldNo("Disable Unreliab. Check CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Vendor Bank Account", VendorBankAccount.FieldNo("Third Party Bank Account CZL"));
        DataClassificationMgt.SetFieldToNormal(Database::"Vendor Ledger Entry", VendorLedgerEntry.FieldNo("VAT Date CZL"));
    end;
}