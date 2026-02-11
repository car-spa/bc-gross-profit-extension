pageextension 50310 "Posted Sales Invoice Ext" extends "Posted Sales Invoice"
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
