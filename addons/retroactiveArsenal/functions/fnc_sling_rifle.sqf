params ["_unit", "_slingClass", "_unarmed", ["_rifle", (getUnitLoadout (_this#0))#0]];  //-- Get rifle before we throw it
_unit setVariable [_slingClass+"holder", [_unit, _rifle, true, true, "tsp_holder", !_unarmed, isNil "tsp_server_animate" || vehicle _unit isNotEqualTo _unit] call tsp_fnc_throw];
(_unit getVariable _slingClass+"holder") setDamage 1;
(call compile (missionNameSpace getVariable ("tsp_cba_animate_"+_slingClass))) params ["_bone", "_position", "_rotation", "_animation"];
private _old = false;
if (_bone isEqualType []) then { _old = true; _rotation = _position; _position = _bone; _bone = 'spine3'; _animation = "tsp_animate_sling_sling";};
(_unit getVariable _slingClass+"holder") attachTo [_unit, _position, _bone, true];
if (_old) then {
	[_unit getVariable _slingClass+"holder", _rotation] call BIS_fnc_setObjectRotation;
} else {
	[_unit getVariable _slingClass+"holder", _rotation] call tsp_fnc_rotate;
};
//(_unit getVariable _slingClass+"holder") attachTo [_unit, call compile (missionNameSpace getVariable ("tsp_cba_animate_"+_slingClass))#0, "Spine3", true]; 
//[_unit getVariable _slingClass+"holder", call compile (missionNameSpace getVariable ("tsp_cba_animate_"+_slingClass))#1] call BIS_fnc_setObjectRotation;
_unit setVariable [_slingClass+"weapon", [_unit getVariable _slingClass+"holder", _rifle]];  //-- This var stores [_holder, _rifle]
if (_unarmed && vehicle _unit isEqualTo _unit) then {_unit switchMove (animationState _unit regexReplace ["wrfl", "wnon"] regexReplace ["sras", "snon"] regexReplace ["slow", "snon"] regexReplace ["mtac", "mwlk"])};


private _killedHandle = _unit getVariable [("tsp_slingKilledHandler" + _slingClass),nil];
if (isNil '_killedHandle') then {
	_unit setVariable [("tsp_slingKilledHandler" + _slingClass),
		([_unit, "Killed", { params ["_unit"];
			private _slung = _unit getVariable [(_thisArgs + "weapon"),nil];
			if (!isNil "_slung") then {
				[_unit,_slung,_thisArgs] spawn { params ["_unit","_slung","_slingClass"]; sleep 1;
					_slung params [['_slingContainer',objNull],['_slung',nil]];
					if !(isNil '_slung') then {
						deleteVehicle _slingContainer;
						sleep 0.1;
						private _deathBox = (_unit nearObjects ["WeaponHolderSimulated",2]);
						if (count _deathBox isEqualTo 0) then {
							_deathBox = createVehicle ["WeaponHolderSimulated",_unit,[],2,"CAN_COLLIDE"];
						} else {_deathBox = (_deathBox select 0)};
						_deathBox addWeaponWithAttachmentsCargoGlobal [_slung, 1];
					};
					_unit setVariable [(_slingClass + "weapon"),nil];
				};
			};
			_unit setVariable [("tsp_slingKilledHandler"),nil];
			_unit removeEventHandler [_thisEvent,_thisEventHandler];
		},_slingClass] call CBA_fnc_addBISEventHandler )
	];

	// Hide sling in vics so they don't float into people's faces
	[_unit,"GetInMan", {
		params ["_unit"];
		if (vehicle _unit isEqualTo _unit) exitWith {systemChat "still self"};
		private _slung = _unit getVariable [(_thisArgs + "weapon"),nil];
		_slung params [['_slingContainer',nil]];
		if (isNil '_slingContainer') exitWith { };
		[_slingContainer,true] remoteExec ["hideObjectGlobal", 2];
	},_slingClass] call CBA_fnc_addBISEventHandler;
	[_unit,"GetOutMan", {
		params ["_unit"];
		if (vehicle _unit isNotEqualTo _unit) exitWith {systemChat "still vic"};
		private _slung = _unit getVariable [(_thisArgs + "weapon"),nil];
		_slung params [['_slingContainer',nil]];
		if (isNil '_slingContainer') exitWith {};
		[_slingContainer,false] remoteExec ["hideObjectGlobal", 2];
	},_slingClass] call CBA_fnc_addBISEventHandler;
};
if (vehicle _unit isNotEqualTo _unit) then {
	[((_unit getVariable [(_slingClass + "weapon"),[]]) select 0), true] remoteExec ["hideObjectGlobal", 2];
};

