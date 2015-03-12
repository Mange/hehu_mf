private ["_logic", "_soldierTypes", "_triggers", "_positions", "_position", "_unitType", "_patrolPositions"];
_logic = _this;

_soldierTypes = [_logic] call HEHU_MF_fnc_inferEnemyUnits;

// Find triggers attached to this game logic
_triggers = [(synchronizedObjects _logic), { _x isKindOf "EmptyDetector" }] call CBA_fnc_select;

// Find possible positions
_positions = _triggers call HEHU_MF_fnc_findBuildingPositions;

//
// Build up spawns
//
[_positions, {
	_position = _x;
	_unitType = _soldierTypes call BIS_fnc_selectRandom;
	// Patrol points will be to two random positions inside the same logic areas.
	_patrolPositions = [
		(_positions call BIS_fnc_selectRandom),
		(_positions call BIS_fnc_selectRandom)
	];

	[_position, _unitType, _patrolPositions]
}] call CBA_fnc_filter
