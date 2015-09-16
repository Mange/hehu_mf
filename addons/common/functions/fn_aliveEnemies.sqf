{
	alive _x &&
	!(fleeing _x) &&
	(_x call HEHU_MF_fnc_isEnemyToPlayer)
} count allUnits