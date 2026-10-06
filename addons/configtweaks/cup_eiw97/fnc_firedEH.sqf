params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

if !(local _unit) exitWith {};

if !(isPlayer _unit && {_mode isEqualTo "Electronic"}) exitWith {
	private _bursting = !(isNil ("mjb_eiwbursting_" + name _unit));
	if (_bursting || {_mode isNotEqualTo "Burst"}) exitWith {
		if (_bursting) exitWith {};
		private _rTime = (60/600); // 60 - 1000;
		_unit setWeaponReloadingTime [_unit,_muzzle,_rTime];
	};
	missionNamespace setVariable [("mjb_eiwbursting_" + name _unit),true];
	[_unit, _muzzle, _mode] spawn { params ["_unit", "_muzzle", "_mode"];
		private _burst = if (isPlayer _unit) then {mjb_eiwBurst min ( 1 + (_unit ammo _muzzle) )} else {3};
		if (_burst isEqualTo 1) exitWith {missionNamespace setVariable [("mjb_eiwbursting_" + name _unit),nil];};
		private _rTime = if (isPlayer _unit) then {(60/mjb_eiwBurstRPM)} else {(60/300)}; // 60 - 1000;
		if (isPlayer _unit && {!mjb_eiwInterrupt}) then {[_burst * _rTime] call ace_common_fnc_temporaryBlockFire;};
		for "_i" from 2 to _burst do {
			sleep _rTime;
			waitUntil [{(_unit weaponReloadingTime [_unit,_muzzle]) isEqualTo 0},_rTime + 1];
			private _anim = animationState _unit;
			if (!isAwake _unit || { weaponLowered _unit || { ("mrun" in _anim || {"meva" in _anim || {"mspr" in _anim}}) || { mjb_eiwInterrupt && {inputAction "defaultAction" isEqualTo 0} } } }) exitWith {};
 		    _unit forceWeaponFire [_muzzle, _mode];
			_unit setWeaponReloadingTime [_unit,_muzzle,_rTime];
		};
		sleep _rTime;
		if (isPlayer _unit && {!mjb_eiwInterrupt && {!(isNil "ace_common_temporaryBlockFireEH")}}) then {
			ace_common_temporaryBlockFireEH params ["_player", "_firedEH"];
			if (isNull _player) exitWith {};
			[_player, "DefaultAction", _firedEH] call ace_common_fnc_removeActionEventHandler;
			ace_common_temporaryBlockFireEH = nil;
		};
		missionNamespace setVariable [("mjb_eiwbursting_" + name _unit),nil];
	};
};

private _rTime = (60/mjb_eiwRPM); // 60 - 1000;
_unit setWeaponReloadingTime [_unit,_muzzle,_rTime];
