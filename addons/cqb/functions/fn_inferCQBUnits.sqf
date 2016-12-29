#include "script_component.hpp"

/*
 * Infer units to be placed by CQB module.
 * Do this by looking at the units synchronized to passed game logic and remove them from the mission.
 *
 * If no units are synchronized to it, fall back to a simple default.
 */
private ["_default", "_gameLogic", "_units"];
_gameLogic = _this select 0;

_default = ["O_soldier_F"];
_units = [];

{
	if (_x isKindOf "Man") then {
		_units pushBack typeOf _x;
		deleteVehicle _x;
	};
} foreach (synchronizedObjects _gameLogic);

if (count _units > 0) then { _units } else { _default }
