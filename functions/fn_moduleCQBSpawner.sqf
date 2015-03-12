private ["_logic", "_activated", "_areas", "_settings", "_spawns"];

_logic     = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_activated = [_this, 2, true, [true]] call BIS_fnc_param;

if (_activated) then {
	_areas = [(synchronizedObjects _logic), { _x isKindOf "LocationArea_F" }] call CBA_fnc_select;

	_settings = [_logic] call HEHU_MF_fnc_getSpawnerSettings;
	_spawns = [_areas] call HEHU_MF_fnc_getSpawns;

	[_spawns, _settings] call HEHU_MF_fnc_spawn;
};

true