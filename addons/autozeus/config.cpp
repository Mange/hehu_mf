class CfgPatches
{
	class hehu_autozeus
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

		version = 1.1.1;
		versionStr = "1.1.1";
		versionAr[] = {1,1,1};
	};
};


class CfgFunctions {
	/* Auto-zeus stuff */
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