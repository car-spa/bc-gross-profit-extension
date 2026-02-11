pageextension 50309 "Posted Sales Invoices Ext" extends "Posted Sales Invoices"
{
    layout
    {
        addlast(factboxes)
        {
            part(GrossProfitFactbox; "Posted Invoice Profit Factbox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }
}
