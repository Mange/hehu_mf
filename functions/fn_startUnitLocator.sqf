private ["_type"];
if (isDedicated) exitWith {}; // Headless servers need no unit locators.

_type = _this select 3;

switch(_type) do {
	case 1: { _this spawn HEHU_MF_fnc_startUnitLocatorMarkers; };
};