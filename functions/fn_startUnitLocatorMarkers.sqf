private [
	"_precision", "_interval", "_numberOfUnits", "_locateUnits",
	"_drawMarkerFollowingUnit", "_createUnitMarker", "_findUnits",
	"_marker", "_radius", "_randomization", "_locatedUnits"
];

_precision     = _this select 0;
_interval      = _this select 1;
_numberOfUnits = _this select 2;
//_type        = _this select 3;
_locateUnits   = _this select 4;

_radius = switch(_precision) do {
	case 1: { 0 }; // Exact
	case 2: { 2 }; // Accurate
	case 3: { 8 }; // Inaccurate
	case 4: { 20 }; // Very inaccurate
	default { 0 };
};

_randomization = _radius * 0.4;

_findUnits = switch(_locateUnits) do {
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


_drawMarkerFollowingUnit = {
	private ["_unit", "_marker", "_interval", "_outline", "_isOutsideRadius", "_newPosition", "_condition", "_radius", "_randomization"];
	_unit          = _this select 0;
	_condition     = _this select 1;
	_interval      = _this select 2;
	_marker        = _this select 3;
	if (count _this > 4) then {
		_outline       = _this select 4;
		_radius        = _this select 5;
		_randomization = _this select 6;
	};

	// Stop following unit when it no longer should be selected, or when dead
	while { alive _unit && (_condition count [_unit]) > 0 } do {
		if (!isNil "_outline") then {
			_isOutsideRadius = (getMarkerPos _outline) distance _unit > _radius;
			if (_isOutsideRadius) then {
				// Determine new position and randomize it a bit.
				_newPosition = [position _unit, _randomization] call HEHU_MF_fnc_randomizePosition;
				_marker setMarkerPosLocal _newPosition;
				_outline setMarkerPosLocal _newPosition;
			};
		} else {
			_marker setMarkerPosLocal position _unit;
		};
		sleep _interval;
	};

	deleteMarkerLocal _marker;
	if (!isNil "_outline") then {
		deleteMarkerLocal _outline;
	};
	_unit setVariable ["hehu_unit_marker", nil];
};

_createUnitMarker = {
	private ["_unit", "_color", "_marker", "_markerOutline", "_condition"];
	_unit = _this select 0;
	_condition = _this select 1;

	if (isPlayer _unit) exitWith {};

	_marker = _unit getVariable "hehu_unit_marker";
	if (isNil "_marker" && alive _unit) then {
		_color = [side _unit, true] call BIS_fnc_sideColor;

		_marker = createMarkerLocal [format["hehu_unit_marker %1", _unit], position _unit];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_dot_noShadow";
		_marker setMarkerColorLocal _color;

		_unit setVariable ["hehu_unit_marker", _marker];

		if (_radius > 0) then {
			_markerOutline = createMarkerLocal [format["hehu_unit_marker_outline %1", _unit], position _unit];
			_markerOutline setMarkerShapeLocal "ELLIPSE";
			_markerOutline setMarkerSizeLocal [_radius, _radius];
			_markerOutline setMarkerBrushLocal "SolidBorder";
			_markerOutline setMarkerColorLocal _color;
			_markerOutline setMarkerAlphaLocal 0.5;

			[_unit, _condition, _interval, _marker, _markerOutline, _radius, _randomization] spawn _drawMarkerFollowingUnit;
		} else {
			[_unit, _condition, _interval, _marker] spawn _drawMarkerFollowingUnit;
		};

	};
};

// TODO: Stop showing markers when unit count becomes greater, and resume again when unit count is once again under.
sleep 2; // Give the level time to spawn units.
waitUntil { _findUnits count allUnits <= _numberOfUnits };

_locatedUnits = [allUnits, _findUnits] call CBA_fnc_select;
while { count _locatedUnits > 0 } do {
	{ [_x, _findUnits] call _createUnitMarker; } foreach _locatedUnits;
	sleep _interval;
	_locatedUnits = [allUnits, _findUnits] call CBA_fnc_select;
};