#include "script_component.hpp"

private ["_spawns", "_settings", "_numberOfUnits", "_enemyPatrols", "_enemyCombatMode", "_spawn", "_position", "_soldierType", "_patrolPositions"];

_spawns = _this select 0;
_settings = _this select 1;

_numberOfUnits = _settings select 0;
_enemyCombatMode = _settings select 1;
_enemyPatrols = _settings select 2;

if (count _spawns < _numberOfUnits) then {
	_numberOfUnits = count _spawns;
};

for "_i" from 0 to (_numberOfUnits - 1) do {
	_spawn = _spawns select _i;

    _position = _spawn select 0;
    _soldierType = _spawn select 1;
    _patrolPositions = _spawn select 2;
    _placementSpecial = _spawn param [3, "NONE", [""]];

    _unit = [_soldierType, _position, _placementSpecial] call DFUNC(spawnCQBUnit);
    _unit setCombatMode _enemyCombatMode;

    if (_i < _enemyPatrols) then {
    	[_unit, _position, _patrolPositions] call DFUNC(setupPatrol);
    };

    sleep 0.1;
};
