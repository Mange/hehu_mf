private ["_type"];
if (!hasInterface) exitWith {}; // Only players need to run this script.
waitUntil {!isNull player}; // Wait for map to load first

_type = _this select 1;

// Backwards compatible; older versions specified precision as single numerical steps instead of values. Convert old step values.
_precision = _this select 2;
if (_precision > 0 && _precision < 5) then {
	// This switch..case corresponds with the old defaults.
	_precision = switch(_precision) do {
		case 1: { 0 }; // Exact
		case 2: { 2 }; // Accurate
		case 3: { 8 }; // Inaccurate
		case 4: { 20 }; // Very inaccurate
		default { 0 };
	};
	_this set [3, _precision];
};

switch(_type) do {
	case 1: { _this spawn HEHU_MF_fnc_startUnitLocatorMarkers; };
};