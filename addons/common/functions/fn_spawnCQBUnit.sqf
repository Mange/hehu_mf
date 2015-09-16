private ["_unit", "_direction"];

_unit = _this call HEHU_MF_fnc_spawnUnit;

_unit setBehaviour "COMBAT"; // Ready weapon
_unit setUnitPos "UP"; // Force stand up

_direction = random 360;
_unit setFormDir _direction; // Set group formation direction
_unit setDir _direction; // Turn the unit in the same direction

// Cargo culted:
_unit setPos getPos _unit; // Setting position synchronizes over to MP clients

_unit