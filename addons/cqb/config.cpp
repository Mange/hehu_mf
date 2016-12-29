#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		requiredVersion=1.0;
		requiredAddons[]=
		{
			"A3_Modules_F",
			"hehu_common"
		};

		units[] = {
			"HEHU_MF_Module",
			"HEHU_MF_ModuleCQBSpawner",
			"HEHU_MF_ModuleTargetCounter",
			"HEHU_MF_ModuleUnitLocator",
			"HEHU_MF_ModuleAutomaticEndGame"
		};


		author = "Magnus Bergmark";
		authorUrl = "https://github.com/Mange";

		VERSION_CONFIG;
	};
};

#include "CfgFunctions.hpp"
#include "CfgVehicles.hpp"
