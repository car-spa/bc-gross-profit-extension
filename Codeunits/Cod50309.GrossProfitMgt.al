codeunit 50309 "Gross Profit Mgt"
{
    procedure RecalculateAllSalesLines()
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        Window: Dialog;
        Counter: Integer;
        TotalLines: Integer;
    begin
        Window.Open('Oppdaterer bruttofortjeneste...\Linje #1### av #2###');

        SalesLine.SetFilter("Document Type", '%1|%2', SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order);
        TotalLines := SalesLine.Count();
        Window.Update(2, TotalLines);

        if SalesLine.FindSet() then
            repeat
                Counter += 1;
                Window.Update(1, Counter);

                CalcGrossProfitForLine(SalesLine);
                SalesLine.Modify(false);
            until SalesLine.Next() = 0;

        // Oppdater header-totaler
        SalesHeader.SetFilter("Document Type", '%1|%2', SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then
            repeat
                UpdateHeaderTotals(SalesHeader);
            until SalesHeader.Next() = 0;

        Window.Close();
        Message('Ferdig! %1 linjer ble oppdatert.', Counter);
    end;

    local procedure CalcGrossProfitForLine(var SalesLine: Record "Sales Line")
    var
        CostAmount: Decimal;
        SalesAmount: Decimal;
    begin
        CostAmount := SalesLine."Unit Cost (LCY)" * SalesLine.Quantity;
        SalesAmount := SalesLine."Line Amount";

        SalesLine."Cost Amount" := CostAmount;
        SalesLine."Gross Profit Amount" := SalesAmount - CostAmount;

        if SalesAmount <> 0 then
            SalesLine."Gross Profit %" := (SalesLine."Gross Profit Amount" / SalesAmount) * 100
        else
            SalesLine."Gross Profit %" := 0;
    end;

    local procedure UpdateHeaderTotals(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        TotalSales: Decimal;
    begin
        SalesHeader.CalcFields("Total Gross Profit");

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
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
}
