#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		requiredVersion=1.0;
		requiredAddons[]=
		{
			"A3_Modules_F",
			"A3_Weapons_F_Ammoboxes",
			"cba_main",
			"hehu_common"
		};

		units[] = {};

		author[] = {"Magnus Bergmark"};
		authorUrl = "https://github.com/Mange";

		VERSION_CONFIG;
	};
};


class CfgFunctions
{
	class HEHU_MF_AutoZeus
	{
		tag = "HEHU_AutoZeus";
		class HEHU_AutoZeus_funcs
		{
			file = "\z\hehu\addons\autozeus\functions";

			class makeMeZeus{};
			class askServerForZeus{};
			class tellClientsAboutZeus{};

			class init {
				postInit = 1
			};
		};
	};
};

class CfgRemoteExec
{
	class Functions
	{
		class HEHU_AutoZeus_fnc_tellClientsAboutZeus
		{
			allowedTargets = 0; // Anyone
		};
		class HEHU_AutoZeus_fnc_askServerForZeus
		{
			allowedTargets = 2; // Server only
		};
	};
};
