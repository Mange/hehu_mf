private ["_type", "_position", "_side", "_group", "_unit", "_direction", "_special"];
_type     = param [0, "O_soldier_F", [""]];
_position = param [1, [0, 0, 0], [[]], [2,3]];
_special  = param [2, "NONE", [""]];

_side = [(configfile >> "CfgVehicles" >> _type), "side", 0] call BIS_fnc_returnConfigEntry;
_side = switch(_side) do {
	case 0: { east; };
	case 1: { west; };
	case 2: { independent; };
	case 3: { civilian; };
	default { east; };
};

_group = createGroup _side;
_unit = _group createUnit [_type, _position, [], 0, _special];

_unit;
