#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		requiredVersion=1.0;
		requiredAddons[]=
		{
			"cba_main"
		};

		units[] = {};

		author = "Magnus Bergmark";
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
