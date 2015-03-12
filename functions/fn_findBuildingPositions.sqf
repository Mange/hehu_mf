private ["_positions", "_triggers", "_buildingsInTrigger"];
_triggers = _this;
_positions = [];

{
	_buildingsInTrigger = [_x] call HEHU_MF_fnc_findBuildings;
	{
		_positions = _positions + ([_x] call BIS_fnc_buildingPositions);
	} foreach _buildingsInTrigger;

} foreach (_triggers);

_positions