pageextension 50104 "Sales Order List Ext" extends "Sales Order List"
{
    layout
    {
        addlast(factboxes)
        {
            part(GrossProfitFactbox; "Sales Order Profit Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"), "No." = field("No.");
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action(RecalcGrossProfit)
            {
                ApplicationArea = All;
                Caption = 'Oppdater bruttofortjeneste';
                ToolTip = 'Beregner bruttofortjeneste for alle eksisterende ordre og tilbud';
                Image = Recalculate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    GrossProfitMgt: Codeunit "Gross Profit Mgt";
                begin
                    GrossProfitMgt.RecalculateAllSalesLines();
                end;
            }
        }
    }
}
