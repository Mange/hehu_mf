private ["_logic", "_numberOfEnemies", "_alertnessNumber", "_combatMode", "_patrols"];
_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;


/* Read number of enemies */
_numberOfEnemies = (_logic getVariable "NumberOfEnemies");

if (isNil "_numberOfEnemies" || _numberOfEnemies < 1) then {
	// Try to read from global variable, then from mission parameters
	if (!isNil "HEHU_CQB_defaultNumberOfEnemies") then {
		_numberOfEnemies = HEHU_CQB_defaultNumberOfEnemies;
	} else {
		_numberOfEnemies = ["NumberOfEnemies", 10] call BIS_fnc_getParamValue;
	};
};

/* Calculate alertness (combat mode, patrols) */
_alertnessNumber = (_logic getVariable "EnemyAlertness");

if (_alertnessNumber < 1) then {
	// Try to read from global variable, then from mission parameters
	if (!isNil "HEHU_CQB_defaultAlertnessNumber") then {
		_alertnessNumber = HEHU_CQB_defaultAlertnessNumber;
	} else {
		_alertnessNumber = ["EnemyAlertness", 0] call BIS_fnc_getParamValue;
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
	case 2: { _combatMode = "RED"; _patrols = _numberOfEnemies * 0.3; };
	// Most will look for you
	case 3: { _combatMode = "RED"; _patrols = _numberOfEnemies * 0.6; };
	// All will look for you
	case 4: { _combatMode = "RED"; _patrols = _numberOfEnemies; };
};

/* Return finished settings */
[_numberOfEnemies, _combatMode, _patrols]