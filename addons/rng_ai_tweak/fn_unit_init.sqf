//RNG AI by Toksa
if (isNil 'RNG_ANIM_Tact') then {
	RNG_ANIM_Tact=[
	"TactRF",
	"TactLF",
	"TactF",
	"TactB",
	"TactRB",
	"TactLB",
	"TactR",
	"TactL"];
	RNG_ANIM_Run=[
	"FastRF",
	"FastLF",
	"FastF",
	"FastB",
	"FastRB",
	"FastLB",
	"FastR",
	"FastL"];
};
_man = _this select 0;
_group = group _man;

_sideman = str (side _man);

if (RNG_sides isEqualTo _sideman || { ((missionnamespace getvariable ["RNG_sides","ALL"]) isEqualTo "ALL") } ) then {
	
_man setvariable ["RNG_active",true];

_man addEventHandler ["FiredNear", {
	params ["_unit", "_firer", "_distance", "_weapon"];
	if !(local _unit && {(_unit getvariable ["RNG_cooldown",(time -1)]) > time}) exitWith {};
	if (_unit isEqualTo _firer || {_weapon isEqualTo 'Throw'}) exitWith {};
	if ((vehicle _unit) isNotEqualTo _unit) exitWith {_unit setvariable ["RNG_cooldown",(time + 10)];};
	if ((side _firer) isEqualTo (side _unit) && {(random 1) > RNG_allyReactChance}) exitWith { if (RNG_allyCD) then {_unit setvariable ['RNG_cooldown',(time + 2)];}; };
	[_unit,_firer] call RNG_fnc_react;
}];

if (!(isClass(configFile >> "CfgPatches" >> "ace_medical_engine"))) then {
	_man addEventHandler ["HandleDamage", { 
		params ["_unit", "", "_damage", "_source", "", "", "_instigator"]; 
		if ((isNull _instigator && {_source isEqualTo _unit}) OR {(!(isplayer _source) && {!(side _source isEqualTo sideEnemy) && {(side _unit isEqualTo side _source)}})}) then {_damage = 0};
		_damage;
	}];
};

if (local _man) then {
	_man addEventHandler ["Suppressed", {
		params ["_unit", "", "_shooter"];
		[_unit,_shooter] call RNG_fnc_react;
	}];
};
_man addEventHandler ["Local", {
	params ["_entity", "_isLocal"];
	if (!_isLocal) exitWith {};
    _entity addEventHandler ["Suppressed", {
		params ["_unit", "", "_shooter"];
		[_unit,_shooter] call RNG_fnc_react;
	}];
}];

if (!(_group getvariable ["RNG_group_active",false])) then {
_group setvariable ["RNG_group_active",true];
_group addEventHandler ["EnemyDetected", {
	params ["_group", "_newTarget"];
	{ if !(local _x && {(_unit getvariable ["RNG_cooldown",(time -1)]) > time}) then {continue};
	  if (vehicle _x isNotEqualTo _x) exitWith {_x setvariable ["RNG_cooldown",(time + 10)];};
      [_x,_newTarget] call RNG_fnc_react;
    } foreach units _group;
}];
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
