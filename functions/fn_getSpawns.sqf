private ["_logics", "_spawns"];

_logics = _this select 0;

_spawns = [
	_logics, [],
	{
		_accumulator + (_x call HEHU_MF_fnc_getSpawnsInLogic)
	}
] call CBA_fnc_inject;

[_spawns] call CBA_fnc_shuffle
