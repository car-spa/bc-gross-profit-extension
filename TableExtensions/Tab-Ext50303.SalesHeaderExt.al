tableextension 50303 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50303; "Total Gross Profit"; Decimal)
        {
            Caption = 'Total bruttofortjeneste';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Gross Profit Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Editable = false;
        }

        field(50305; "Total Cost Amount"; Decimal)
        {
            Caption = 'Total kostpris';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Cost Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
            Editable = false;
        }

        field(50304; "Total Gross Profit %"; Decimal)
        {
            Caption = 'Total margin %';
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 2 : 2;
        }
    }
}