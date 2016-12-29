#include "script_component.hpp"

// Randomize a position by adding a random offset in all directions.
// A radius of 10 means between -10 and 10 meters in X and in Y.
private ["_position", "_radius"];
_position = param [0, [0, 0], [[]] ];
_radius   = param [1,      1, [0]];

[_position, {
	_x + (random _radius * 2) - (_radius / 2)
}] call CBA_fnc_filter;
