tableextension 50304 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(50303; "Gross Profit Amount"; Decimal)
        {
            Caption = 'Bruttofortjeneste';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50304; "Gross Profit %"; Decimal)
        {
            Caption = 'Margin %';
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 2 : 2;
        }

        field(50305; "Cost Amount"; Decimal)
        {
            Caption = 'Kostbeløp';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    local procedure CalcGrossProfit()
    var
        CostAmount: Decimal;
        SalesAmount: Decimal;
    begin
        // Kostbeløp
        CostAmount := "Unit Cost (LCY)" * Quantity;

        // Salgsbeløp (etter rabatt)
        SalesAmount := "Line Amount";

        // Kostbeløp lagret for FlowField
        "Cost Amount" := CostAmount;

        // Bruttofortjeneste i kroner
        "Gross Profit Amount" := SalesAmount - CostAmount;

        // Bruttofortjeneste i prosent
        if SalesAmount <> 0 then
            "Gross Profit %" := ("Gross Profit Amount" / SalesAmount) * 100
        else
            "Gross Profit %" := 0;
    end;

    local procedure UpdateHeaderTotals()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TotalSales: Decimal;
    begin
        if not SalesHeader.Get("Document Type", "Document No.") then
            exit;

        SalesHeader.CalcFields("Total Gross Profit");

        SalesLine.SetRange("Document Type", "Document Type");
        SalesLine.SetRange("Document No.", "Document No.");
        if SalesLine.FindSet() then
            repeat
                TotalSales += SalesLine."Line Amount";
            until SalesLine.Next() = 0;

        if TotalSales <> 0 then
            SalesHeader."Total Gross Profit %" := (SalesHeader."Total Gross Profit" / TotalSales) * 100
        else
            SalesHeader."Total Gross Profit %" := 0;

        SalesHeader.Modify(false);
    end;

    trigger OnBeforeModify()
    begin
        CalcGrossProfit();
    end;

    trigger OnBeforeInsert()
    begin
        CalcGrossProfit();
    end;

    trigger OnAfterModify()
    begin
        UpdateHeaderTotals();
    end;

    trigger OnAfterInsert()
    begin
        UpdateHeaderTotals();
    end;
}