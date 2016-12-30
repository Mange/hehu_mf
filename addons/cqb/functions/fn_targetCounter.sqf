#include "script_component.hpp"

private ["_totalEnemies", "_refreshInterval", "_precision", "_autoHide", "_showHint", "_showTargetCounter"];

_refreshInterval = param [0, 2, [1.0]];
_precision       = param [1, 1, [1]];
_autoHide        = param [2, false, [false]];

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
	// Approximate
	case 4: {
		{
			private ["_text", "_lower", "_upper", "_bucket_size"];
			_text = "0";
			_bucket_size = 3;

			if (_this > 0 && _this < 22) then {
				// For example: On 13 units and bucket size 3
				// Lower = floor (13 / 3) * 3 = floor (4.33333) * 3 = 4 * 3 = 12
				// Upper = 12 + 3 = 15
				// Range is therefore 12-15 units.
				_lower = floor (_this / _bucket_size) * _bucket_size;
				_upper = _lower + _bucket_size;

				_text = format["%1-%2", _lower, _upper];
			};

			[format ["<t color='#ff0000'>%1</t> ENEMY UNITS LEFT", _text]] call _showText;
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
	_totalEnemies = [] call DFUNC(aliveEnemies);
	_totalEnemies call _showTargetCounter;
	if (_autoHide && _totalEnemies == 0) exitWith {};
	sleep _refreshInterval;
};
