pageextension 50105 "Sales Quote List Ext" extends "Sales Quotes"
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
