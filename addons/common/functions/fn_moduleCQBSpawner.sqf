private ["_logic", "_activated", "_bases", "_areas", "_settings", "_spawns"];

_logic     = param [0, objNull, [objNull]];
_activated = param [2, true, [true]];

if (!(isNull _logic) && _activated) then {
	_bases = [(synchronizedObjects _logic), { _x isKindOf "LocationBase_F" }] call CBA_fnc_select;
	_areas = [(synchronizedObjects _logic), { _x isKindOf "LocationArea_F" }] call CBA_fnc_select;

	_settings = [_logic] call HEHU_MF_fnc_getSpawnerSettings;

	_spawns = [_settings, _bases, _areas] call HEHU_MF_fnc_getSpawns;

	[_spawns, _settings] call HEHU_MF_fnc_spawn;
};

true