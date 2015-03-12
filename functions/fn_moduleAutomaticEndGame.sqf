private ["_logic", "_activated"];

_logic = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_activated = [_this, 2, true, [true]] call BIS_fnc_param;

if (_activated) then {
	waitUntil { [] call HEHU_MF_fnc_aliveEnemies == 0; };
	sleep 0.5;
	["END1", true, 7] call BIS_fnc_endMission;
};

true