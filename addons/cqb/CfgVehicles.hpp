#include "script_component.hpp"

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

	class HEHU_MF_Module: Module_F
	{
		scope = 0;
		author = "Magnus Bergmark";
		category = "HEHU_MF_Modules";
	};

	class HEHU_MF_ModuleCQBSpawner: HEHU_MF_Module
	{
		displayName = "CQB Spawner";
		author = "Magnus Bergmark";
		scope = 2;
		function = QFUNC(moduleCQBSpawner);
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 1;

		// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isGlobal = 0;

		isTriggerActivated = 0;
		isDisposable = 0;

		class Arguments
		{
			// Module specific arguments
			class NumberOfUnits
  			{
				displayName = "Number of units";
				description = "0 means choose from global config / script variable.";
				typeName = "NUMBER";
				defaultValue = "0";
			};
			class UnitAlertness
  			{
				displayName = "Unit alertness";
				typeName = "NUMBER";
				class values
				{
					class UseDefault		{name = "Use global config"; value = -1; default = 1;};
					class StandStill		{name = "Stand still"; value = 0;};
					class RespondThreats	{name = "Respond to threats"; value = 1;};
					class SomePatrol		{name = "Some will patrol"; value = 2;};
					class MostPatrol		{name = "Most will patrol"; value = 3;};
					class AllPatrol			{name = "Everyone patrols"; value = 4;};
				};
			};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Spawns units in random building positions.";
			sync[] = {"LocationArea_F", "LocationBase_F"};

			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"CQB area, with independent unit combinations and positions.",
					"Positions will be of building positions of buildings inside the triggers."
				};
				position = 0; // Position is taken into effect
				direction = 0; // Direction is taken into effect
				optional = 0; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
				sync[] = {"EmptyDetector", "AnyAI"};
			};

			class LocationBase_F
			{
				description[] = { // Multi-line descriptions are supported
					"CQB area, with independent unit combinations and positions.",
					"Positions will be of random places in the triggers."
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

	class HEHU_MF_ModuleTargetCounter: HEHU_MF_Module
	{
		displayName = "Target counter";
		author = "Magnus Bergmark";
		scope = 2;

		function = QFUNC(moduleTargetCounter);
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 100;

		// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isGlobal = 2;

		isTriggerActivated = 0;
		isDisposable = 0;

		class Arguments: ArgumentsBaseUnits
		{
			class Units: Units {};

			// Module specific arguments
			class Precision
  			{
				displayName = "Precision";
				description = "How accurate the counter will be.";
				typeName = "NUMBER";
				class values
				{
					class Exact		{name = "Exact (number of enemies)"; value = 1; default = 1};
					class Inexact	{name = "Inexact (few, many, etc.)"; value = 2;};
					class Unhelpful	{name = "Unhelpful (enemies left, no enemies left)"; value = 3;};
				};
			};
			class RefreshInterval
  			{
				displayName = "Refresh interval";
				typeName = "NUMBER";
				class values
				{
					class 100ms	{name = "100ms"; value = 0.1;};
					class 1s	{name = "1s"; value = 1;};
					class 2s	{name = "2s"; value = 2; default = 1};
					class 3s	{name = "3s"; value = 3;};
					class 4s	{name = "4s"; value = 4;};
					class 5s	{name = "5s"; value = 5;};
				};
			};
			class AutoHide
  			{
				displayName = "Stop when no enemies left";
				description = "Should target counter disappear when no enemies are left?";
				typeName = "BOOL";
				defaultValue = false;
			};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Shows number of enemies left to synchronized (or all) players.";
			sync[] = {"AnyPlayer"};
		};
	};

	class HEHU_MF_ModuleUnitLocator: HEHU_MF_Module
	{
		displayName = "Unit locator";
		author = "Magnus Bergmark";
		scope = 2;

		function = QFUNC(moduleUnitLocator);
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 100;

		// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isGlobal = 2;

		isTriggerActivated = 1;
		isDisposable = 0;

		class Arguments: ArgumentsBaseUnits
		{
			class Units: Units {};

			// Module specific arguments
			class Precision
  			{
				displayName = "Precision";
				description = "How precise should the locator be.";
				typeName = "NUMBER";
				class values
				{
					/*
						Note that the value is the RADIUS of the circle; "20m" precision sounds
						like 20m DIAMETER so value is half that of the description says.
						"I know you precision within 20 meters" sound like +- 10 meters, as the
						search span is 20 meters.
					*/
					class Exact          {name = "Exact"; value = 0;};
					class Accurate       {name = "Accurate (5m)"; value = 2.5; default = 1};
					class Inaccurate     {name = "Inaccurate (20m)"; value = 10;};
					class VeryInaccurate {name = "Very inaccurate (50m)"; value = 25;};
					class WayOff         {name = "Way off (500m)"; value = 250;};
				};
			};
			class RefreshInterval
  			{
				displayName = "Refresh interval";
				typeName = "NUMBER";
				class values
				{
					class 250ms	{name = "250ms"; value = 0.25;};
					class 500ms	{name = "500ms"; value = 0.5;};
					class 1s	{name = "1s"; value = 1;};
					class 2s	{name = "2s"; value = 2; default = 1};
					class 3s	{name = "3s"; value = 3;};
					class 4s	{name = "4s"; value = 4;};
					class 5s	{name = "5s"; value = 5;};
				};
			};

			class NumberOfUnits
  			{
				displayName = "Maximum units alive";
				description = "Only display after this amount of units are alive. (Counts all selected unit types; enter 0 for Always)";
				typeName = "NUMBER";
				defaultValue = 2;
			};

			class LocatorType
  			{
				displayName = "Type";
				description = "How should the enemies be located?";
				typeName = "NUMBER";
				class values
				{
					class Markers {name = "Markers"; value = 1; default = 1};
					// TODO: Add more locator types
				};
			};

			class LocateUnits
  			{
				displayName = "Units to locate";
				description = "What kinds of units should be located?";
				typeName = "NUMBER";
				class values
				{
					class NonPlayers {name = "Non-players"; value = 1;};
					class Players    {name = "Players"; value = 2;};
					class Enemies    {name = "Enemies"; value = 3; default = 1};
					class Civilians  {name = "Civilians"; value = 4;};
					class West       {name = "BLUFOR"; value = 5;};
					class East       {name = "OPFOR"; value = 6;};
					class Ind        {name = "Idenpendent"; value = 7;};
					class Everyone   {name = "Everyone"; value = 8;};
				};
			};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Shows alive units to synchronized (or all) players.";
			sync[] = {"AnyPlayer"};
		};
	};

	class HEHU_MF_ModuleAutomaticEndGame: HEHU_MF_Module
	{
		displayName = "Automatic end game";
		author = "Magnus Bergmark";
		scope = 2;

		function = QFUNC(moduleAutomaticEndGame);
		// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		functionPriority = 100;

		// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isGlobal = 2;

		isTriggerActivated = 1;
		isDisposable = 0;

		class ModuleDescription: ModuleDescription
		{
			description = "Ends the mission when all enemies are dead (and optional triggers are activated).";
			sync[] = {};
		};
	};
};
