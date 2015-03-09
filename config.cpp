class CfgPatches
{
	class HEHU_CQB
	{
		requiredVersion=1.0;
		requiredAddons[]=
		{
			"A3_Modules_F",
			"cba_main"
		};

		units[] = {
			"HEHU_CQB_ModuleSpawner"
		};

		author[] = {"Mange"};
		authorUrl = "https://github.com/Mange";

		version = 0.0.1;
		versionStr = "0.0.1";
		versionAr[] = {0,0,1};
	};
};

/* Define module category */
class CfgFactionClasses
{
	class NO_CATEGORY;
	class HEHU_CQB_Modules: NO_CATEGORY
	{
		displayName = "CQB";
	};
};

/* Define modules */
class CfgVehicles {
	class Logic;
	class Module_F: Logic {
		class ArgumentsBaseUnits {
			class Units;
		};
		class ModuleDescription {
			class AnyBrain;
		};
	};

	class HEHU_CQB_ModuleSpawner: Module_F {
		scope = 2; // Show in Editor menu
		displayName = "Spawner";
		// icon = "\foo\bar.paa" // TODO
		category = "HEHU_CQB_Modules";

		function = "HEHU_CQB_fnc_moduleSpawner";
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;

		// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isGlobal = 0;

		isTriggerActivated = 0;
		isDisposable = 1;

		class Arguments: ArgumentsBaseUnits
		{
			// Arguments shared by specific module type (have to be mentioned in order to be placed on top)
			class Units: Units {};
			// Module specific arguments
			class NumberOfEnemies
  			{
				displayName = "Number of enemies";
				description = "0 means choose from global config.";
				typeName = "NUMBER";
				defaultValue = "0";
			};
			class EnemyAlertness
  			{
				displayName = "Enemy alertness";
				typeName = "NUMBER";
				class values
				{
					class UseDefault		{name = "Use global config"; value = -1; default = 1;};
					class StandStill		{name = "Stand still"; value = 0;};
					class RespondThreats	{name = "Respond to threats"; value = 1;};
					class SomePatrol		{name = "Some will look for you"; value = 2;};
					class MostPatrol		{name = "Most will look for you"; value = 3;};
					class AllPatrol			{name = "All will look for you"; value = 4;};
				};
			};
		};
		
		class ModuleDescription: ModuleDescription
		{
			description = "Spawns units in random building positions.";
			sync[] = {"LocationArea_F"};

			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"CQB area"
				};
				position = 0; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
				sync[] = {"EmptyDetector", "AnyAI"};
			};
	 
			class EmptyDetector
			{
				description[] = {
					"Trigger areas",
					"Buildings inside the areas will be candidates for unit placements."
				};
				position = 1; // Position is taken into effect
				direction = 1; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
			};
		};	
	};
};

class CfgFunctions {
	class HEHU_CQB
	{
		tag = "HEHU_CQB";
		class HEHU_CQB_funcs
		{
			file = "hehu_cqb\functions";
			class init{};

			class moduleSpawner{};

			class getBuildingPositionsInTriggerAreas{};
			class getBuildingsInTriggerArea{};

			class getAllBuildingPositions{};

			class inferEnemyUnits{};
			class getSpawns{};
			class getSpawnsInLogic{};
			class spawn{};
			class spawnUnit{};
			class setupPatrol{};

			class aliveEnemies{};
			class targetCounter{};
		};
	};
};