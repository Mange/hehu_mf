#include "script_component.hpp"

private ["_logic", "_units", "_activated", "_refreshInterval", "_precision", "_autoHide"];

_logic     = param [0, objNull, [objNull]];
_units     = param [1, [], [[]] ];
_activated = param [2, true, [true]];

if (_activated) then {
	// Only players should see this at all!
	if (isDedicated) exitWith {};

	// Give level a chance to start up properly.
	sleep 5;

	// If no units at all are selected, add to all players.
	if (count _units == 0 || player in _units) then {
		_refreshInterval = (_logic getVariable "RefreshInterval");
		_precision = (_logic getVariable "Precision");
		_autoHide = (_logic getVariable "AutoHide");

		[_refreshInterval, _precision, _autoHide] spawn DFUNC(targetCounter);
	};
};

true
