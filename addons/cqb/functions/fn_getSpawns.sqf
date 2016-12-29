#include "script_component.hpp"

private ["_settings", "_bases", "_areas", "_spawns", "_count"];

_settings = _this select 0;
_bases    = _this select 1;
_areas    = _this select 2;

// Load spawnees for bases (positions inside the buildings inside the triggers)
// Bases get all available building positions.
_spawns = [];

{
	_spawns append (_x call DFUNC(getSpawnsInCQBBase))
} foreach _bases;

// Load spawnees for areas (random positions inside the triggers)
// Areas get as many positions as we should spawn in total, per trigger area.
_count	= _settings select 0;
{
   _spawns append ([_x, _count] call DFUNC(getSpawnsInCQBArea))
} foreach _areas;

[_spawns] call CBA_fnc_shuffle
