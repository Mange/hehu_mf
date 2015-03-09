private ["_logic", "_activated", "_number", "_alertness", "_areas", "_spawns", "_combatMode", "_patrols"];

_logic     = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_activated = [_this, 2, true, [true]] call BIS_fnc_param;

if (_activated) then {
	_number = (_logic getVariable "NumberOfEnemies");
	_alertness = (_logic getVariable "EnemyAlertness");

	_areas = [];
	{
		if (_x isKindOf "LocationArea_F") then {
			_areas = _areas + [_x];
		};
	} forEach (synchronizedObjects _logic);

	// TODO: Load global config in a better way
	if (_number < 1) then { _number = 5; };
	if (_alertness < 1) then { _alertness = 0; };

	// TODO: Resolve values in a better way
	_combatMode = "YELLOW";
	_patrols = 0;

	switch(_alertness) do {
		// Stand still
		case 0: { _combatMode = "YELLOW"; _patrols = 0; };
		// Respond to threats
		case 1: { _combatMode = "RED"; _patrols = 0; };
		// Some will look for you
		case 2: { _combatMode = "RED"; _patrols = _number * 0.3; };
		// Most will look for you
		case 3: { _combatMode = "RED"; _patrols = _number * 0.6; };
		// All will look for you
		case 4: { _combatMode = "RED"; _patrols = _number; };
	};

	_spawns = [_areas] call HEHU_CQB_fnc_getSpawns;
	[_spawns, _number, _patrols, _combatMode] call HEHU_CQB_fnc_spawn;
};

true