page 50310 "Posted Invoice Profit Factbox"
{
    PageType = CardPart;
    SourceTable = "Sales Invoice Header";
    Caption = 'Bruttofortjeneste';

    layout
    {
        area(content)
        {
            group(Totals)
            {
                Caption = 'Totaler';

                field("Total Sales Amount"; TotalSalesAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total utsalgspris';
                    Style = Strong;
                    StyleExpr = true;
                }

                field("Total Cost Amount"; TotalCostAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Total kostpris';
                    Style = Attention;
                    StyleExpr = true;
                }

                field("Total Gross Profit"; TotalGrossProfit)
                {
                    ApplicationArea = All;
                    Caption = 'Total bruttofortjeneste';
                    Style = Favorable;
                    StyleExpr = TotalGrossProfit > 0;
                }

                field("Gross Profit %"; GrossProfitPct)
                {
                    ApplicationArea = All;
                    Caption = 'Margin %';
                    DecimalPlaces = 2 : 2;
                    Style = Favorable;
                    StyleExpr = GrossProfitPct > 0;
                }
            }
        }
    }

    var
        TotalSalesAmount: Decimal;
        TotalCostAmount: Decimal;
        TotalGrossProfit: Decimal;
        GrossProfitPct: Decimal;

    trigger OnAfterGetCurrRecord()
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        TotalSalesAmount := 0;
        TotalCostAmount := 0;
        TotalGrossProfit := 0;
        GrossProfitPct := 0;

        SalesInvLine.SetRange("Document No.", Rec."No.");
        if SalesInvLine.FindSet() then
            repeat
                TotalSalesAmount += SalesInvLine."Line Amount";
                TotalCostAmount += SalesInvLine."Unit Cost (LCY)" * SalesInvLine.Quantity;
            until SalesInvLine.Next() = 0;

        TotalGrossProfit := TotalSalesAmount - TotalCostAmount;

        if TotalSalesAmount <> 0 then
            GrossProfitPct := (TotalGrossProfit / TotalSalesAmount) * 100;
    end;
}
