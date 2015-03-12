private ["_totalEnemies", "_refreshInterval", "_precision", "_autoHide", "_showHint", "_showTargetCounter"];

_refreshInterval = [_this, 0, 2, [1.0]] call BIS_fnc_param;
_precision       = [_this, 1, 1, [1]] call BIS_fnc_param;
_autoHide        = [_this, 2, false, [false]] call BIS_fnc_param;

_showText = {
	hintSilent parseText format _this;
};

_showTargetCounter = switch(_precision) do {
	// Exact
	case 1: {
		{
			if (_this == 0) then {
				["<t color='#ff0000'>NO</t> ENEMY UNITS LEFT"] call _showText;
			} else {
				if (_this == 1) then {
					["ONLY <t color='#ff0000'>1</t> ENEMY UNIT LEFT"] call _showText;
				} else {
					["THERE ARE <t color='#ff0000'>%1</t> ENEMY UNITS LEFT", _this] call _showText;
				};
			};
		};
	};
	// Inexact
	case 2: {
		{
			if (_this == 0) then {
				["<t color='#ff0000'>NO</t> ENEMY UNITS LEFT"] call _showText;
			} else {
				if (_this < 4) then {
					["ONLY <t color='#ff0000'>A FEW</t> ENEMY UNITS LEFT"] call _showText;
				} else {
					if (_this < 8) then {
						["THERE ARE <t color='#ff0000'>SOME</t> ENEMY UNITS LEFT"] call _showText;
					} else {
						["THERE ARE <t color='#ff0000'>A LOT</t> OF ENEMY UNITS LEFT"] call _showText;
					};
				};
			};
		};
	};
	// Unhelpful
	case 3: {
		{
			if (_this == 0) then {
				["<t color='#ff0000'>NO</t> ENEMY UNITS LEFT"] call _showText;
			} else {
				["<t color='#ff0000'>STILL SOME</t> ENEMY UNITS LEFT"] call _showText;
			};
		};
	};
};


while {true} do {
	_totalEnemies = [] call HEHU_MF_fnc_aliveEnemies;
	_totalEnemies call _showTargetCounter;
	if (_autoHide && _totalEnemies == 0) exitWith {};
	sleep _refreshInterval;
};
