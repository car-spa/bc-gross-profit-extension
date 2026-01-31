tableextension 50100 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50101; "Total Gross Profit"; Decimal)
        {
            Caption = 'Total bruttofortjeneste';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Gross Profit Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Editable = false;
        }

        field(50103; "Total Cost Amount"; Decimal)
        {
            Caption = 'Total kostpris';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Cost Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Editable = false;
        }

        field(50102; "Total Gross Profit %"; Decimal)
        {
            Caption = 'Total margin %';
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 2 : 2;
        }
    }
}