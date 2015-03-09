private ["_logic", "_units", "_activated", "_refreshInterval", "_precision", "_autoHide"];

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_units = [_this, 1, [], [[]]] call BIS_fnc_param;
_activated = [_this, 2, true, [true]] call BIS_fnc_param;

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

		[_refreshInterval, _precision, _autoHide] spawn HEHU_CQB_fnc_targetCounter;
	};
};

// Module function is executed by spawn command, so returned value is not necessary.
// However, it's a good practice to include one.
true