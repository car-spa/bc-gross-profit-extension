page 50305 "Sales Order Profit Factbox"
{
    PageType = CardPart;
    SourceTable = "Sales Header";
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

                field("Total Cost Amount"; Rec."Total Cost Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Total kostpris';
                    Style = Attention;
                    StyleExpr = true;
                }

                field("Total Gross Profit"; Rec."Total Gross Profit")
                {
                    ApplicationArea = All;
                    Caption = 'Total bruttofortjeneste';
                    Style = Favorable;
                    StyleExpr = Rec."Total Gross Profit" > 0;
                }

                field("Total Gross Profit %"; GrossProfitPct)
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
        GrossProfitPct: Decimal;

    trigger OnAfterGetCurrRecord()
    var
        SalesLine: Record "Sales Line";
    begin
        TotalSalesAmount := 0;
        GrossProfitPct := 0;

        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.CalcSums("Line Amount");
        TotalSalesAmount := SalesLine."Line Amount";

        Rec.CalcFields("Total Gross Profit");
        if TotalSalesAmount <> 0 then
            GrossProfitPct := (Rec."Total Gross Profit" / TotalSalesAmount) * 100;
    end;
}
