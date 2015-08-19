private ["_logic", "_players", "_activated", "_moduleActivated"];

_logic     = param [0, objNull, [objNull]];
_players   = param [1, [], [[]]];
_activated = param [2, true, [true]];

/*
In order to support this module becoming deactivated after the fact, and then activated again, we'll spawn a script in the
background once and then communicate with it by using a variable attached to the game logic.
*/

// Determine if the script has been spawned before.
_moduleActivated = _logic getVariable "HEHU_ModuleActivated";

// Update module status for the script.
_logic setVariable ["HEHU_ModuleActivated", _activated];

// Script is not spawned. Spawn it now!
if (isNil "_moduleActivated") then {
	private ["_precision", "_interval", "_numberOfUnits", "_type", "_locateUnits", "_unitFilter"];
	// Load options
	_precision = _logic getVariable "Precision";
	_interval = _logic getVariable "RefreshInterval";
	_numberOfUnits = _logic getVariable "NumberOfUnits";
	_type = _logic getVariable "LocatorType";
	_locateUnits = _logic getVariable "LocateUnits";

	if (count _players == 0 || player in _players) then {
		if (_numberOfUnits == 0) then { _numberOfUnits = 9999; };

		_unitFilter = switch(_locateUnits) do {
			// Non-players
			case 1: { { !isPlayer _x } };

			// Players
			case 2: { { isPlayer _x } };

			// Enemies
			case 3: { { _x call HEHU_MF_fnc_isEnemyToPlayer } };

		 	// Civilians
			case 4: { { side _x == civilian } };

		 	// West
			case 5: { { side _x == west } };

		 	// East
			case 6: { { side _x == east } };

		 	// Ind
			case 7: { { side _x == independent } };

			// Everyone
			case 8: { { true } };

			default { { true } };
		};

		[_logic, _type, _precision, _interval, _numberOfUnits, _unitFilter] spawn HEHU_MF_fnc_startUnitLocator;
	};
};
