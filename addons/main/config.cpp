class CfgPatches 
{
	class 1TAC_ADMIN_CONSOLE
    {
        units[] ={
            "Fa_Module_Unflip_Vehicle",
            "Fa_Module_Reset_Downed_Player",
            "Fa_Module_Repair_Vehicle",
            "Fa_Module_Heal_Player",
            "Fa_Module_Resurrect_Player"
        };

		weapons[] = {};
		worlds[] = {};
		requiredAddons[] = {"a3_data_f","a3data"};
		requiredVersion = 1.0;
		author[] = {"Pooter","Snippers","Wolfenswan"};
		authorUrl = "www.folkarps.com";
	};
};

#include "defines.hpp"
#include "dialogs.hpp"

class CfgFunctions
{
	class tac1_admin
	{
		class adminMenu
		{
			file="1tac_admin\func";
			class Init { 
				postInit=1;
				file = "1tac_admin\init.sqf";
			};
			class actionGiveZeus {};
			class actionGiveZeusSelf {};
			class actionGroupTeleport {};
			class actionPlayerTeleport {};
			class actionZeusAddAllObjects {};
			class endMissionInstant {};
			class endMissionSmooth {};
			class fillMissionEndingBox {};
			class fillPlayerListBox {};
			class keyPressed {};
			class keySpectPressed {};
			class zeusAddAllObjects {};
			class zeusServerMake {};
			class zeusServerObjectPlacedSync {};
			class zeusSetupSync {};
			class teleportDrawMapIcons {};
			class teleportMapClick {};
			class teleportMapLoaded {};
            class messageAdmin {};
            class UnflipVehicle{};
            class ResetDownedPlayerOld{};
			class ResetDownedPlayerFAM{};
			class ResetDownedPlayerVanilla{};
            class HealPlayer{};
            class RepairVehicle{};
            class ResurrectPlayer{};
			class SlapPlayer{};
		};
		class scripts
		{
			file="1tac_admin\scripts";
			class checkMods {};
            class waitForZeus;
            class isZeus;
            class MonitorCuratorDisplay;
            class HandleCuratorObjectPlaced;
            class OnModuleTreeLoad;
            class HandleCuratorObjectDoubleClicked;
		};
	};
};


class CfgVehicles {
    
    
	class Logic;
	class Module_F: Logic
	{
		class ModuleDescription
		{
			class AnyPlayer;
			class AnyBrain;
			class EmptyDetector;
		};
	};
	class Fa_Module_Base : Module_F
	{
		mapSize = 1;
		author = "Pooter";
		vehicleClass = "Modules";
		category = "Fa";
		subCategory = "Behaviours";
		side = 7;

		scope = 1;				// Editor visibility; 2 will show it in the menu, 1 will hide it.
		scopeCurator = 1;		// Curator visibility; 2 will show it in the menu, 1 will hide it.

		displayName = "Fa Module Base";	// Name displayed in the menu

		function = "";			// Name of function triggered once conditions are met
		functionPriority = 1;	// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
		isGlobal = 2;			// 0 for server only execution, 1 for remote execution on all clients upon mission start, 2 for persistent execution
		isTriggerActivated = 0;	// 1 for module waiting until all synced triggers are activated
		isDisposable = 0;		// 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		// curatorInfoType = "RscDisplayAttributeModuleNuke";	// Menu displayed when the module is placed or double-clicked on by Zeus
		
		class Arguments {};
		class ModuleDescription: ModuleDescription
		{
			description = "Fa Module Base";
		};
	};
    
	class Fa_Fa_Module_Base : Fa_Module_Base
	{
		subCategory = "Fa";
	};

	// Placeholder class that doesn't do anything. Used for generating categories in UI.
	class Fa_Module_Empty : Fa_Module_Base
	{
		category = "Curator";
		subCategory = "";
		
		mapSize = 0;
		displayName = "Fa Module Empty";
		//icon = "";
		function = "Fa_fnc_Empty";
	};
    
    
	#include "cfgVehiclesModulesFa.hpp"
};

class CfgDifficulties {
	default = "Veteran";
};
