/*
	This mod exists only to make older missions compatible with the new HEHU MF structure.
*/
class CfgPatches
{
	class hehu_mf
	{
		requiredVersion=1.0;
		requiredAddons[]=
		{
			"hehu_common"
		};

		units[] = {};

		author = "Magnus Bergmark";
		authorUrl = "https://github.com/Mange";

		version = 1.1.1;
		versionStr = "1.1.1";
		versionAr[] = {1,1,1};
	};
};
