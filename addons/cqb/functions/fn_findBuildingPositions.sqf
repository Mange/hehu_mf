#include "script_component.hpp"

private ["_positions", "_triggers", "_buildingsInTrigger"];
_triggers = _this;
_positions = [];

{
	_buildingsInTrigger = [_x] call DFUNC(findBuildings);
	{
		_positions append ([_x] call BIS_fnc_buildingPositions);
	} foreach _buildingsInTrigger;
} foreach (_triggers);

_positions
