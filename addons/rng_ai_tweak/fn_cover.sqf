//RNG AI by Toksa
_unit=_this select 0;
_firer=_this select 1;
if (isplayer _unit OR {(_unit getvariable ["RNG_disabled",false]) OR {(missionnamespace getvariable ["RNG_off",false])}}) exitwith {};
_unit setvariable ["RNG_incombat",true];
_unit setvariable ["RNG_cover",true];
_exit=false;
_types=["AGR","DFS","RND","FRM"];
_type=selectrandom _types;
_pos=[0,0,0];
_unit disableai "PATH";
_unit disableai "MOVE";
_unit disableai "ANIM";
_unit disableai "COVER";
_unit disableai "FSM";
_unit disableai "AIMINGERROR";
_target=_firer;
_anims=RNG_ANIM_Run;
_objects=[];
_starttime=time;
_cancrouch=true;
if (!(unitPos _unit isEqualTo "Auto")) then {_cancrouch=false;};
if (_cancrouch) then {
_stance=selectrandom ["Up","Crouch","Down"];
if (!((unitpos _unit) isEqualTo _stance)) then {
_unit playactionnow _stance;
};
	switch (true) do {
	  case (_stance isEqualTo "Up"): {_unit setunitpos "Up"};
    case (_stance isEqualTo "Crouch"): {_unit setunitpos "Middle"};
	case (_stance isEqualTo "Down"): {_unit setunitpos "Down"};
	};
};
_time=time + 4;
_unit playactionnow (_anims select 0);
//// Find Pos
	_targetpos= objNull;
	_objectsDyn=nearestObjects [_unit, ["Wall","fence","Strategic","house"], 60];
	_objects=nearestTerrainObjects [_unit, ["Tree", "Bush","Wall","fence","Rock","house","Static","Thing","Building"], 60];
	_objects append _objectsDyn;
	if (!isnull _target) then {
		_sortedobjects= [_objects,[],{_unit distance _x},"ASCEND",{_target distance _x > _unit distance _x}] call BIS_fnc_sortBy;
		if (count _sortedobjects > 0) then {
			_targetpos=_sortedobjects select 0;
		};
	} else {
	_targetpos=[_objects,getpos _target] call BIS_fnc_nearestPosition;
	};
	if (_targetpos isEqualTo [0,0,0]) exitWith {
		_unit setvariable ["RNG_incombat",false];
		_unit setvariable ["RNG_cover",false];
		_unit setvariable ["RNG_cooldown",(time + 3)];
	};
	_line=lineIntersectsSurfaces [[(aimpos _unit) select 0,(aimpos _unit) select 1,((aimpos _unit) select 2) - 0.5], getposASL _targetpos, _unit, objNull, true, 1,"FIRE"];
if (!((count _line) isEqualTo 0)) then {
	_pos=(_line select 0) select 0; 
};
if (isNil "_pos" OR {(_pos isequalto [0,0,0])}) then {
			_leftpos=lineIntersectsSurfaces [aimPos _unit,(AGLtoASL (_unit getrelpos [20,270])), _unit, objNull, true, 1,"FIRE"];
			_rightpos=lineIntersectsSurfaces [aimPos _unit,(AGLtoASL (_unit getrelpos [20,90])), _unit, objNull, true, 1,"FIRE"];
			_backpos=lineIntersectsSurfaces [aimPos _unit,(AGLtoASL (_unit getrelpos [20,180])), _unit, objNull, true, 1,"FIRE"];
			_backposleft=lineIntersectsSurfaces [aimPos _unit,(AGLtoASL (_unit getrelpos [20,225])), _unit, objNull, true, 1,"FIRE"];
			_backposright=lineIntersectsSurfaces [aimPos _unit,(AGLtoASL (_unit getrelpos [20,135])), _unit, objNull, true, 1,"FIRE"];
			_pos = selectrandom [((_leftpos select 0) select 0),((_rightpos select 0) select 0),((_backpos select 0) select 0),((_backposright select 0) select 0),((_backposleft select 0) select 0)];	
};
while {alive _unit} do {
	if (time > _time) then {_exit=true};
	if (_exit OR {(lifestate _unit isEqualTo"INCAPACITATED") OR {(vehicle _unit isNotEqualTo _unit) OR {isplayer _unit OR {(isplayer (_unit getvariable ["bis_fnc_moduleremotecontrol_owner",objNull]))}}}}) exitwith {
		[_unit,_cancrouch,_target] spawn {
		_unit = _this select 0;
		_cancrouch = _this select 1;
		_target = _this select 2;
		_unit playactionnow "STOP";
		dostop _unit;
		_unit domove getpos _unit;
		_unit enableai "PATH";
		_unit enableai "MOVE";
		_unit enableai "ANIM";
		_unit enableai "FSM";
		_unit enableai "COVER";
		_unit dofollow leader _unit;
		_unit enableai "AIMINGERROR";
		if (_cancrouch) then {_unit setunitpos "Auto"};
		_unit setvariable ["RNG_incombat",false];
		_unit setvariable ["RNG_cover",false];
		_unit setvariable ["RNG_cooldown",(time + 6)];
		if (!isNull _target && {vehicle _target iskindof "Tank"}) then {
			_unit setvariable ["RNG_cooldown",(time + 4)];
			};
		sleep 1;
		};
	};
	if (!isNil "_pos" && {(_pos isNotEqualTo [0,0,0])}) then {
	for "_i" from 1 to 10 do {
	_unit setVelocityTransformation
		[
			atltoasl (getposatl _unit),
			atltoasl (getposatl _unit),
			velocity _unit,
			[(velocity _unit) select 0,(velocity _unit) select 1,-1],
			vectordirvisual _unit,
			getposasl _unit vectorFromTo _pos,
			[0,0,1],
			[0,0,1],
			(_i*0.1)
		];
		_unit setvectorup [0,0,1];
		sleep 0.08;
	};
};

if (!isNil "_pos" && {((_unit distance2D _pos) < 100)}) then {
	switch (true) do {
    case ((_unit distance2D _pos)< 2.5): {_unit playactionnow "stop";_exit=true;};
    case ((_unit getreldir _pos) < 67.5 && {(_unit getreldir _pos) > 22.5}): {_unit playactionnow (_anims select 0)};
    case ((_unit getreldir _pos) < 342.5 && {(_unit getreldir _pos) > 297.5}): {_unit playactionnow (_anims select 1);};
    case ((_unit getreldir _pos) < 22.5 OR (_unit getreldir _pos) > 342.5): {_unit playactionnow (_anims select 2);};
    case ((_unit getreldir _pos) < 202.5 && {(_unit getreldir _pos) > 157.5}): {_unit playactionnow (_anims select 3);};
    case ((_unit getreldir _pos) < 157.5 && {(_unit getreldir _pos) > 112.5}): {_unit playactionnow (_anims select 4);};
    case ((_unit getreldir _pos) < 247.5 && {(_unit getreldir _pos) > 202.5}): {_unit playactionnow (_anims select 5);};
    case ((_unit getreldir _pos) < 112.5 && {(_unit getreldir _pos) > 67.5}): {_unit playactionnow (_anims select 6);};
    case ((_unit getreldir _pos) < 292.5 && {(_unit getreldir _pos) > 247.5}): {_unit playactionnow (_anims select 7);};
};
	} else {
		_unit playactionnow "stop";
		_unit setVelocity [0, 0, 0];
	};
	if ((time - _starttime) % 1 > 0.5) then {
		if (("run" in animationstate _unit OR {"evas" in animationstate _unit}) && {((vectorMagnitude (velocityModelSpace _unit)) < 1)}) then {_unit playactionnow "stop";_unit setVelocity [0, 0, 0];};
	};

sleep 0.02;
};
if !(alive _unit) then {
	_unit setvariable ["RNG_incombat",nil];
	_unit setvariable ["RNG_cover",nil];
	_unit setvariable ["RNG_cooldown",nil];
	_unit setvariable ["RNG_active",nil];
};