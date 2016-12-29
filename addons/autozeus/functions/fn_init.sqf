#include "script_component.hpp"

if (hasInterface) then {
	if (!isNil "ace_interact_menu_fnc_createAction") then {
		_autoZeusAction = [
			'AutoZeus',
			'Become Zeus',
			'\a3\ui_f_curator\data\logos\arma3_curator_eye_32_ca.paa',
			{
				[] call DFUNC(makeMeZeus);
				[player, 1, ["ACE_SelfActions", "AutoZeus"]] call ace_interact_menu_fnc_removeActionFromObject;
			},
			{true}
		] call ace_interact_menu_fnc_createAction;

		[player, 1, ["ACE_SelfActions"], _autoZeusAction] call ace_interact_menu_fnc_addActionToObject;
	};
};
