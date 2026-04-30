params ["_unit", ["_sling", false], ["_holster", false], ["_drawPistol", false], ["_drawLauncher", false], ["_unsling", false], ["_slingClass", "auto"], ["_unslingClass", "auto"], ["_time", 0]];

_knife = if (!isNil "tsp_fnc_melee_weapon") then {!([_unit, handGunWeapon _unit] call tsp_fnc_melee_weapon in ["", "pistol"])} else {false};
if ("sling" in gestureState _unit) exitWith {};  //-- No slinging while doing slinging action
if (_sling) then {
	[[_unit] call tsp_fnc_animate_sling_get, _unit getVariable [primaryWeapon _unit+"pref", ""]] params ["_slings", "_preference"];
	if (_slingClass isEqualTo "auto") then {_slingClass = if (_preference isNotEqualTo "" && _preference in _slings) then {_preference} else {_slings#0}};  //-- If weapon has preference
	_unit setVariable [primaryWeapon _unit+"pref", _slingClass];  //-- Set preference
	if (_drawPistol && !_knife && tsp_cba_animate_sling_style isEqualTo "adhd") then {[_unit, "tsp_animate_sling_check"] remoteExec ["playActionNow"]};   //-- Chamber check
	if (_drawPistol && !_knife && tsp_cba_animate_sling_style isEqualTo "adhd") then {playSound3D ["A3\Sounds_F\weapons\Other\dry5-rifle.wss", _unit, false, getPosASL _unit, 5, 1, 10]; _time = _time + 0.1};
	(call compile (missionNameSpace getVariable ("tsp_cba_animate_"+_slingClass))) params ["_bone", "_position", "_rotation", "_animation"];
	if (_bone isEqualType []) then { _rotation = _position; _position = _bone; _bone = 'spine3'; _animation = "tsp_animate_sling_sling";};
	tsp_future pushBack [time + _time, [_unit, _animation], {params ["_unit", "_animation"]; [_unit, _animation] remoteExec ["playActionNow"]}];  //-- Play animation
	tsp_future pushBack [time + _time + 0.25, [_unit, _slingClass, !_drawPistol && !_drawLauncher && !_unsling], {_this call tsp_fnc_animate_sling_rifle}];  //-- Moved out
	_time = _time + 0.25;
	/*tsp_future pushBack [time + _time, [_unit], {params ["_unit"]; [_unit, "tsp_animate_sling_sling"] remoteExec ["playActionNow"]}];  //-- Play animation
	tsp_future pushBack [time + _time + 0.2, [_unit, _slingClass, !_drawPistol && {!_drawLauncher && {!_unsling}}], {
		_this call tsp_fnc_animate_sling_rifle  //-- Moved out
	}];
	_time = _time + 0.2;*/
};
if (_holster) then {
	[_unit, handgunWeapon _unit] remoteExec ["selectWeapon"];
	[_unit, "tsp_animate_sling_" + (if (_knife) then {"sheath"} else {"holster"})] remoteExec ["playActionNow"];
	_unit spawn {sleep 0.2; playSound3D ["A3\Sounds_F\weapons\Closure\firemode_changer_1.wss", _this, false, getPosASL _this, 5, 1, 5]};
	_time = 0.7;
};
if (_drawPistol) then {
	tsp_future pushBack [time + _time, [_unit], {
		params ["_unit"];
		if (vehicle _unit isEqualTo _unit) then {[_unit, animationState _unit regexReplace ["wrfl", "wpst"]] remoteExec ["switchMove"]};  //-- Using blendfactor breaks leaning, thanks BI!
		if (_knife) exitWith {[_unit, "ready"] spawn tsp_fnc_melee_action};
		[_unit, "tsp_animate_sling_draw" + (if (tsp_cba_animate_sling_style isEqualTo "israeli") then {"_israeli"} else {""})] remoteExec ["playActionNow"];
		if (tsp_cba_animate_sling_style isEqualTo "israeli") then {playSound3D ["A3\Sounds_F\weapons\Other\reload_bolt_1.wss", _unit, false, getPosASL _unit, 5, 1, 10]};
	}];
};
if (_drawLauncher) then {
	tsp_future pushBack [time + _time, [_unit], {
		params ["_unit"];
		if (vehicle _unit isEqualTo _unit) then {[_unit, [animationState _unit regexReplace ["wrfl", "wlnr"], 0, 0, false]] remoteExec ["switchMove"]};
		[_unit, secondaryWeapon _unit] remoteExec ["selectWeapon"]; [_unit, "tsp_animate_sling_unlaunch"] remoteExec ["playActionNow"];
	}];
};
if (_unsling) then {
	if (currentWeapon _unit isEqualTo secondaryWeapon _unit && secondaryWeapon _unit isNotEqualTo "") then {[_unit, "tsp_animate_sling_launch"] remoteExec ["playActionNow"]; _time = 1};
	if (currentWeapon _unit isEqualTo binocular _unit && binocular _unit isNotEqualTo "") then {[_unit, "tsp_animate_sling_unbino"] remoteExec ["playActionNow"]; _time = 0.7};
	tsp_future pushBack [time + _time, [_unit, _sling, _holster, if (_unslingClass isEqualTo "auto") then {([_unit, false] call tsp_fnc_animate_sling_get)#0} else {_unslingClass}], {
		params ["_unit", "_sling", "_holster", "_unslingClass"]; if (isNil "_unslingClass") exitWith {};
		(_unit getVariable [_unslingClass+"weapon", []]) params ["_holder", "_rifle"]; _rifle params ["_class", "_suppressor", "_pointer", "_optic", "_magazine1", "_magazine2", "_bipod"];
		_unit addWeapon _class; {_unit addPrimaryWeaponItem _x} forEach [_suppressor, _pointer, _optic, _bipod];          //-- Add weapon and attachments
		_weaponItems = (weaponsItems _unit select {_x#0 isEqualTo _class})#0; deleteVehicle _holder;                            //-- Get weapon items (including any magazines that were auto-loaded)
		{if (count _x > 0) then {_unit addWeaponItem [_class, [_x#0, _x#1], true]}} forEach [_magazine1, _magazine2];   //-- Load correct magazine into weapon
		{if (count _x isEqualTo 0) then {_unit removePrimaryWeaponItem ((getUnitLoadout _unit#0#(4+_forEachIndex)))#0}} forEach [_magazine1, _magazine2]; //-- If mag is empty, remove auto loaded magazine
		{if (count _x > 0) then {_unit addMagazine [_x#0, _x#1]}} forEach [_weaponItems#4, _weaponItems#5];           //-- Return auto-loaded magazine to inventory
		if (vehicle _unit isEqualTo _unit && stance _unit isEqualTo "CROUCH") then {[_unit, "amovpknlmstpslowwrfldnon_amovpknlmstpsraswrfldnon"] remoteExec ["switchMove"]};
		if (vehicle _unit isEqualTo _unit && stance _unit isNotEqualTo "CROUCH") then {[_unit, "amovpercmstpslowwrfldnon_amovpercmstpsraswrfldnon"] remoteExec ["switchMove"]};
		if (vehicle _unit isEqualTo _unit && !_holster) then {_unit switchMove (if (stance _unit isEqualTo "CROUCH") then {"amovpknlmstpslowwrfldnon_amovpknlmstpsraswrfldnon"} else {"amovpercmstpslowwrfldnon_amovpercmstpsraswrfldnon"})};
		if (_sling) then {[_unit, "tsp_animate_sling_swap"] remoteExec ["playActionNow"]};  //-- Dont overwrite if we slung a rifle beforehand
		_unit setVariable [_unslingClass+"weapon", []]; [_unit, primaryWeapon _unit] remoteExec ["selectWeapon"];
	}]
};
tsp_future pushBack [time + _time + 0.2, [_unit], {  //-- Walking speed changes with amount of slung weapons
	params ["_unit"]; _weapons = ([_unit, false] call tsp_fnc_animate_sling_get);
	if (primaryWeapon _unit isNotEqualTo "") then {_weapons pushBack [primaryWeapon _unit]};
	if (count _weapons <= 2) exitWith {_unit allowSprint true; _unit forceWalk false};
	if (count _weapons > 2) exitWith {_unit allowSprint false; _unit forceWalk true};
}]