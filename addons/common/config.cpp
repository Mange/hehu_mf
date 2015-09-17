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
			"cba_main"
		};

		units[] = {
			"HEHU_MF_Module",
			"HEHU_MF_ModuleCQBSpawner",
			"HEHU_MF_ModuleTargetCounter",
			"HEHU_MF_ModuleUnitLocator",
			"HEHU_MF_ModuleAutomaticEndGame",
			"HEHU_MF_ArsenalBox"
		};

		author[] = {"Magnus Bergmark"};
		authorUrl = "https://github.com/Mange";

		VERSION_CONFIG;
	};
};

/* Define module category */
class CfgFactionClasses
{
	class NO_CATEGORY;
	class HEHU_MF_Modules: NO_CATEGORY
	{
		displayName = "HEHU Mission Framework";
	};
};

#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"
