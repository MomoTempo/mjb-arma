
if (is3DEN) exitWith {};

params [["_mode", "", [""]], ["_input", [], [[]]]];
_input params [["_logic", objNull, [objNull]], ["_isActivated", true, [true]], ["_isCuratorPlaced", false, [true]]];

if (_isCuratorPlaced) then {

	if !(local _logic) exitWith {};

	private _unit = attachedTo _logic;
	deleteVehicle _logic;

	private _isObj = _unit isEqualType objNull;
	private _isPerson = (_isObj && {(_unit isKindOf "CAManBase")});
	if (isNull _unit || { !_isObj }) exitWith {
		//[objNull, "No unit or vehicle selected."] call BIS_fnc_showCuratorFeedbackMessage;
	};

	if (!_isPerson) exitWith {};

	_unit setVariable ['ace_medical_statemachine_AIUnconsciousness', true, true];

	if (isNil "zen_dialog") exitWith { _unit setVariable ['ace_medical_statemachine_fatalInjuriesAI', 0, true]; };

	["Allow AI Uncon", 
		[
			["LIST", "[ACE] Injuries can be Fatal:", [[0,1,2], ["Always","In Cardiac Arrest","Prevent Execution"]]]
		], {  params ["_values", "_args"];
			_values params ["_fatal"];
			_args params ["_unit"];
			
			_unit setVariable ['ace_medical_statemachine_fatalInjuriesAI', _fatal, true];
			
	},{},[_unit]] call zen_dialog_fnc_create;

} else {
	if !(local _logic && {_isActivated}) exitWith {};
    private _objects = (synchronizedObjects _logic);

    private _fatal = _logic getVariable ['mjb_fatal',0];

	{   private _unit = _x;
		if !(_unit isKindOf "CAManBase") then {continue};
		_unit setVariable ['ace_medical_statemachine_AIUnconsciousness', true, true];
		_unit setVariable ['ace_medical_statemachine_fatalInjuriesAI', _fatal, true];
	} forEach _objects;
};