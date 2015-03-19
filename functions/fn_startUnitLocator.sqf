private ["_type"];
if (!hasInterface) exitWith {}; // Only players need to run this script.
waitUntil {!isNull player}; // Wait for map to load first

_type = _this select 1;

switch(_type) do {
	case 1: { _this spawn HEHU_MF_fnc_startUnitLocatorMarkers; };
};