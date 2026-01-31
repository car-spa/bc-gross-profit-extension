pageextension 50102 "Sales Quote Ext" extends "Sales Quote"
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
}
