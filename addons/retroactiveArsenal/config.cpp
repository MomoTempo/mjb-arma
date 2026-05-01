class CfgPatches {
  class mjb_arsenal {
	ammo[] = {};
	magazines[] = {};
    units[] = {"mjb_moduleArsenal","mjb_moduleArsenalMission","mjb_moduleEnd","mjb_moduleResync","mjb_moduleAllMedic","mjb_moduleMoveArsenal","mjb_moduleToggleGroupMarker","mjb_moduleUnlock","mjb_moduleNoTab","mjb_moduleLightsOutEMP","mjb_moduleVcom","mjb_moduleSetUnitRole","mjb_moduleSebTableMark","mjb_moduleSebTableArea","mjb_moduleSebTableClear","mjb_moduleAdminMenu","mjb_moduleToggleTI","mjb_moduleAllowAIUncon","mjb_moduleLockDoors"};//mjb_modulePersist
    weapons[] = {};
    requiredVersion = 0.1;
    author = "Alien314";
    name = "Retroactive Arsenal";
    requiredAddons[]=
		{
	   		"ace_interact_menu",
			"ace_zeus",
			"ace_rangecard"
		};
	};
};

class Extended_PostInit_EventHandlers
{
	class mjb_arsenal
	{
		init="call compileScript ['z\mjb\addons\arsenal\XEH_postInit.sqf']";
	};
};

class Extended_PreInit_EventHandlers
{
	class ace_zeus {
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preInitZeus.sqf']";
	};
	class ace_nlaw
	{
		//init="call compileScript ['z\mjb\addons\arsenal\XEH_preInitNlaw.sqf']";
	};
	class ace_rangecard {
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preInitRangecard.sqf']";
	};
	/*class tsp_animate_functions {
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preInitAnimate.sqf']";
	};*/
	class mjb_arsenal
	{
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preInit.sqf']";
	};
};
class Extended_PreStart_EventHandlers
{
	class ace_zeus {
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preStartZeus.sqf']";
	};
	class ace_nlaw
	{
		//init="call compileScript ['z\mjb\addons\arsenal\XEH_preStartNlaw.sqf']";
	};
	class ace_rangecard {
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preStartRangecard.sqf']";
	};
	class mjb_arsenal
	{
		init="call compileScript ['z\mjb\addons\arsenal\XEH_preStart.sqf']";
	};
};

#if __has_include("\x\CF_BAI\addons\main\script_component.hpp")
class Extended_Init_EventHandlers {
    class CAManBase {
        class mjb_CF_BAI_zeusSuppression {
            init = "call mjb_arsenal_fnc_cf_bai_zeusInit";
        };
    };
};
#endif
/*
class CfgWorlds {
	class DefaultWorld { class WaterExPars; };
	class CAWorld : DefaultWorld {
		class WaterExPars : WaterExPars {
			fogColor[] = {0.3,0.07155,0.09045};
		};
	};
};*/


class Extended_DisplayLoad_EventHandlers {
    class RscDisplayCurator {
        mjb_arsenal = "_this call mjb_arsenal_fnc_openedZeus";
    };
};



class CfgLoadouts
{
	#include "_macros.hpp"
	class rats {
		category = "RATS";
		displayName = "RATS";
		tooltip = "RATS PMC loadouts.";
		#include "player_loadout.hpp"
	};
	class example_enemy {
		category = "RATS";
		displayName = "xExample Enemy Loadout";
		tooltip = "Loadout example for enemies.";
		#include "enemy_loadout.hpp"
	};
};

class ACEX_Fortify_Presets {
	class rats {
		displayName = "RATS";
		objects[] = {
			{"FootBridge_0_ACR", 5},
			{"Land_Plank_01_4m_F", 5},
			{"Land_tires_EP1", 10},
			{"Land_Tyres_F", 10},
			{"ClutterCutter_small_2_EP1", 10},
			{"TyreBarrier_01_black_F", 15},
			{"Land_Misc_ConcPipeline_EP1", 25},
			{"Land_BagBunker_Small_F", 35},
			{"Land_fort_rampart", 40}
		};
	};
};

class CfgFactionClasses {
    class MJB {
        displayName = "MJB Arma";
        priority = 2;
        side = 7;
    };
    class VCOM : MJB {
        displayName = "VCOM/TCL";
    };
    class MJB_SEB : MJB {
        displayName = "Seb's Briefing Table";
    };
    class MJB_Breach : MJB {
        displayName = "TSP Breach";
    };
	class TEAMWORK;
};

class CfgVehicles
{
    class Module_F;
	class ModuleEndMission_F;
	//class ModuleEndMission_F : Module_F {
		//function = "mjb_arsenal_fnc_moduleEnd";
	//};
    class mjb_moduleBase : Module_F {
        author = "Alien314";
        category = "MJB";
		curatorCost = 0;
        function = "";
        functionPriority = 1;
        isGlobal = 1;
        isTriggerActivated = 0;
        scope = 1;
        scopeCurator = 2;
    };
    class mjb_moduleAllMedic : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Set Medic Player(s)";
        function = "mjb_arsenal_fnc_moduleAllMedic";
        icon = "\A3\ui_f\data\igui\cfg\actions\unloadIncapacitated_ca.paa";
    };
    class mjb_moduleArsenal : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Retroactive Arsenal";
        function = "mjb_arsenal_fnc_moduleArsenal";
        icon = "\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa";
    };
    class mjb_moduleArsenalMission : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Retroactive Arsenal (Preserve Mission Arsenal)";
        function = "mjb_arsenal_fnc_moduleArsenalMission";
        icon = "\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa";
    };
    class mjb_moduleMoveArsenal : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Move Arsenal Location";
        function = "mjb_arsenal_fnc_moduleMoveArsenal";
        icon = "\A3\ui_f\data\gui\rsc\RscDisplayArsenal\spaceGarage_ca.paa";
    };
    class mjb_moduleNoTab : mjb_moduleBase {
        curatorCanAttach = 0;
        displayName = "Disable BFT/Devices";
        function = "mjb_arsenal_fnc_moduleNoTab";
        icon = "\A3\ui_f\data\GUI\Cfg\Hints\Map_ca.paa";
    };
    class mjb_moduleLightsOutEMP : mjb_moduleBase {
        curatorCanAttach = 0;
        displayName = "Lights Out/EMP (delete undoes)";
        function = "mjb_arsenal_fnc_moduleLightsOutEMP";
        icon = "\A3\ui_f\data\igui\cfg\actions\beacons_off_ca.paa";
		portrait = "\A3\ui_f\data\igui\cfg\actions\beacons_off_ca.paa";
    };
    class mjb_moduleAdminMenu : mjb_moduleBase {
		category = "Teamwork";
        curatorCanAttach = 1;
        displayName = "Admin Menu";
        function = "mjb_arsenal_fnc_moduleAdminMenu";
        icon = "\a3\Modules_F_Curator\Data\iconDiary_ca.paa";
    };
	class mjb_moduleEnd : ModuleEndMission_F {
        displayName = "End Scenario (No Music/MJB Persistence Save)";
		function = "mjb_arsenal_fnc_moduleEnd";
		icon = "\A3\ui_f\data\igui\cfg\Actions\Obsolete\ui_action_gear_ca.paa";
		portrait = "\A3\ui_f\data\igui\cfg\Actions\Obsolete\ui_action_gear_ca.paa";
		isTriggerActivated = 0;
		scope = 1;
	};
	class mjb_modulePersist : mjb_moduleBase {
        curatorCanAttach = 0;
        displayName = "Activate Persistence (missionGroup/mission)";
		function = "mjb_arsenal_fnc_modulePersist";
		icon = "\A3\ui_f\data\gui\cfg\Hints\Adjust_ca.paa";
        isGlobal = 0;
	};
	class mjb_moduleToggleGroupMarker : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Toggle Unit Marker Visibility";
		function = "mjb_arsenal_fnc_moduleToggleGroupMarker";
		icon = "\A3\ui_f\data\Map\Markers\NATO\b_inf.paa";
        isGlobal = 0;
	};
	class mjb_moduleResync : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Re-Sync Player";
		function = "mjb_arsenal_fnc_moduleResync";
		icon = "\A3\ui_f\data\gui\cfg\Hints\Adjust_ca.paa";
	};
	class mjb_moduleAllowAIUncon : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Allow AI Unconscious";
		function = "mjb_arsenal_fnc_moduleAllowAIUncon";
		icon = "\A3\ui_f\data\igui\cfg\Revive\OverlayIconsGroup\u100_ca.paa";
	};
	class mjb_moduleToggleTI : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Toggle Thermal Vision allowed";
		function = "mjb_arsenal_fnc_moduleToggleTI";
		icon = "\A3\3den\Data\Displays\Display3DEN\ToolBar\vision_ti_ca.paa";
	};
	class mjb_moduleUnlock : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Un/Lock Vehicle/Container";
		function = "mjb_arsenal_fnc_moduleUnlock";
		icon = "\A3\ui_f\data\igui\cfg\actions\getincargo_ca.paa";
	};
	class mjb_moduleSetUnitRole : mjb_moduleBase {
        curatorCanAttach = 1;
        displayName = "Set Unit Role";
		function = "mjb_arsenal_fnc_moduleSetUnitRole";
		icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa";
	};
    class mjb_moduleLockDoors : mjb_moduleBase {
		category = "MJB_Breach";
        curatorCanAttach = 0;
        displayName = "Lock Doors in Area";
        function = "mjb_arsenal_fnc_moduleLockDoors";
        icon = "\A3\3den\Data\Attributes\DoorStates\textureUnchecked_door_ca.paa";
    };
	class mjb_moduleSebTableMark : mjb_moduleBase {
        category = "MJB_SEB";
        curatorCanAttach = 1;
        displayName = "1Mark/Make Briefing Table";
		function = "mjb_arsenal_fnc_moduleSebTableMark";
		icon = "\A3\ui_f\data\GUI\Cfg\Hints\Tactical_view_ca.paa";
	};
	class mjb_moduleSebTableArea : mjb_moduleBase {
        category = "MJB_SEB";
        curatorCanAttach = 1;
        displayName = "2Mark Briefing Area (Laggy)";
		function = "mjb_arsenal_fnc_moduleSebTableArea";
		icon = "\A3\ui_f\data\GUI\Cfg\Hints\Tactical_view_ca.paa";
	};
	class mjb_moduleSebTableClear : mjb_moduleBase {
        category = "MJB_SEB";
        curatorCanAttach = 1;
        displayName = "x(Very Laggy)Before Deleting Table";
		function = "mjb_arsenal_fnc_moduleSebTableClear";
		icon = "\A3\ui_f\data\GUI\Cfg\Hints\Tactical_view_ca.paa";
	};
	class mjb_moduleVcom : mjb_moduleBase {
        category = "VCOM";
        curatorCanAttach = 1;
        displayName = "Change VCOM/TCL Settings (Unit/Vehicle/Ground for Global)";
		function = "mjb_arsenal_fnc_moduleVCOM";
		icon = "\A3\ui_f\data\GUI\Cfg\Hints\Tactical_view_ca.paa";
	};
};

/*class RscDisplayAttributes;
class RscCheckBox;

class MJB_Display {
	class mjb_rscDisplayAttributesModuleArsenal : RscDisplayAttributes {
		onLoad = "[""onLoad"",_this,""mjb_rscDisplayAttributesModuleArsenal"",'CuratorDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
		onUnload = "[""onUnload"",_this,""mjb_rscDisplayAttributesModuleArsenal"",'CuratorDisplays'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')";
		scriptName = "mjb_rscDisplayAttributesModuleArsenal";
		scriptPath = "CuratorDisplays"; // CfgScriptPaths
		class Controls {
			class CheckBoxJIP : RscCheckBox;
		};
	};
};*/

#include "Display3DEN.hpp"

class CfgSounds {
	class SSD_scream861 {
		name = "SSD_scream861";
		sound[] = {"\z\mjb\addons\arsenal\data\SSD_scream861.ogg",2,1,220};
		titles[] = {};
	};
};

// Tac Reload disable loose ammo 'magazines'
class CfgMagazines {
	class CA_Magazine;
	class 2Rnd_12Gauge_Pellets : CA_Magazine {
		mjb_disableTacReload = 1;
	};

	class 1Rnd_HE_Grenade_shell;
	class 3Rnd_HE_Grenade_shell : 1Rnd_HE_Grenade_shell {
		mjb_disableTacReload = 1;
	};

	class UGL_FlareGreen_F;
	class 3Rnd_UGL_FlareGreen_F : UGL_FlareGreen_F {
		mjb_disableTacReload = 1;
	};

	class 11Rnd_45ACP_Mag;
	class 6Rnd_45ACP_Cylinder : 11Rnd_45ACP_Mag {
		mjb_disableTacReload = 1;
	};

	// CUP
	class CUP_10x_303_M : CA_Magazine {
		mjb_disableTacReload = 1;
	};

	class CUP_1Rnd_12Gauge_Pellets_No00_Buck : CA_Magazine {
		mjb_disableTacReload = 1;
	};

	class CUP_1Rnd_12Gauge_Slug : CA_Magazine {
		mjb_disableTacReload = 1;
	};

	class CUP_6Rnd_45ACP_M : CA_Magazine {
		mjb_disableTacReload = 1;
	};

	class CUP_5Rnd_762x51_M24 : CA_Magazine {
		mjb_disableTacReload = 1;
	};

	class CUP_5Rnd_762x54_Mosin_M : CA_Magazine {
		mjb_disableTacReload = 1;
	};

	class CUP_8Rnd_357SW_M : CA_Magazine {
		mjb_disableTacReload = 1;
	};
};