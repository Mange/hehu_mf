private ["_logic", "_players", "_activated", "_precision", "_interval", "_numberOfUnits", "_type", "_locateUnits"];

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_players = [_this, 1, [], [[]]] call BIS_fnc_param;
_activated = [_this, 2, true, [true]] call BIS_fnc_param;

if (_activated) then {
	// Load options
	_precision = _logic getVariable "Precision";
	_interval = _logic getVariable "RefreshInterval";
	_numberOfUnits = _logic getVariable "NumberOfUnits";
	_type = _logic getVariable "LocatorType";
	_locateUnits = _logic getVariable "LocateUnits";

	if (count _players == 0 || player in _players) then {
		if (_numberOfUnits == 0) then { _numberOfUnits = 9999; };
		[_precision, _interval, _numberOfUnits, _type, _locateUnits] call HEHU_MF_fnc_startUnitLocator;
	}
};