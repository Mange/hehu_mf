#include "script_component.hpp"

private ["_logic", "_numberOfUnits", "_alertnessNumber", "_combatMode", "_patrols"];
_logic = param [0, objNull, [objNull]];

if (!isNull _logic) then {
	/* Read number of enemies */
	_numberOfUnits = (_logic getVariable "NumberOfUnits");

	if (isNil "_numberOfUnits" || _numberOfUnits < 1) then {
		// Try to read from global variable, then from mission parameters
		if (!isNil "HEHU_CQB_unit_count") then {
			_numberOfUnits = HEHU_CQB_unit_count;
		} else {
			_numberOfUnits = ["NumberOfUnits", 10] call BIS_fnc_getParamValue;
		};
	};

	/* Calculate alertness (combat mode, patrols) */
	_alertnessNumber = (_logic getVariable "UnitAlertness");

	if (_alertnessNumber < 1) then {
		// Try to read from global variable, then from mission parameters
		if (!isNil "HEHU_CQB_alertness") then {
			_alertnessNumber = HEHU_CQB_alertness;
		} else {
			_alertnessNumber = ["UnitAlertness", 0] call BIS_fnc_getParamValue;
		};
	};

	_combatMode = "YELLOW";
	_patrols = 0;

	switch(_alertnessNumber) do {
		// Stand still
		case 0: { _combatMode = "YELLOW"; _patrols = 0; };
		// Respond to threats
		case 1: { _combatMode = "RED"; _patrols = 0; };
		// Some will look for you
		case 2: { _combatMode = "RED"; _patrols = _numberOfUnits * 0.3; };
		// Most will look for you
		case 3: { _combatMode = "RED"; _patrols = _numberOfUnits * 0.6; };
		// All will look for you
		case 4: { _combatMode = "RED"; _patrols = _numberOfUnits; };
	};

	/* Return finished settings */
	[_numberOfUnits, _combatMode, _patrols]
}
