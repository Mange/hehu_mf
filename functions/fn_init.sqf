private ["_triggers", "_positions", "_numberOfEnemies", "_enemyAlertness", "_enemyCombatMode", "_enemyPatrols", "_spawns"];

if (isServer) then {
	_logics = [_this, 0, [], [[]]] call BIS_fnc_param;
	_settings = [(_logics select 0)] call HEHU_CQB_fnc_getSpawnerSettings;

	_spawns = [_logics] call HEHU_CQB_fnc_getSpawns;
	[_spawns, _settings] call HEHU_CQB_fnc_spawn;
};


//
// Mission logic loop
//

if (!isServer) then {
	// MP clients should wait on the server to complete all the unit spawning. 15 seconds
	// should be enough, even with high lag and a LOT of units.
	sleep 15;
};

// Win the game when enemies are killed!
waitUntil { [] call HEHU_CQB_fnc_aliveEnemies == 0; };
sleep 0.5;
["END1", true, 7] call BIS_fnc_endMission;