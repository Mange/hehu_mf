#include "script_component.hpp"

// run this on the server!

private ["_player", "_module"];
_player = param [0, nil];

if (!isNil "_player") then {
	createCenter sideLogic;

	_module = (createGroup sideLogic) createunit ["ModuleCurator_F", position _player, [], 0, "none"];

	_module setVariable ["owner", _player call bis_fnc_objectvar];
	_module setVariable ["Addons", 3]; // All (including unofficial ones)

	[name _player] remoteExec [QFUNC(tellClientsAboutZeus), 1, true];
}
