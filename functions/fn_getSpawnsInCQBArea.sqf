private ["_logic", "_count", "_soldierTypes", "_triggers", "_i", "_positions", "_position", "_unitType", "_patrolPositions"];
_logic = _this select 0;
_count = _this select 1;

_soldierTypes = [_logic] call HEHU_MF_fnc_inferCQBUnits;

// Find triggers attached to this game logic
_triggers = [(synchronizedObjects _logic), { _x isKindOf "EmptyDetector" }] call CBA_fnc_select;

// Find possible positions; <count> positions in each trigger.
_positions = [];
{
	for "_i" from 1 to _count do {
		_positions = _positions + [([_x] call BIS_fnc_randomPosTrigger)];
	};
} foreach _triggers;

//
// Build up spawns
//
[_positions, {
	_position = _x;
	_unitType = _soldierTypes call BIS_fnc_selectRandom;
	// Patrol points will be to two random positions inside the triggers.
	_patrolPositions = [
		[(_triggers call BIS_fnc_selectRandom)] call BIS_fnc_randomPosTrigger,
		[(_triggers call BIS_fnc_selectRandom)] call BIS_fnc_randomPosTrigger
	];

	[_position, _unitType, _patrolPositions]
}] call CBA_fnc_filter
