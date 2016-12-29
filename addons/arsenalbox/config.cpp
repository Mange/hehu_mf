#include "script_component.hpp"

class CfgPatches
{
	class ADDON
	{
		requiredVersion=1.0;
		requiredAddons[]=
		{
			"A3_Weapons_F_Ammoboxes",
			"hehu_common"
		};

		units[] = {
			"HEHU_MF_ArsenalBox"
		};

		author = "Magnus Bergmark";
		authorUrl = "https://github.com/Mange";

		VERSION_CONFIG;
	};
};

class CfgVehicles {
	class thingX;
	class HEHU_MF_ArsenalBox: thingX
	{
		// Don't inherit from a real ammo box to remove the vanilla inventory from them.
		// You can only interact with this box as a Virtual Arsenal object.
		//
		// class thingX;
		//   class ReammoBox_F;
		//      class Box_NATO_Wps_F;
		//
		// TODO: Make it possible to sling load this box, or make a variant that is.

		vehicleclass = "Ammo";  // ReammoBox_F
		animated = 0;           // ReammoBox_F
		accuracy = 0.2;         // ReammoBox_F
		icon = "iconCrateWpns"; // Box_NATO_Wps_F
		mapsize = 1.81;         // Box_NATO_Wps_F
		model = "\A3\weapons_F\AmmoBoxes\WpnsBox_F"; // Box_NATO_Wps_F

		displayName = "HEHU Ammo box";
		author = "Magnus Bergmark";
		scope = 2;
		class Eventhandlers
		{
			init = "[""AmmoboxInit"",[(_this select 0), true]] spawn BIS_fnc_arsenal;";
		};
	};
};
