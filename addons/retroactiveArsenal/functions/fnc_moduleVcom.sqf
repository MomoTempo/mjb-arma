params ["_logic"];

if !(local _logic) exitWith {};

private _unit = attachedTo _logic;
deleteVehicle _logic;

private _isObj = _unit isEqualType objNull;
private _isPerson = (_isObj && {(_unit isKindOf "CAManBase")});
if (isNil "zen_dialog") exitWith {};
if (isNull _unit || { !_isObj }) exitWith {
    ["Vcom/TCL Global Setting", 
	[
		["CHECKBOX", "Disable VCOM/TCL Globally?",false,true]
	], {  params ["_values"];
		_values params ["_vcom"];
		missionNamespace setVariable ["VCM_ActivateAI",!_vcom,true];
		missionNamespace setVariable ["TCL_Setting_System_AI",!_vcom,true];
	},{},[]] call zen_dialog_fnc_create;
};

["Vcom/TCL Group Settings", 
	[
		["CHECKBOX", "Disable VCOM/TCL for group:", false, true],
		["CHECKBOX", "Stop Flanking (VCOM):", false, true],
		["CHECKBOX", "Prevent reinforcing(VCOM):", false, true],
		["CHECKBOX", "Prevent call reinforcements(VCOM):", false, true],
		["CHECKBOX", "Disable Formation Changes(VCOM):", false, true],
		["CHECKBOX", "Disable Skill Changes(VCOM):", true, true]
	], {  params ["_values", "_args"];
		_values params ["_vcom","_flank","_rescue","_tough","_form","_skill"];
		_args params ["_group"];
		if (isNull _group) exitWith {};
		_group setVariable ["Vcm_Disable",_vcom,true]; //This command will disable Vcom AI on a group entirely.
        _group setVariable ["VCM_NOFLANK",_flank,true]; //This command will stop the AI squad from executing advanced movement maneuvers.
		_group setVariable ["VCM_NORESCUE",_rescue,true]; //This command will stop the AI squad from responding to calls for backup.
		_group setVariable ["VCM_TOUGHSQUAD",_tough,true]; //This command will stop the AI squad from calling for backup.
		_group setVariable ["VCM_DisableForm",_form,true]; //This command will disable AI group from changing formations.
		_group setVariable ["VCM_Skilldisable",_skill,true]; //This command will disable an AI group from being impacted by Vcom AI skill changes.

		
		_group setVariable ["TCL_Disable",_vcom,true];
},{},[group (effectiveCommander _unit)]] call zen_dialog_fnc_create;