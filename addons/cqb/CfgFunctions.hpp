class CfgFunctions {
	class HEHU_CQB
	{
		tag = "hehu_cqb";
		class HEHU_funcs
		{
			file = "\z\hehu\addons\cqb\functions";

			/* Utilities */
			class aliveEnemies{};          // Number of alive units that local player is unfriendly to.
			class isEnemyToPlayer{};       // True if passed unit is an enemy of the player.
			class randomizePosition{};     // Adds a random offset to a position.
			class findBuildings{};         // Find buildings within an area.
			class findBuildingPositions{}; // Find building positions within an area.
			class spawnUnit{};             // Creates a lone unit, with the proper Side.
			class setupPatrol{};           // Takes unit and three positions; sets up patrol between them

			/*
				CQB Spawner module
			Works on game logics, modules, units and triggers. In order to decouple as much as
			possible, most actions take place in two stages:
				1. Gather information
				2. Act on the information
			The information exchange is a "Spawnee", which is a data structure like this:
				[
					position, <Normal position for where to spawn>
					unit_type, <"O_Soldier_F", for example>
					[position...], <array of Positions to patrol>
					placement Special, <"NONE" (default), "NO_COLLIDE", "FORM", "FLYING">
				]
			Multiple "Spawnees" are called "Spawns".
			*/
			class moduleCQBSpawner{};
			// utility functions
			class inferCQBUnits{};      // Removes editor-placed units and returns their types.
			class getSpawnerSettings{}; // Resolve actual settings for a Spawner module, with defaults filled in.
			class getSpawns{};          // Get "Spawnees" for a Spawner module.
			class getSpawnsInCQBBase{}; // Get "Spawnees" for a specific "Base" game logic.
			class getSpawnsInCQBArea{}; // Get "Spawnees" for a specific "Area" game logic.
			// spawning functions
			class spawn{};     // Takes a "Spawnee" and spawns (create) it, setting up patrols, etc.
			class spawnCQBUnit{}; // Creates a unit for CQB.
			/**/

			/* Target counter module */
			class moduleTargetCounter{}; // Read target counter options and call it.
			class targetCounter{};       // Display the actual target counter.

			/* Unit locator module */
			class moduleUnitLocator{}; // Read unit locator options and start it.
			class startUnitLocator{}; // Show position of units.
			class startUnitLocatorMarkers{}; // Show position of units using map markers.

			/* Automatic end game module */
			class moduleAutomaticEndGame{}; // End the game when aliveEnemies are 0.
		};
	};
};
