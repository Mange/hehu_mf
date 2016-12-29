#include "script_component.hpp"

{
	alive _x &&
	!(fleeing _x) &&
	(_x call DFUNC(isEnemyToPlayer))
} count allUnits
