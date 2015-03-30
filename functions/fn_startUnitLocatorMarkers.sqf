/*
Unit markers are updated using three passes:
	- Activation pass
	- Garbage collection pass
	- Marker moving pass

Activation pass determines if the module should be active or not (by looking at the module game logic, and the _numberOfUnits and _unitFilter variables).
	"Activated" units will have a marker attached to them (if not already). Inactive units will have their markers destroyed (if present).
	Markers will be saved to a list when created, along with their unit (for pass 2). The marker name will also be attached to the unit (using setVariable) so we can quickly see if a unit already has a marker (for the next pass).

Garbage collection pass will look at all the markers spawned by this module and see if their units are dead or not. If the unit is dead, the marker will be destroyed and removed from the list.

Third pass is the marker moving pass. In this pass, all the markers are moved according to the precision, etc.

The three passes facilitates the following properties:
	1. We don't need to create new markers all the time.
	2. If module is deactivated, the markers will disappear automatically.
	3. Newly spawned units will have their markers added.
	4. Killed units will have their markers removed.
	5. Units switching side might have their marker removed, or created, depending on the types of units that should get markers.
*/

private [
	"_logic", // Module entity; we need it to see if the module becomes deactivated later.
	"_uuid", // Randomly generated ID for namespacing global names (markers, unit variables, etc.)

	// Settings from the module, parsed and ready.
	"_precision", "_interval", "_numberOfUnits", "_unitFilter",

	"_radius", // Radius of the marker (depends on _precision).
	"_randomization", // Randomization for non-exact precisions (depends on _radius).

	"_markerVariableName", // Variable name where this script puts markers on units.

	// Private functions
	"_main", // Runs the three primary passes in a loop.
	"_activationPass",
	"_garbageCollect",
	"_updateMarkerPositions",
	"_createMarker",
	"_cleanupMarker",
	"_createNewUnitMarker",
	"_updateMarkerPosition"
];

_logic         = _this select 0;
//_type        = _this select 1;
_precision     = _this select 2;
_interval      = _this select 3;
_numberOfUnits = _this select 4;
_unitFilter    = _this select 5;

/// Initialize variables ///

_uuid = format ["%1-%2", _logic, random 5000];
_markerVariableName = format["%1-marker", _uuid];

_radius = switch(_precision) do {
	case 1: { 0 }; // Exact
	case 2: { 2 }; // Accurate
	case 3: { 8 }; // Inaccurate
	case 4: { 20 }; // Very inaccurate
	default { 0 };
};

_randomization = _radius * 0.4;

/// Methods ///

_main = {
	private ["_markers"];
	_markers = [];

	while { true } do {
		_markers = _markers call _activationPass;
		_markers = _markers call _garbageCollect;
		_markers call _updateMarkerPositions;
		sleep _interval;
	};
};

//
// Activation pass
// Go through all the units and create markers for them.
// Even this pass is being run in two passes: Collection and marking.
// 1. Collection happens first because we want to see if the unit count is large, as that might affect activation.
// 2. Marking is then being applied depending on the currect activation.
//
_activationPass = {
	private ["_activated", "_markers", "_activatedUnits", "_otherUnits"];
	_markers = _this;

	_moduleActivated = _logic getVariable ["HEHU_ModuleActivated", false];
	_activatedUnits = [];
	_otherUnits = [];

	// Optimization: No need to collect units if the module itself is actually disabled.
	if (_moduleActivated) then {
		{
			if (_x call _unitFilter) then {
				_activatedUnits pushBack [_x];
			} else {
				_otherUnits pushBack [_x];
			};
		} forEach allunits;
	};

	// Count the collected unit count and deactivate/activate depending on it.
	_activated = (_moduleActivated && count _activatedUnits <= _numberOfUnits);

	if (_activated) then {
		// Create markers where they don't exist.
		{ _markers = [_x, _markers] call _createMarker; } forEach _activatedUnits;

		// Markers will be cleaned up from the _markers array in the garbage collection phase after being destroyed here.
		{ [_x] call _cleanupMarker; } forEach _otherUnits;
	} else {
		// Module is deactivated. Destroy all the markers.
		{ [_x select 1, _x select 0] call _cleanupMarker; } forEach _markers;
	};

	_markers
};

//
// Garbage collection pass
// Go trough existing markers, destroying those for dead units. Remove the deleted rows from the list.
//
_garbageCollect = {
	private ["_marker", "_unit"];
	[_this, {
		_marker = _x select 0;
		_unit = _x select 1;

		// Is marker deleted?
		if (getMarkerColor _marker == "") then {
			false // Skip the row
		} else {
			if (!alive _unit) then {
				[_unit, _marker] call _cleanupMarker;
				false // Skip the row
			} else {
				true // Keep the row
			};
		};
	}] call CBA_fnc_select;
};

//
// Marker moving pass
// Move the existing markers to their new positions.
//
_updateMarkerPositions = {
	{ _x call _updateMarkerPosition } forEach _this;
};

// Actually create a new marker associated with the current unit. Will also create an outline marker with the same name, except with an "_outline" suffix, if necessary.
_createNewUnitMarker = {
	private ["_unit", "_color", "_marker", "_markerOutline", "_position"];
	_unit = _this select 0;

	_color = [side _unit, true] call BIS_fnc_sideColor;
	_marker = format["%1-%2-marker", _uuid, _unit];
	_markerOutline = format["%1-%2-marker_outline", _uuid, _unit];
	_position = position _unit;

	if (_radius > 0) then {
		_position = [_position, _randomization] call HEHU_MF_fnc_randomizePosition;
	};

	createMarkerLocal [_marker, _position];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_dot_noShadow";
	_marker setMarkerColorLocal _color;

	_unit setVariable ["hehu_unit_marker", _marker];

	if (_radius > 0) then {
		createMarkerLocal [_markerOutline, _position];
		_markerOutline setMarkerShapeLocal "ELLIPSE";
		_markerOutline setMarkerSizeLocal [_radius, _radius];
		_markerOutline setMarkerBrushLocal "SolidBorder";
		_markerOutline setMarkerColorLocal _color;
		_markerOutline setMarkerAlphaLocal 0.4;
	};

	_marker
};

// Create a marker if needed and append to the passed list. New/original list is returned depending on actual creation.
_createMarker = {
	private ["_unit", "_markers", "_marker"];
	_unit = _this select 0;
	_markers = _this select 1;

	_marker = _unit getVariable _markerVariableName;
	if (isNil "_marker") then {
		// Create the new marker object.
		_marker = [_unit] call _createNewUnitMarker;
		_unit setVariable [_markerVariableName, _marker];

		_markers + [[_marker, _unit]];
	} else {
		// Marker already exists; don't change the collection.
		_markers
	};
};

// Removes the marker from the game world and removes the unit variable pointing to it.
// Accepts either [unit] or [unit, marker]. It'll find the marker automatically through the unit if no marker passed.
_cleanupMarker = {
	private ["_marker", "_unit"];
	_unit = _this select 0;

	if (count _this > 1) then {
		_marker = _this select 1;
	} else {
		_marker = _unit getVariable _markerVariableName;
	};

	if (!isNil "_marker") then {
		_unit setVariable [_markerVariableName, nil];

		deleteMarkerLocal _marker;
		// Delete outline marker if activated
		if (_radius > 0) then { deleteMarkerLocal format["%1_outline", _marker]; };
	};
};

// Moves marker in [marker, unit] pair to its new positions. If outlines are activated, the movement logic will be different.
_updateMarkerPosition = {
	private ["_marker", "_unit", "_outline", "_isOutsideRadius", "_newPosition"];
	_marker = _this select 0;
	_unit = _this select 1;

	// If we have radius activated, the marker should only be moved when the unit leaves the radius.
	if (_radius > 0) then {
		_outline = format["%1_outline", _marker];
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
};

/// Start Main ///
call _main;