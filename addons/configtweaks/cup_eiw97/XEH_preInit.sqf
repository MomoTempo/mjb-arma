
["z\mjb\addons\configtweaks\cup_eiw97\fnc_firedEH.sqf", "mjb_eiw97_fnc_firedEH"] call CBA_fnc_compileFunction;

//private _title = "MJB Arma";
[
    "mjb_eiwRPM",
    "SLIDER",
    ["EIW97 Selectable RoF", "Rate of fire for the EIW97 when fired in full auto."],
    ["MJB Arma", "xEIW97"],
    [60, 1000, 600, 0],
    false,
    {
        params ["_value"];
        mjb_eiwRPM = round _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_eiwBurst",
    "SLIDER",
    ["EIW97 Burst Length", "Number of rounds fired in burst."],
    ["MJB Arma", "xEIW97"],
    [1, 30, 3, 0],
    false,
    {
        params ["_value"];
        mjb_eiwBurst = round _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_eiwBurstRPM",
    "SLIDER",
    ["EIW97 Burst RoF", "Rate of fire for the EIW97 when fired in burst, high RoF may fail to fire full burst."],
    ["MJB Arma", "xEIW97"],
    [60, 1000, 300, 0],
    false,
    {
        params ["_value"];
        mjb_eiwBurstRPM = round _value;
    }
] call CBA_fnc_addSetting;

[
    "mjb_eiwInterrupt",
    "CHECKBOX",
    ["Releasing Trigger Interrupts Burst", "Whether burst is interrupted by releasing trigger, useful for longer bursts. Otherwise burst can be canceled by moving outside of tac pace or lowering weapon. Animate's high/low ready also prevent firing but burst will still attempt to fire to completion."],
    ["MJB Arma", "xEIW97"],
    false,
    true
] call CBA_fnc_addSetting;
