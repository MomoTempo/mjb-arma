//RNG AI by Toksa
_man = _this select 0;
_group = group _man;

_sideman = str (side _man);

if (RNG_sides isEqualTo _sideman || { ((missionnamespace getvariable ["RNG_sides","ALL"]) isEqualTo "ALL") } ) then {

_man addEventHandler ["Local", {
	params ["_entity", "_isLocal"];
	if (!_isLocal ) exitWith {};
	if (_entity getvariable ["RNG_active",false]) exitWith {};
    [_entity] call RNG_fnc_unit_init;
}];

if !(local _man) exitWith {};
	
_man setvariable ["RNG_active",true];

_man addEventHandler ["FiredNear", {
	params ["_unit", "_firer", "_distance", "_weapon"];
	if !(local _unit && {(_unit getvariable ["RNG_cooldown",(time -1)]) > time}) exitWith {};
	if (_unit getvariable ["RNG_disabled",false]) exitWith {};
	if (_unit isEqualTo _firer || {_weapon isEqualTo 'Throw'}) exitWith {};
	if ((vehicle _unit) isNotEqualTo _unit) exitWith {_unit setvariable ["RNG_cooldown",(time + 10)];};
	if ((side _firer) isEqualTo (side _unit) && {(random 1) > RNG_allyReactChance}) exitWith { if (RNG_allyCD) then {_unit setvariable ['RNG_cooldown',(time + 2)];}; };
	if (currentWeapon _unit isEqualTo binocular _unit) then {
		_unit selectWeapon primaryWeapon _unit;
	};
	[_unit,_firer] call RNG_fnc_react;
}];

if (!(isClass(configFile >> "CfgPatches" >> "ace_medical_engine"))) then {
	_man addEventHandler ["HandleDamage", { 
		params ["_unit", "", "_damage", "_source", "", "", "_instigator"]; 
		if ((isNull _instigator && {_source isEqualTo _unit}) OR {(!(isplayer _source) && {!(side _source isEqualTo sideEnemy) && {(side _unit isEqualTo side _source)}})}) then {_damage = 0};
		_damage;
	}];
};


_man addEventHandler ["Suppressed", {
	params ["_unit", "", "_shooter"];
	if (currentWeapon _unit isEqualTo binocular _unit) then {
		_unit selectWeapon primaryWeapon _unit;
	};
	if (_unit getvariable ["RNG_disabled",false]) exitWith {};
	[_unit,_shooter] call RNG_fnc_react;
}];

if (!(_group getvariable ["RNG_group_active",false])) then {
	_group setvariable ["RNG_group_active",true];

	_group addEventHandler ["EnemyDetected", {
		params ["_group", "_newTarget"];
		{ if !(local _x && {(_unit getvariable ["RNG_cooldown",(time -1)]) > time}) then {continue};
		  if (_x isKindOf "Logic") then {continue};
		  if (_x getvariable ["RNG_disabled",false]) then {continue};
		  if (vehicle _x isNotEqualTo _x) exitWith {_x setvariable ["RNG_cooldown",(time + 10)];};
		if (currentWeapon _x isEqualTo binocular _x) then {
			_x selectWeapon primaryWeapon _x;
		};
		  [_x,_newTarget] call RNG_fnc_react;
		} foreach units _group;
	}];

	if (RNG_dontKnowsAbout) then {
		_group addEventHandler ["KnowsAboutChanged", {
			params ["_group", "_targetUnit", "_newKnowsAbout", "_oldKnowsAbout"];
			if !(RNG_dontKnowsAbout) exitWith {};
			private _reveal = RNG_dontKnowsCap;
			if !( _newKnowsAbout > _reveal ) exitWith {};
			private _list = [];
			private _vis = [];
			private _targetPos = AGLToASL (unitAimPositionVisual _targetUnit);
			{	private _eye = eyepos _x;
				_list pushBack [_eye, _targetPos, _unit, _targetUnit]; 
				_vis pushBack (([_unit, "VIEW", _targetUnit] checkVisibility [_eye,_targetPos]) > RNG_minVisTarget);
			} forEach (units _group);
			private _i = -1;
			private _result = (lineIntersectsSurfaces [_list]) apply { _i = _i + 1;(_vis select _i) && { ((((_x select 0) select 1) select 2) isEqualTo 1) } };
			if !( true in _result ) then {
				_group forgetTarget _targetUnit;
				_group reveal [_targetUnit,_reveal];
			};
		}];
	};

	//_group spawn VCM_fnc_UseEM;
};

_man addMPEventHandler ["MPRespawn", {
	params ["_unit", "_corpse"];
	if !(local _unit) exitWith {};
	_unit enableai "PATH";
	_unit enableai "MOVE";
	_unit enableai "FSM";
	_unit enableai "COVER";
	_unit enableai "AIMINGERROR";
	_unit setvariable ["RNG_incombat",nil];
	_unit setvariable ["RNG_cover",nil];
	_corpse setvariable ["RNG_incombat",nil];
	_corpse setvariable ["RNG_cover",nil];
	_corpse setvariable ["RNG_active",nil];
}];

if (RNG_disableAccuracy) exitWith {};
_man addEventHandler ["Fired", { 
 params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"]; 
 if (!isplayer _unit && {!(missionnamespace getvariable ["RNG_off",false]) && {!(_unit getvariable ["RNG_disabled",false])}}) then { 
 _amount=0.1 - ((_unit skillFinal "aimingAccuracy")*0.1); 
 _speed=(velocityModelSpace _projectile) select 1; 
 _projectile setVectorDirAndUp [[((vectordir _projectile) select 0) + (random _amount) - (random _amount),((vectordir _projectile) select 1) + (random _amount) - (random _amount),((vectordir _projectile) select 2)  + (random _amount) - (random _amount)], [((vectorup _projectile) select 0)  + (random _amount) - (random _amount),((vectorup _projectile) select 1)   + (random _amount) - (random _amount),((vectorup _projectile) select 2)   + (random _amount) - (random _amount)]]; 
 _projectile setVelocityModelSpace [0,_speed,0]; 
 }; 
}]; 
};
