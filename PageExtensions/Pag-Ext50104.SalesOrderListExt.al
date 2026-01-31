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
}
