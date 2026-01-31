pageextension 50101 "Sales Order Subform Ext" extends "Sales Order Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Gross Profit Amount"; Rec."Gross Profit Amount")
            {
                ApplicationArea = All;
                Caption = 'Bruttofortjeneste';
                ToolTip = 'Viser fortjeneste i kroner (Salgsbeløp - Kostpris)';
                BlankZero = true;
                Style = Favorable;
                StyleExpr = Rec."Gross Profit Amount" > 0;
            }

            field("Gross Profit %"; Rec."Gross Profit %")
            {
                ApplicationArea = All;
                Caption = 'Margin %';
                ToolTip = 'Viser fortjeneste i prosent av salgsbeløp';
                BlankZero = true;
                Style = Favorable;
                StyleExpr = Rec."Gross Profit %" > 0;
            }
        }
    }
}
