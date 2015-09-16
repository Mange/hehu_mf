private ["_activated"];

_activated = param [2, true, [true]];

if (_activated) then {
	waitUntil { [] call HEHU_MF_fnc_aliveEnemies == 0; };
	sleep 0.5;
	["END1", true, 7] call BIS_fnc_endMission;
};

true