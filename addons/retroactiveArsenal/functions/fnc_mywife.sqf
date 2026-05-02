params [['_wifes',['Beaglerush','Beagle','Jamball'],[]]];

if !(canSuspend) exitWith {_this spawn mjb_arsenal_fnc_mywife};

private _user = name player;
if !(_user in _wifes) exitWith {};
private _wife = ((_wifes - [_user]) select 0);
private _getWife = (call BIS_fnc_listPlayers select {name _x isEqualTo _wife});
if ((count _getWife) < 1) exitWith {};
private _unit = (_getWife select 0);
private _moved = false;
if !(isNull objectParent player) then {
	_moved = _unit moveInAny (vehicle player);
};
if !(_moved) then {	
	private _pos = [0,0,0];
	private _timeout = 0;
	while {_timeout < 100 && {_pos isEqualTo [0,0,0]}} do {
		_pos = [player, 1, 10, 1, 1, 5.0, 0, [],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		_timeout = _timeout + 1;
		sleep 0.01;
	};
	if (_timeout >= 100) exitWith {systemChat 'Failed to find safe position for mywife.'};
	_unit setPos _pos;
};