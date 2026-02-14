/**
    * Adds curated arsenal to player that disables itself under specified conditions.
    *
    * Faction: MJB ARMA default PMCs
    *
    * Usage - under initPlayerLocal.sqf
    * 0 = execVM 'loadouts\arsenal.sqf';
    *
    * New framework update by NotherDuck
    * Equipment and quality hat choices by MajorDanvers
    * Formatting by veerserif
    *
    * v0.5 - 2021-08-20:
        - Removed ACRE Radios
        - Removed EFT Uniforms with Beltstaff Pants (White LOD Issue)
        - Added weapons and attachments requested in framework doc.
        - Gave all roles access to tracers where possible.
        - Moved DMRs (M14, SR-25, SVDS) and Shortdot to seperate role (_itemWeaponSharpshooter).
        - Added LAT Equipment (_itemWeaponLAT).
    * v1.0 - 2021-08-21:
        - Fixed several typos with magazines and added some missing ones (150 rnd 7.62x54r Box)
        - Moved shotguns and smgs to seperate section (_itemWeaponCQB, still given to all classes with normal rifles)
        - Added section for high capacity rifle mags (_itemWeaponHighCapAmmo, given to SF)
    * v1.1 - 2021-08-26:
        - Added ACRE radios back to arsenal.
        - Removed CUP lasers.
        - Fixed some roles not having access to pistols.
        - Added NAPA drip hoodie.
    * v1.1a - 2021-08-31:
        - Removed heli coveralls from normal infantry roles.
        - Gave tank and air crews access to CQB weapons.
    * v1.2 - 2021-09-01:
        - Added carbine variants requested by VierLeger (VHS-K2, ACR-C, F2000 Tactical, Mk17 CQC, Mk18).
    * v1.2a - 2021-09-14:
        - Added the AK-104 and AK-74M.
        - Changed AK-105 variant to B-13 version (rail can be removed using CTRL+C by default to access dovetail sights)
        - Fixed LAT and HAT roles having access to binoculars.
    * v2.0 - 2021-10-08:
        - Replaced all RHS and T1 content with CUP versions
        - Added trivial cosmetics for specific roles (ex. AR, Leaders)
    * v2.1 - 2022-01-22:
        - AKA the RHS one
            - All AR-pattern rifles switched out for RHS variants
            - RHS AKs added to augment our CUP AKs(yay for folding stocks!)
            - RHS optics and accessories added
            - Some RHS cosmetics added
            - Added some vanilla fatigues to match our MWS fatigues
            - More backpack colors
            - M110 SASS and M14 EBR for sharpshooters
            - TAR-21 for vanilla troopers
    * v2.1a - 2022-01-30:
            - Left most CUP AR-pattern rifles for GL roles, some might prefer the holo dot gl sight
            - Prioritized model quality and variety when removing/replacing guns, CUP has nicer wood furniture usually.
            - Added RHS disposables and RPG-7 with similar AT strength rockets
            - ACE Vector and RHS Binocs
            - Couple RHSGREF camos
            - Winter variable to enable winter camo gear, these are currently weaker than our normal gear
            - Added RHS rifles to Sharpshooter and Sniper
            - Replaced CUP MP7 and added PP2000 and M590 in CQB weapons
            - Added M145 optic and a couple RHS AR options to ARs
            - Gave SF some vests from the pre-nuke arsenal, RHS AS Val, and a special pistol
            - Gave helo and tank crews pre-nuke vests (sorry air ;-;)
            - Blyat
            - Beltstaff yeeted (un-yeeted non-bugged shirts)
            - Added 20 round 9x39 mag and corrected 9x39 ammo box class name to ball
        - 2022-02-02:
            - Gave up trying to limit size and added a ton more weapons
            - Removed a few redundancies
        -2022-02-04:
            - Scav uniforms
        -2022-02-11:
            - MMG team (mjbLOVE to Banzerschreck), not shaking down AR yet
            - Moved non-base/med backpacks into _itemPackMedium and _itemPackHeavy

    * Arguments:
      * 0: Apply to JIPs, players coming in after will use these parameters to generate
              a personal arsenal, default: false <BOOLEAN> !!Must be Global Exec'd to work!!
      * 1: Role for the target(s) to use, nil or "" to use TMF, or unit type.
              default: TMF role, (typeOf _unit) if no TMF role set in editor <STRING>
      * 2: Remove existing Personal Arsenal, default: true <BOOLEAN>
      * 3: Additional gear to include <ARRAY> of <STRING> class names, default: []
      * 4: Winter camo available, default: true <BOOLEAN>

      !! JIP param true Must be Global Exec'd to work !!

    ex.: [true, nil, true, ["ACRE_BF888S","tier1_exps3_0_g33_black_up"]] call mjb_arsenal_fnc_arsenal;
*/
params [["_JIP",false,[false]],["_role","",[""]],["_removeOld",true,[false]],["_additions", [], [[]]],["_winter",true,[false]],["_tracer","",[""]]];

private _sideID = ((side player) call BIS_fnc_sideID);
private _blufor = _sideID isEqualTo 1;
if (_tracer isEqualTo "") then {_tracer = ['yellow','red'] select _blufor};

if (_JIP) exitWith {
  if (isServer) then {
    [false,_role,_removeOld,_additions,_winter] remoteExec ["mjb_arsenal_fnc_arsenal",([0, -2] select (isDedicated)),"mjb_arsenal_JIP"];
  };
};

if !(canSuspend) exitWith {_this spawn mjb_arsenal_fnc_arsenal};
    waitUntil {!isNull player};
    sleep 1;

//if !(didJIP) then {
    if (_removeOld && {!(isNil "arsenal")}) then {
        [typeOf player, 1,["ACE_SelfActions","personal_arsenal"]] call ace_interact_menu_fnc_removeActionFromClass;
        deleteVehicle arsenal;
    } else {
        if (!(isNil "arsenal") && {isNil "missionArsenal"}) then {
            missionArsenal = arsenal;
            private _action =
            [
                "mission_arsenal","Mission Arsenal","\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
                {
                    lockIdentity player;
                    [missionArsenal, _player] call ace_arsenal_fnc_openBox
                },
                {
                    (player distance2d (player getVariable ["startpos",[0,0,0]])) < 200
                },
                {},
                [],
                [0,0,0],
                3
            ] call ace_interact_menu_fnc_createAction;
            ["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
            [typeOf player, 1,["ACE_SelfActions","personal_arsenal"]] call ace_interact_menu_fnc_removeActionFromClass;
        };
    };
//};

arsenal = "building" createVehicleLocal [0,0,0];

#include "_arsenalMacros.hpp"

//Variables
private _aceMedLoaded = !(isNil "ace_medical_engine"); //Store whether ace med is present

//private _winter = false; // true to enable winter camo
private _enableCBRN = false;

// !!paste limit!!

private _rejoincheck = player getVariable ["startpos",nil];
if (isNil "_rejoincheck") then {
    player setVariable ["startpos", getPosASL player, true];};


//Define Arsenal Items
private _itemEquipment =
[
    //============================================================
    //Vests
    //============================================================
    //Vanilla Vests
	"V_PlateCarrier2_blk",
    "V_PlateCarrier2_rgr_noflag_F",
    "V_PlateCarrier1_blk",
    "V_PlateCarrier1_rgr_noflag_F",

	//CUP vests
    "CUP_V_CZ_NPP2006_nk_black",
    "CUP_V_CZ_NPP2006_nk_vz95",
    "CUP_V_CZ_NPP2006_nk_des",
    
    "CUP_V_CPC_communications_coy",
	"CUP_V_CPC_Fast_coy",
	"CUP_V_CPC_light_coy",
	"CUP_V_CPC_medical_coy",
	"CUP_V_CPC_tl_coy",
	"CUP_V_CPC_weapons_coy",
	"CUP_V_CPC_communicationsbelt_coy",
	"CUP_V_CPC_Fastbelt_coy",
	"CUP_V_CPC_lightbelt_coy",
	"CUP_V_CPC_medicalbelt_coy",
	"CUP_V_CPC_tlbelt_coy",
	"CUP_V_CPC_weaponsbelt_coy",
	"CUP_V_CPC_communications_mc",
	"CUP_V_CPC_Fast_mc",
	"CUP_V_CPC_light_mc",
	"CUP_V_CPC_medical_mc",
	"CUP_V_CPC_tl_mc",
	"CUP_V_CPC_weapons_mc",
	"CUP_V_CPC_communicationsbelt_mc",
	"CUP_V_CPC_Fastbelt_mc",
	"CUP_V_CPC_lightbelt_mc",
	"CUP_V_CPC_medicalbelt_mc",
	"CUP_V_CPC_tlbelt_mc",
	"CUP_V_CPC_weaponsbelt_mc",
	"CUP_V_CPC_communications_rngr",
	"CUP_V_CPC_Fast_rngr",
	"CUP_V_CPC_light_rngr",
	"CUP_V_CPC_medical_rngr",
	"CUP_V_CPC_tl_rngr",
	"CUP_V_CPC_weapons_rngr",
	"CUP_V_CPC_communicationsbelt_rngr",
	"CUP_V_CPC_Fastbelt_rngr",
	"CUP_V_CPC_lightbelt_rngr",
	"CUP_V_CPC_medicalbelt_rngr",
	"CUP_V_CPC_tlbelt_rngr",
	"CUP_V_CPC_weaponsbelt_rngr",


	
	//Tarkov Vests
    "Gjel_vest",
    "GjelBlackRock_vest",
    "GjelThunderbolt_vest",
    "GjelTriton_vest",
    "M1_vest",
    "M2_vest",
    "Module3m_vest",
    "Module3mAssault_vest",
    "Module3mD3CRX_vest",
    "Module3mThunderbolt_vest",
    "Module3mTriton_vest",
    "Module3mTV109_vest",
    "Slick_vest",
    "SlickMK3_vest",
    "SlickBlackRock_vest",
    "SlickTV109_vest",
	"Thorcrv_vest",
    "ThorcrvBlackRock_vest",
	"ThorcrvThunderbolt_vest",
	"ThorcrvTriton_vest",
	
	//JCA Vests
	"JCA_V_CarrierRigKBT_01_combat_MTP_alpine_F",
	"JCA_V_CarrierRigKBT_01_combat_MTP_arid_F",
	"JCA_V_CarrierRigKBT_01_combat_MTP_desert_F",
	"JCA_V_CarrierRigKBT_01_combat_MTP_tropic_F",
	"JCA_V_CarrierRigKBT_01_combat_MTP_woodland_F",
	"JCA_V_CarrierRigKBT_01_combat_black_F",
	"JCA_V_CarrierRigKBT_01_combat_olive_F",
	"JCA_V_CarrierRigKBT_01_combat_sand_F",
	"JCA_V_CarrierRigKBT_01_compact_MTP_alpine_F",
	"JCA_V_CarrierRigKBT_01_compact_MTP_arid_F",
	"JCA_V_CarrierRigKBT_01_compact_MTP_desert_F",
	"JCA_V_CarrierRigKBT_01_compact_MTP_tropic_F",
	"JCA_V_CarrierRigKBT_01_compact_MTP_woodland_F",
	"JCA_V_CarrierRigKBT_01_compact_black_F",
	"JCA_V_CarrierRigKBT_01_compact_olive_F",
	"JCA_V_CarrierRigKBT_01_compact_sand_F",
	"JCA_V_CarrierRigKBT_01_crew_MTP_alpine_F",
	"JCA_V_CarrierRigKBT_01_crew_MTP_arid_F",
	"JCA_V_CarrierRigKBT_01_crew_MTP_desert_F",
	"JCA_V_CarrierRigKBT_01_crew_MTP_tropic_F",
	"JCA_V_CarrierRigKBT_01_crew_MTP_woodland_F",
	"JCA_V_CarrierRigKBT_01_crew_black_F",
	"JCA_V_CarrierRigKBT_01_crew_olive_F",
	"JCA_V_CarrierRigKBT_01_crew_sand_F",	
	"JCA_V_CarrierRigKBT_01_light_MTP_alpine_F",
	"JCA_V_CarrierRigKBT_01_light_MTP_arid_F",
	"JCA_V_CarrierRigKBT_01_light_MTP_desert_F",
	"JCA_V_CarrierRigKBT_01_light_MTP_tropic_F",
	"JCA_V_CarrierRigKBT_01_light_MTP_woodland_F",
	"JCA_V_CarrierRigKBT_01_light_black_F",
	"JCA_V_CarrierRigKBT_01_light_olive_F",
	"JCA_V_CarrierRigKBT_01_light_sand_F",
	"JCA_V_CarrierRigKBT_01_recon_MTP_alpine_F",
	"JCA_V_CarrierRigKBT_01_recon_MTP_arid_F",
	"JCA_V_CarrierRigKBT_01_recon_MTP_desert_F",
	"JCA_V_CarrierRigKBT_01_recon_MTP_tropic_F",
	"JCA_V_CarrierRigKBT_01_recon_MTP_woodland_F",
	"JCA_V_CarrierRigKBT_01_recon_black_F",
	"JCA_V_CarrierRigKBT_01_recon_olive_F",
	"JCA_V_CarrierRigKBT_01_recon_sand_F",
    
    //============================================================
    //Helmets
    //============================================================

    "H_HelmetB_Enh_tna_F",
    "H_HelmetSpecB",
    "H_HelmetSpecB_blk",
    "H_HelmetSpecB_paint2",
    "H_HelmetSpecB_paint1",
    "H_HelmetSpecB_sand",
    "H_HelmetSpecB_snakeskin",
    "H_HelmetSpecB_wdl",

    "mjb_H_HelmetSpecB_winter",

    "CUP_H_RUS_K6_3_black",
    "CUP_H_RUS_K6_3_Goggles_black",

    //============================================================
    //ACRE radio
    //============================================================
    "ACRE_PRC343",

    //============================================================
    //Tools and misc
    //============================================================
    //ACE
	"ACE_CableTie",
    "ACE_Flashlight_XL50",
    "ACE_MapTools",
    "ACE_RangeCard",
	"ACE_RangeTable_82mm",
	"ACE_artilleryTable",
    "ACE_IR_Strobe_Item",

    //BIS
    "ItemCompass",
    "ItemMap",
    "ItemWatch",
    "Laserbatteries",
    "ItemGPS",
    "ACE_microDAGR",

    //Diwako
    //"diw_armor_plates_main_plate",

    //Greenmag speedloader
    "greenmag_item_speedloader",

    // Ctab
    "ItemcTabHCam",
    "ItemMicroDAGR",
	"ItemAndroid",
    "ItemAndroidMisc",
    "ItemMicroDAGRMisc"
];

private _itemUniforms = [
	//============================================================
    //Non-Tarkov uniforms
    //============================================================
    //Female outfit models
    "U_B_CombatUniform_mcam_W",
    "U_B_CombatUniform_mcam_WO",
    "U_B_CombatUniform_mcam_tshirt_W",
    "WU_B_T_Soldier_F",
    "WU_B_T_Soldier_AR_F",
    "WU_B_GEN_Soldier_F",
    "WU_B_GEN_Commander_F",

    //Drip
    "CUP_U_I_GUE_Anorak_01",
    "CUP_U_I_GUE_Flecktarn3",
    "rhsgref_uniform_alpenflage",
    "rhsgref_uniform_3color_desert",

    //Vanilla stuff
    "U_B_CombatUniform_mcam",
    "U_B_CombatUniform_mcam_tshirt",
    "U_B_T_Soldier_F",
    "U_B_T_Soldier_AR_F",

    // CUP Blyat
    "CUP_U_O_CHDKZ_Lopotev",
    "CUP_U_C_Tracksuit_01",
    "CUP_U_C_Tracksuit_02",
    "CUP_U_C_Tracksuit_03",
    "CUP_U_C_Tracksuit_04",

	// Various CUP Uniforms
	"CUP_U_B_USMC_MCCUU_des_pads_gloves",
	"CUP_U_B_USMC_MCCUU_des_roll_pads_gloves",
	"CUP_U_B_USMC_MCCUU_des_roll_2_pads_gloves",
	"CUP_U_B_USMC_MCCUU_des_roll_2_gloves",
	"CUP_U_B_USMC_MCCUU_des_roll_gloves",
	"CUP_U_B_USMC_MCCUU_des_gloves",
	"CUP_U_B_USMC_MCCUU_des",
	"CUP_U_B_USMC_MCCUU_des_roll",
	"CUP_U_B_USMC_MCCUU_des_roll_2",
	"CUP_U_B_USMC_MCCUU_des_roll_2_gloves",
	"CUP_U_B_USMC_MCCUU_des_roll_gloves",
	"CUP_U_B_USMC_MCCUU_des_gloves",
	"CUP_U_B_USMC_MCCUU_M81_pads_gloves",
	"CUP_U_B_USMC_MCCUU_M81_roll_pads_gloves",
	"CUP_U_B_USMC_MCCUU_M81_roll_2_pads_gloves",
	"CUP_U_B_USMC_MCCUU_M81_gloves",
	"CUP_U_B_USMC_MCCUU_M81_roll_gloves",
	"CUP_U_B_USMC_MCCUU_M81_roll_2_gloves",
	"CUP_U_B_USMC_MCCUU_M81",
	"CUP_U_B_USMC_MCCUU_M81_roll",
	"CUP_U_B_USMC_MCCUU_M81_roll_2",
	"CUP_U_B_USMC_MCCUU_M81_pads",
	"CUP_U_B_USMC_MCCUU_M81_roll_pads",
	"CUP_U_B_USMC_MCCUU_M81_roll_2_pads",
	"CUP_U_B_USMC_MCCUU_pads_gloves",
	"CUP_U_B_USMC_MCCUU_roll_pads_gloves",
	"CUP_U_B_USMC_MCCUU_roll_2_pads_gloves",
	"CUP_U_B_USMC_MCCUU_gloves",
	"CUP_U_B_USMC_MCCUU_roll_gloves",
	"CUP_U_B_USMC_MCCUU_roll_2_gloves",
	"CUP_U_B_USMC_MCCUU",
	"CUP_U_B_USMC_MCCUU_roll",
	"CUP_U_B_USMC_MCCUU_roll_2",
	"CUP_U_B_USMC_MCCUU_pads",
	"CUP_U_B_USMC_MCCUU_roll_pads",
	"CUP_U_B_USMC_MCCUU_roll_2_pads",
	"CUP_U_B_HIL_ACU_Kneepad_Gloves_CCE",
	"CUP_U_B_HIL_ACU_Kneepad_Rolled_Gloves_CCE",
	"CUP_U_B_HIL_ACU_Gloves_CCE",
	"CUP_U_B_HIL_ACU_Rolled_Gloves_CCE",
	"CUP_U_B_HIL_ACU_CCE",
	"CUP_U_B_HIL_ACU_Gloves_CCE",
	"CUP_U_B_AFU_ACU_M14",
	"CUP_U_B_AFU_ACU_Rolled_M14",
	"CUP_U_B_AFU_ACU_Kneepad_M14",
	"CUP_U_B_AFU_ACU_Kneepad_Rolled_M14",
	"CUP_U_B_AFU_ACU_Kneepad_Gloves_M14",
	"CUP_U_B_AFU_ACU_Kneepad_Rolled_Gloves_M14",
	"CUP_U_B_HIL_ACU_Kneepad_Gloves_TTS",
	"CUP_U_B_HIL_ACU_Kneepad_Rolled_Gloves_TTS",
	"CUP_U_B_HIL_ACU_Gloves_TTS",
	"CUP_U_B_HIL_ACU_Rolled_Gloves_TTS",
	"CUP_U_B_HIL_ACU_TTS",
	"CUP_U_B_HIL_ACU_Rolled_TTS",
    "CUP_U_B_BDUv2_gloves_Tigerstripe",
    "CUP_U_B_BDUv2_roll2_gloves_Tigerstripe",
    "CUP_U_B_BDUv2_roll_gloves_Tigerstripe",
    "CUP_U_B_BDUv2_gloves_Urban",
    "CUP_U_B_BDUv2_roll2_gloves_Urban",
    "CUP_U_B_BDUv2_roll_gloves_Urban",
    "CUP_U_CRYE_G3C_AOR2",
    "CUP_U_CRYE_G3C_AOR1",
    "CUP_U_CRYE_G3C_M81",
    "CUP_U_CRYE_MCAM_NP_Full",
    "CUP_U_CRYE_MCAM_NP_Roll",
    "CUP_U_CRYE_RGR_Full",
    "CUP_U_CRYE_RGR_Roll",
    "CUP_U_B_USMC_FROG1_WMARPAT",
    "CUP_U_B_USMC_FROG2_DMARPAT",
    "rhs_uniform_FROG01_wd"
];
_itemEquipment append _itemUniforms;

private _itemHats = [
    "H_Bandanna_gry",
    "H_Bandanna_camo",
    "H_Bandanna_sgg",
    "H_Bandanna_cbr",
    "H_Bandanna_khk",
    "H_Bandanna_sand",
    "CUP_H_RUS_Bandana_GSSh_Headphones",
    "CUP_H_RUS_Bandana_HS",
    "CUP_H_FR_BandanaWdl",

    "H_Booniehat_tna_F",
    "H_Booniehat_tan",
    "H_Booniehat_taiga",
    "H_Booniehat_oli",
    "H_Booniehat_wdl",
    "CUP_H_FR_BoonieWDL",
    "rhsgref_Booniehat_alpen",

    "H_Cap_blk",
    "H_Cap_oli",
    "H_Cap_tan",
    "H_Cap_headphones",
    "CUP_H_FR_Cap_Headset_Green",
    "CUP_H_PMC_Cap_Burberry",
    CUP_HAT(Burberry),
    CUP_HAT(Grey),
    CUP_HAT(tan),
    "rhsgref_bcap_specter",
    "rhsusf_bowman_cap",
    "mjb_H_Cap_Voin",

    "CUP_H_PMC_PRR_Headset",

    // blyat
    "rhs_ushanka",
    "CUP_H_C_Ushanka_01",
    "CUP_H_C_Ushanka_02",
    "CUP_H_C_Ushanka_04",
    "CUP_H_C_Ushanka_03",

    "H_Watchcap_blk",
    "H_Watchcap_khk",
    "H_Watchcap_cbr",
    "H_Watchcap_camo",
    "CUP_H_C_Beanie_02",
    "CUP_H_PMC_Beanie_Black",
    "CUP_H_PMC_Beanie_Headphones_Black",
    "CUP_H_PMC_Beanie_Khaki",
    "CUP_H_PMC_Beanie_Headphones_Khaki",
    "rhs_beanie_green",
    "rhs_beanie",

    "H_Hat_camo",

    //RHS headset cosmetics
    "rhs_6m2_nvg",
    "rhs_6m2_1_nvg",
    "rhs_facewear_6m2",
    "rhs_facewear_6m2_1"
];
_itemEquipment append _itemHats;

private _itemNVG =
[
    "NVGoggles",
    "NVGoggles_OPFOR",

    "ACE_NVGoggles_WP",
    "ACE_NVGoggles_OPFOR_WP",

    "CUP_NVG_GPNVG_black",
    "CUP_NVG_GPNVG_winter",
    "CUP_NVG_GPNVG_tan",
	"CUP_NVG_GPNVG_green",

    "CUP_NVG_GPNVG_black_WP",
    "CUP_NVG_GPNVG_winter_WP",
    "CUP_NVG_GPNVG_tan_WP",
	"CUP_NVG_GPNVG_green_WP"
];
_itemEquipment append _itemNVG;

private _itemArmNVG = (("'Hartman' in (getText (_x >> 'author'))" configClasses (configFile >> "CfgWeapons") apply {configName _x}) - ['G_Armband_NVG_Cross_F','G_Armband_NVG_Cross_alt_F']); // ['Aegis and Hartman','Anthrax and Hartman']
_itemEquipment append _itemArmNVG;

private _itemWeaponMelee =
[
    "Crowbar",
    "WBK_Katana",
    "Weap_melee_knife",
    "Knife_kukri",
    "WBK_pipeStyledSword"
];
_itemEquipment append _itemWeaponMelee;

private _itemPackLight = [
	//============================================================
    //Backpacks
    //============================================================
    
	"CUP_B_AssaultPack_ACU",
	"B_AssaultPack_blk",
	"B_AssaultPack_rgr",
    "B_AssaultPack_cbr",
    "B_AssaultPack_khk",
    "B_AssaultPack_mcamo",
	"B_AssaultPack_dgtl",
    "B_AssaultPack_tna_F",
	"B_AssaultPack_ocamo",
	"B_AssaultPack_sgg"
];
_itemEquipment append _itemPackLight;

private _itemPackMedLight =
[
    "B_FieldPack_oucamo",
    "B_Kitbag_rgr",
    "B_Kitbag_cbr",
    "B_Kitbag_sgg",
    "B_Kitbag_tan",
    "B_Kitbag_mcamo",
    "CUP_B_GER_Pack_Flecktarn",
    "CUP_B_GER_Pack_Tropentarn",
	"CUP_B_Bergen_BAF",
	"CUP_B_CivPack_WDL",
	"CUP_B_AFU_IIID_MM14",
	"CUP_B_USPack_Black",
	"CUP_B_US_IIID_OEFCP",
	"CUP_B_US_IIID_OCP",
	"CUP_B_US_IIID_UCP"	
];

private _itemPackMedium =
[
	"B_Carryall_cbr",
    "B_Carryall_taiga_F",
    "B_Carryall_eaf_F",
    "B_Carryall_oli",
    "rhs_tortila_grey",
    "rhs_tortila_khaki",
    "rhs_tortila_olive"
];
_itemPackMedium append _itemPackMedLight;

private _winterCamo = [];
private _itemSantaH = [];
if (_winter) then {
   _winterCamo =
    [
        "CUP_I_B_PMC_Unit_29",
        "CUP_I_B_PMC_Unit_30",
        "CUP_I_B_PMC_Unit_33",
        "CUP_I_B_PMC_Unit_34",

        "CUP_H_PMC_Beanie_Winter",
        "CUP_H_PMC_Beanie_Headphones_Winter",

        "CUP_O_RUS_Patrol_bag_Winter"
    ];
    _itemEquipment append _winterCamo;

	_itemSantaH = ("getText (_x >> 'descriptionShort') isEqualTo 'Festive Santa Hat'" configClasses (configFile >> "CfgWeapons") apply {configName _x});
	_itemEquipment append _itemSantaH;
};

private _itemPackHeavy =
[
    "mjb_carryallplus_cbr",
    "mjb_carryallplus_taiga_F",
    "mjb_carryallplus_eaf_F",
    "mjb_carryallplus_oli",
    "mjb_carryallplus_grey",
    "mjb_carryallplus_khaki",
    "mjb_carryallplus_olive",

    "B_Bergen_mcamo_F",
    "B_Bergen_tna_F",
    "B_Bergen_dgtl_F",
    "B_Bergen_hex_F",
    "Blackjack50",
    "B6SH118"
];
_itemPackHeavy append _itemPackMedium;

private _itemFacewear = (("getNumber (_x >> 'scope') isEqualTo 2" configClasses (configFile >> "CfgGlasses") apply {configName _x})- ['G_Armband_Cross_F','G_Armband_Cross_alt_F']);
/*private _itemFacewear =
[
    //Vanilla
    "G_Balaclava_blk",
    "G_Bandanna_khk",
    "G_Bandanna_tan",
    "G_Bandanna_oli",
    "G_Bandanna_shades",
    "G_Shades_Black",
    "G_Balaclava_lowprofile",
    "G_Lowprofile",
    "G_Squares",
    "G_Tactical_Clear",
    "G_Aviator",
	"G_Balaclava_Flecktarn",
	"G_Balaclava_Tropentarn",
	"G_Balaclava_oli",
	"G_Balaclava_combat",
	"G_Bandanna_beast",
	"G_Bandanna_BlueFlame2",
	"G_Bandanna_RedFlame1",
	"G_Bandanna_Vampire_01",

    //CUP
    "CUP_G_ESS_BLK",
    "CUP_G_ESS_BLK_Scarf_Face_Blk",
    "CUP_G_ESS_BLK_Facewrap_Black",
    "CUP_G_ESS_BLK_Scarf_Grn",
    "CUP_G_ESS_BLK_Dark",
    "CUP_G_ESS_BLK_Scarf_Face_Grn",
    "CUP_G_ESS_KHK_Scarf_Tan",
    "CUP_G_ESS_KHK_Scarf_Face_Tan",
    "CUP_G_ESS_BLK_Scarf_White",
    "CUP_G_ESS_BLK_Scarf_Face_White",

    "CUP_PMC_Facewrap_Black",
    "CUP_G_PMC_Facewrap_Black_Glasses_Dark",
    "CUP_PMC_Facewrap_Tan",
    "CUP_G_PMC_Facewrap_Tan_Glasses_Dark",
    "CUP_PMC_Facewrap_Tropical",
    "CUP_G_PMC_Facewrap_Tropical_Glasses_Dark",
    "CUP_PMC_Facewrap_Winter",
    "CUP_G_PMC_Facewrap_Winter_Glasses_Dark",

    "CUP_G_Oakleys_Clr",
    "CUP_G_Oakleys_Drk",
    "CUP_G_Oakleys_Embr",
    "CUP_G_TK_RoundGlasses_blk",
    "CUP_PMC_G_thug",

    "CUP_G_Scarf_Face_Blk",
    "CUP_G_Scarf_Face_Grn",
    "CUP_G_Scarf_Face_Tan",
    "CUP_G_Scarf_Face_White",

    "CUP_FR_NeckScarf",
    "CUP_FR_NeckScarf2",
    "CUP_FR_NeckScarf3",
    "CUP_FR_NeckScarf4",
    "CUP_FR_NeckScarf5",

    "CUP_RUS_Balaclava_blk",
    "CUP_RUS_Balaclava_grn",
    "CUP_RUS_Balaclava_rgr",

    //RHS
    "rhs_balaclava"
];*/

private _itemSpecial =
[
    //============================================================
    //Binoculars and rangefinders
    //============================================================
    //BIS
    "Binocular",
    "Rangefinder",
    "Laserdesignator",
    "Laserdesignator_01_khk_F",
    "Laserdesignator_03",
    "ACE_Vector",

    //RHS
    "rhsusf_bino_lerca_1200_black",
    "rhsusf_bino_lerca_1200_tan",
    "rhsusf_bino_m24",
    "rhsusf_bino_m24_ard",

    //============================================================
    //Explosives
    //============================================================

    //============================================================
    //Radios
    //============================================================
    "ACRE_PRC148",
    "ACRE_PRC152",
    "ACRE_PRC117F"
];

private _itemMod =
[
    //============================================================
    // Magnified Optics (2-3x)
    //============================================================
    //Vanilla
    "optic_arco_blk_F",
    "optic_hamr",
    "optic_mrco",

    //CUP Magnified Sights
    "cup_optic_aimm_microt1_blk",
    "cup_optic_aimm_compm2_blk",
    "cup_optic_aimm_compm4_blk",
    "cup_optic_aimm_zddot_blk",
    "CUP_optic_G33_HWS_BLK",

    "tier1_exps3_0_g33_black_up",
    "tier1_exps3_0_g33_riser_black_up",
    "tier1_exps3_0_g33_tano_up",
    "Tier1_EXPS3_0_G33_Riser_Tano_Up",
    "Tier1_Romeo4T_BCD_G33_Black_Up",
    "Tier1_Romeo4T_BCD_G33_Riser_Black_Up",
    "Tier1_Romeo4T_BCQ_G33_Black_Up",
    "Tier1_Romeo4T_BCQ_G33_Riser_Black_Up",
    "Tier1_Microt2_G33_Black_Up",
    "Tier1_Microt2_G33_Riser_Black_Up",

	//MCC 3x
    "MCC_EXPS3_BLK_Up",
    "MCC_EXPS3_FDE_Down",
	"MCC_EXPS3_UnityX_BLK_Up",
	"MCC_EXPS3_UnityX_FDE_Up",
	"MCC_GBRS_EXPS3_Mag_Up_BLK",
	"MCC_GBRS_EXPS3_Mag_Up_FDE",
	"MCC_MicroT2_UnityX_BLK_Up",
	"MCC_MicroT2_UnityX_FDE_Up",
	"MCC_GBRS_T2_Mag_Up_BLK",
	"MCC_GBRS_T2_Mag_Up_FDE",
	"MCC_Romeo9T_BLK_Up",
    "MCC_Romeo9T_FDE_Up",

    //Dovetail (Ak Sights)
    "CUP_optic_pechenegscope", // 2.8x
	"CUP_optic_PGO7V3",

    "rhs_acc_1p78", // 2x
    "rhs_acc_pgo7v3",

    //Others
    //============================================================
    //Muzzle Devices
    //============================================================
	"CUP_muzzle_mfsup_Zendl",
	"CUP_muzzle_mfsup_Zendl_desert",
	"CUP_muzzle_mfsup_Zendl_woodland",
	"CUP_acc_sffh",
	"CUP_muzzle_mfsup_SCAR_L",
	"CUP_muzzle_mfsup_SCAR_H",
	"CUP_muzzle_mfsup_Flashhider_556x45_Black",
	"CUP_muzzle_mfsup_Flashhider_545x39_Black",
	"CUP_muzzle_mfsup_Flashhider_762x39_Black",
	"CUP_muzzle_mfsup_Flashhider_762x51_Black",
	"CUP_muzzle_mfsup_Flashhider_PK_Black",
	"CUP_muzzle_mfsup_CSA",
	"CUP_muzzle_mfsup_CSA_desert",
	"CUP_muzzle_mfsup_CSA_woodland",
	"CUP_muzzle_mfsup_flashhider_Sa58",
	"CUP_muzzle_fh_MP5",

    "rhsgref_acc_zendl",
    "rhs_acc_dtk",
    "rhs_acc_dtk1983",
    "rhs_acc_dtk4short",
    "rhs_acc_pgs64",
    "rhsusf_acc_ardec_m240",

    "Tier1_Gemtech_Halo",
    "Tier1_SOCOM762_2_DE",
    "Tier1_SOCOM762_2_Black",
    "Tier1_kac_556_qdc_cqb_black",

	"MCC_CGS6_FH",
	"MCC_JK_WarEagle",
	"MCC_KAC_3PFDE",
	"MCC_SUREFIRE_RBC",
	"MCC_SF4P_556",
	"MCC_WARCOMP_556",
	"MCC_Warden",
	"MCC_Warden_FDE",
	"MCC_RotexV_D_556",
	"MCC_RotexV_D_556_FDE",
	"MCC_RotexV_D_556_GRY",

    //============================================================
    //Bipod & Foregrips
    //============================================================
    "CUP_bipod_Harris_1A2_L_BLK",
    "cup_bipod_sa58",

    "rhsusf_acc_grip2",
    "rhsusf_acc_kac_grip",
    "rhsusf_acc_rvg_blk",
    "rhs_acc_grip_rk2",
    "rhs_acc_grip_rk6",
    "rhsusf_acc_grip_m203_blk",
    "rhs_acc_harris_swivel",
    "rhsusf_acc_kac_grip_saw_bipod",
    "rhsusf_acc_grip4_bipod",
    "rhsusf_acc_grip4",
    "rhsusf_acc_saw_lw_bipod",

    "Tier1_SAW_Bipod_DD",
    "Tier1_MVG_MLOK_Black",
    "Tier1_AFG_MLOK_Black",
    "Tier1_Larue_FUG_Black",
    "Tier1_Harris_Bipod_Black",
    "Tier1_Harris_Bipod_Tan",
    "Tier1_Harris_Bipod_MLOK_Black_2",

    //============================================================
    //Other rail attachments
    //============================================================
	"ACE_DBAL_A3_Red",
	"ACE_DBAL_A3_Red_IP",
	"ACE_DBAL_A3_Red_II",
	"ACE_DBAL_A3_Red_VP",
	//"ACE_DBAL_A3_Red_LR",
	//"ACE_DBAL_A3_Red_LR_IP",
	//"ACE_DBAL_A3_Red_LR_II",
	//"ACE_DBAL_A3_Red_LR_VP",
	"ACE_DBAL_A3_Green",
	"ACE_DBAL_A3_Green_IP",
	"ACE_DBAL_A3_Green_II",
	"ACE_DBAL_A3_Green_VP",
	//"ACE_DBAL_A3_Green_LR",
	//"ACE_DBAL_A3_Green_LR_IP",
	//"ACE_DBAL_A3_Green_LR_II",
	//"ACE_DBAL_A3_Green_LR_VP",
	"ACE_SPIR",
	"ACE_SPIR_Medium",
	"ACE_SPIR_Narrow",
	//"ACE_SPIR_LR",
	//"ACE_SPIR_LR_Medium",
	//"ACE_SPIR_LR_Narrow",

    "cup_acc_flashlight",
    "CUP_acc_anpeq_15",
    "CUP_acc_anpeq_15_tan_Top",
    "CUP_acc_anpeq_15_Flashlight_tan_L",
    "CUP_acc_anpeq_15_Top_Flashlight_tan_L",
    "CUP_acc_anpeq_15_Black",
    "CUP_acc_anpeq_15_Black_Top",
    "CUP_acc_anpeq_15_Flashlight_Black_L",
    "CUP_acc_anpeq_15_Top_Flashlight_Black_L",
    "CUP_acc_llm_black",

    "rhsusf_acc_anpeq15side_bk",
    "rhsusf_acc_anpeq15_bk_top",
    "rhsusf_acc_wmx_bk",
    "rhsusf_acc_anpeq15_wmx",
    "rhsusf_acc_m952v",
    "rhsusf_acc_anpeq15_bk",
    "rhsusf_acc_anpeq16a",
    "rhsusf_acc_anpeq16a_top",
    "rhs_acc_2dpzenit",
    "rhs_acc_2dpzenit_ris",
    "rhs_acc_perst1ik",
    "rhs_acc_perst1ik_ris",
    "rhs_acc_perst3",
    "rhs_acc_perst3_top",
    "rhs_acc_perst3_2dp_h",

    "Tier1_ngal_side",
    "Tier1_m300c_black",
    "Tier1_RAHG_NGAL_M600V_Black_FL",
    "Tier1_416_LA5_M600V_Black_FL",
    "Tier1_DBALPL_FL",
    "Tier1_MW_NGAL_M600V_Black_FL",
    "Tier1_Mk18_LA5_M600V_Black_FL",
    "Tier1_Mk18_NGAL_M300C_Black_FL",
    "Tier1_Mk18_NGAL_M603V_FL",
    "Tier1_MP7_NGAL_M300C_Black_FL",
    "Tier1_10_LA5_Side",
    "Tier1_SCAR_NGAL_M300C_FL",
    "Tier1_M4BII_NGAL_M300C_Black_FL",
    "Tier1_SR25_LA5_Side",
    "tier1_mcx_ngal_m600v_black",
    "tier1_mcx_la5_side",
    "tier1_mk46mod0_la5_m600v_black"
];

// All muzzle devices, except the L85 blank firing adapter, and some bipods for some reason
private _itemSuppressor = (("getNumber (_x >> 'scope') isEqualTo 2 && {getNumber (_x >> 'ItemInfo' >> 'type') isEqualTo 101}" configClasses (configFile >> "CfgWeapons") apply {configName _x}) - ["CUP_acc_bfa"]);

// Non-suppressor
private _itemMuzzle = (_itemSuppressor select {getNumber (configFile >> 'CfgWeapons' >> _x >> 'ItemInfo' >> 'soundTypeIndex') isNotEqualTo 1});
_itemMod append _itemMuzzle;

/*private _itemSuppressor = [
	// rifle
    "CUP_muzzle_snds_socom762rc",
    "CUP_muzzle_snds_G36_black",
    "CUP_muzzle_snds_FAMAS",
    "CUP_muzzle_snds_M16",
    "CUP_muzzle_snds_SCAR_L",
    "CUP_muzzle_TGPA",
    "CUP_muzzle_snds_KZRZP_AK545",
    "CUP_muzzle_snds_KZRZP_AK762",
    "CUP_muzzle_snds_groza",

    "cup_muzzle_snds_68spc",

    "rhsusf_acc_nt4_black", // New nicer 5.56/mk20 suppressors
    "rhsusf_acc_nt4_tan",
    "rhsusf_acc_rotex5_grey",
    "rhs_acc_pbs1",
    "rhs_acc_tgpv2",
    "rhsgref_sdn6_suppressor",

	"muzzle_snds_65_ti_blk_f", // for persistent stuff
	"muzzle_snds_338_black",
	"muzzle_snds_93mmg",
	"muzzle_snds_570",
	"muzzle_snds_58_blk_f",

	// cqb
    "CUP_muzzle_snds_mp5",
    "CUP_muzzle_snds_sa61",
    //"CUP_muzzle_mfsup_suppressor_mac10",
    "CUP_muzzle_Bizon",
    "cup_muzzle_snds_sr3m",

    "rhsusf_acc_rotex_mp7",

	// AR
    "cup_muzzle_snds_l85",

	//pistol
    "muzzle_snds_l",
    "cup_muzzle_snds_mk23",
    "cup_acc_mk23_lam_f"

];*/

private _itemReflexSight =
[
    //Vanilla
    "optic_yorris",
    "optic_aco",
    "optic_holosight_blk_f",

    //CUP Reflex Sights
    "cup_optic_ac11704_black",
    "cup_optic_mrad",
    "cup_optic_vortexrazor_uh1_black",
    "cup_optic_eotech553_black",
    "cup_optic_compm4",
    "cup_optic_okp_7_rail",
    "cup_optic_mepro",
    "CUP_optic_MEPRO_openx_orange",
    "CUP_optic_TrijiconRx01_black",
    "CUP_optic_ZeissZPoint",

    //RHS Reflex
    "rhsusf_acc_compm4",
    "rhsusf_acc_mrds",
    "rhsusf_acc_mrds_fwd",
    "rhsusf_acc_RX01_NoFilter",
    "rhsusf_acc_eotech_xps3",
    "rhs_acc_ekp8_18",
    "rhsusf_acc_t1_low",
    "rhsusf_acc_t1_low_fwd",

    //MCC
	"MCC_EXPS3_BLK",
	"MCC_EXPS3_FDE",
    "MCC_EXPS3_UnityX_BLK",
    "MCC_EXPS3_UnityX_FDE",
	"MCC_MicroT2",
    "MCC_MicroT2_UnityX_BLK",
    "MCC_MicroT2_UnityX_FDE",
    "MCC_GBRS_T2_BLK",
    "MCC_GBRS_T2_FDE",
    "MCC_GBRS_EXPS3_BLK",
	"MCC_GBRS_EXPS3_FDE",
	"MCC_Romeo9t_blk",
    "MCC_Romeo9t_fde",

    "Tier1_EXPS3_0_Tano",
    "tier1_romeo4t_bcd_black",
    "tier1_romeo4t_bcd_riser_black",
    "tier1_romeo4t_bcq_black",
    "tier1_romeo4t_bcq_riser_black",

    //Dovetail (Ak Sights)
    "CUP_optic_ekp_8_02",
    "CUP_optic_Kobra",
    "CUP_optic_1p63",
    "CUP_optic_okp_7",

    "rhs_acc_pkas",
    "rhs_acc_ekp1",
    "rhs_acc_ekp8_02",
    "rhs_acc_npz" // B-13 adapter, doesn't get saved in loadouts regardless ;-;
];

private _itemWeaponPistol =
[
    //Pistols
    "CUP_hgun_Browning_HP",
    "CUP_hgun_CZ75",
    "CUP_hgun_M17_Black",
    "CUP_hgun_Makarov",
    "CUP_hgun_Mk23",
    "CUP_hgun_M9A1",
    "CUP_hgun_Colt1911",
    "CUP_hgun_Glock17_blk",
    "CUP_hgun_TT",

    "rhs_weap_pya",
    "Tier1_P320",

    //Magazines
    "CUP_13Rnd_9x19_Browning_HP",
    "CUP_16Rnd_9x19_cz75",
    "CUP_17Rnd_9x19_M17_Black",
    "CUP_8Rnd_9x18_Makarov_M",
    "CUP_12Rnd_45ACP_mk23",
    "CUP_15Rnd_9x19_M9",
    "CUP_7Rnd_45ACP_1911",
    "CUP_17Rnd_9x19_glock17",
    "CUP_8Rnd_762x25_TT",

    "rhs_mag_9x19_17",

    "Tier1_15Rnd_9x19_JHP",
    "Tier1_17Rnd_9x19_P320_JHP",

    //Loose ammo
    "greenmag_ammo_9x19_basic_30Rnd",
    "greenmag_ammo_9x21_basic_30Rnd",
    "greenmag_ammo_45ACP_basic_30Rnd",
    "greenmag_ammo_9x18_basic_30Rnd",
    "greenmag_ammo_762x25_ball_30Rnd",

    //Attachments
    "optic_mrd_black",
    "CUP_acc_CZ_M3X",
    "cup_acc_glock17_flashlight",
    "tier1_x300u"
];

private _itemLeaderEquipment =
[
    //Pistols
    "CUP_hgun_TaurusTracker455_gold",
    "CUP_hgun_TaurusTracker455",
    "CUP_hgun_Deagle",
    "hgun_Pistol_heavy_02_F",
    "Tier1_P320_TB",
    "Tier1_Glock19_Urban",
    "Tier1_Glock19_Urban_TB",

    "CUP_6Rnd_45ACP_M",
    "CUP_7Rnd_50AE_Deagle",
    "6Rnd_45ACP_Cylinder",

    //Cute attachments for leaders
    "tier1_agency_compensator",

    // Ctab
    "ItemcTabMisc",
	"ItemAndroid",
    "ItemAndroidMisc",
    "ItemMicroDAGRMisc",

    "greenmag_ammo_50AE_ball_30Rnd", // deagle rounds

    //Hats
    "H_Beret_blk",
    "CUP_H_Beret_HIL",
    "CUP_H_SLA_BeretRed",
    "CUP_H_ChDKZ_Beret",

    // demo
    "DemoCharge_Remote_Mag",
    "ACE_Clacker"
];

private _itemWeaponRifle =
[
    //============================================================
    //5.56x45mm
    //============================================================
    "arifle_Mk20_plain_F",
    "arifle_TRG21_F",

    "CUP_arifle_G36KA3_grip",

    "CUP_arifle_XM8_Railed",

    "CUP_arifle_ACR_blk_556",
    "CUP_arifle_ACR_snw_556",
    "CUP_arifle_ACR_tan_556",
    "CUP_arifle_ACR_wdl_556",

    "CUP_CZ_BREN2_556_11",
    "CUP_CZ_BREN2_556_11_Grn",
    "CUP_CZ_BREN2_556_11_Tan",

    "CUP_arifle_HK416_Black",
	"CUP_arifle_HK416_Desert",
	"CUP_arifle_HK416_Wood",
    "rhs_weap_hk416d145",

    "Tier1_HK416D145_MW13_CTR",

	"CUP_arifle_M4A1_SOMMOD_black",
    "CUP_arifle_M4A1_SOMMOD_ctrg",
    "CUP_arifle_M4A1_SOMMOD_ctrgt",
    "CUP_arifle_M4A1_SOMMOD_tan",
    "CUP_arifle_M4A1_SOMMOD_hex",
    "CUP_arifle_M4A1_SOMMOD_snow",
    "CUP_arifle_M4A1_SOMMOD_green",
    "CUP_arifle_M4A1_SOMMOD_Grip_black",
    "CUP_arifle_M4A1_SOMMOD_Grip_ctrg",
    "CUP_arifle_M4A1_SOMMOD_Grip_ctrgt",
    "CUP_arifle_M4A1_SOMMOD_Grip_tan",
    "CUP_arifle_M4A1_SOMMOD_Grip_hex",
    "CUP_arifle_M4A1_SOMMOD_Grip_snow",
    "CUP_arifle_M4A1_SOMMOD_Grip_green",
    "rhs_weap_m4a1_blockII_KAC_bk",

    "CUP_Famas_F1_Rail",
    "CUP_Famas_F1_Rail_Arid",
    "CUP_Famas_F1_Rail_Wood",

	"CUP_arifle_M16A4_Base",
    "rhs_weap_m16a4_carryhandle",

    "mjb_arifle_C7Alpha",

    "CUP_arifle_AK101",
    "CUP_arifle_AK101_railed",

    "rhs_weap_vhsd2",
    "rhs_weap_vhsd2_ct15x",

	"Tier1_SIG_MCX_115_Virtus",

    //============================================================
    //5.45x39mm
    //============================================================
    "CUP_arifle_Fort222",
    "CUP_arifle_AK74",
	
	"CUP_arifle_AK74M_top_rail",
    "rhs_weap_ak74m",
    "rhs_weap_ak74m_zenitco01",

	//============================================================
    //7.62x39mm
    //============================================================
    "rhs_weap_savz58v",
    "rhs_weap_savz58v_rail_black",

    "CUP_arifle_TYPE_56_2",
    "CUP_arifle_TYPE_56_2_top_rail",
	"CUP_arifle_AKM",
	"CUP_arifle_AKM_top_rail",
	"CUP_arifle_AK103_top_rail",
	"CUP_arifle_AK103_railed",

    "rhs_weap_akmn",
    "rhs_weap_ak103",
    "rhs_weap_ak103_zenitco01",
    "rhs_weap_pm63",
    "rhs_weap_m70ab2",

    //============================================================
    //7.62x51mm
    //============================================================
    "CUP_arifle_DSA_SA58_OSW_VFG",
	"CUP_arifle_Mk17_CQC",
    "CUP_arifle_Mk17_CQC_AFG",
    "CUP_arifle_Mk17_CQC_FG",
    "CUP_arifle_Mk17_CQC_Black",
    "CUP_arifle_Mk17_CQC_AFG_black",
    "CUP_arifle_Mk17_CQC_FG_black",
    "CUP_arifle_Mk17_CQC_woodland",
    "CUP_arifle_Mk17_CQC_AFG_woodland",
    "CUP_arifle_Mk17_CQC_FG_woodland",
    
    "CUP_arifle_G3A3_ris",
    "CUP_arifle_G3A3_ris_vfg",
    "CUP_arifle_G3A3_modern_ris",
    "CUP_arifle_G3A3_ris_black",
    "CUP_arifle_G3A3_ris_vfg_black",
    "CUP_arifle_G3A3_modern_ris_black",
    
    "rhs_weap_mk17_CQC",
    "rhs_weap_l1a1_wood",
	
	//============================================================
	// MCC 5.56, 5.45, 7.62x39
	//============================================================
	"MCC_KS1_FDE_CTR",
	"MCC_KS1_FDE_Bravo",
	"MCC_KS1_FDE_SLK",
	"MCC_KS1_BLK_CTR",
	"MCC_KS1_BLK_Bravo",
	"MCC_KS1_BLK_SLK",
	"MCC_KS2_FDE_CTR",
	"MCC_KS2_FDE_Bravo",
	"MCC_KS2_FDE_SLK",
	"MCC_KS3_FDE_CTR",
	"MCC_KS3_FDE_Bravo",
	"MCC_KS3_FDE_SLK",
	"MCC_KS3_BLK_CTR",
	"MCC_KS3_BLK_Bravo",
	"MCC_KS3_BLK_SLK",
	"MCC_KS4_FDE_CTR",
	"MCC_KS4_FDE_Bravo",
	"MCC_KS4_FDE_SLK",
	"MCC_KS4_BLK_CTR",
	"MCC_KS4_BLK_Bravo",
	"MCC_KS4_BLK_SLK",
	"MCC_LMT_MARSL_SPECWAR_556_FDE_CTR",
	"MCC_LMT_MARSL_SPECWAR_556_FDE_SOPMOD",
	"MCC_LMT_MARSL_SPECWAR_556_FDE_SLK",
	"MCC_LMT_MARSL_SPECWAR_556_BLK_CTR",
	"MCC_LMT_MARSL_SPECWAR_556_BLK_SOPMOD",
	"MCC_LMT_MARSL_SPECWAR_556_BLK_SLK",
	"MCC_M4A1_556_Aero_16_FDE_CTR",
	"MCC_M4A1_556_Aero_16_FDE_BRAVO",
	"MCC_M4A1_556_Aero_16_FDE_SLK",
	"MCC_M4A1_556_Aero_145_FDE_CTR",
	"MCC_M4A1_556_Aero_145_FDE_BRAVO",
	"MCC_M4A1_556_Aero_145_FDE_SLK",
	"MCC_M4A1_556_Aero_105_FDE_CTR",
	"MCC_M4A1_556_Aero_105_FDE_BRAVO",
	"MCC_M4A1_556_Aero_105_FDE_SLK",
	"MCC_M4A1_556_Aero_85_FDE_CTR",
	"MCC_M4A1_556_Aero_85_FDE_BRAVO",
	"MCC_M4A1_556_Aero_85_FDE_SLK",
	"MCC_M4A1_556_Aero_16_BLK_CTR",
	"MCC_M4A1_556_Aero_16_BLK_BRAVO",
	"MCC_M4A1_556_Aero_16_BLK_SLK",
	"MCC_M4A1_556_Aero_145_BLK_CTR",
	"MCC_M4A1_556_Aero_145_BLK_BRAVO",
	"MCC_M4A1_556_Aero_145_BLK_SLK",
	"MCC_M4A1_556_Aero_105_BLK_CTR",
	"MCC_M4A1_556_Aero_105_BLK_BRAVO",
	"MCC_M4A1_556_Aero_105_BLK_SLK",
	"MCC_M4A1_556_Aero_85_BLK_CTR",
	"MCC_M4A1_556_Aero_85_BLK_BRAVO",
	"MCC_M4A1_556_Aero_85_BLK_SLK",
	"MCC_M4A1_556_Aero_16_OD_CTR",
	"MCC_M4A1_556_Aero_16_OD_BRAVO",
	"MCC_M4A1_556_Aero_16_OD_SLK",
	"MCC_M4A1_556_Aero_145_OD_CTR",
	"MCC_M4A1_556_Aero_145_OD_BRAVO",
	"MCC_M4A1_556_Aero_145_OD_SLK",
	"MCC_M4A1_556_Aero_105_OD_CTR",
	"MCC_M4A1_556_Aero_105_OD_BRAVO",
	"MCC_M4A1_556_Aero_105_OD_SLK",
	"MCC_M4A1_556_Aero_85_OD_CTR",
	"MCC_M4A1_556_Aero_85_OD_BRAVO",
	"MCC_M4A1_556_Aero_85_OD_SLK",
	"MCC_M4A1_556_MFR_16_FDE_CTR",
	"MCC_M4A1_556_MFR_145_FDE_CTR",
	"MCC_M4A1_556_MFR_125_FDE_CTR",
	"MCC_M4A1_556_MFR_105_FDE_CTR",
	"MCC_M4A1_556_MFR_16_BLK_CTR",
	"MCC_M4A1_556_MFR_145_BLK_CTR",
	"MCC_M4A1_556_MFR_125_BLK_CTR",
	"MCC_M4A1_556_MFR_105_BLK_CTR",
	"MCC_M4A1_556_MFR_16_OD_CTR",
	"MCC_M4A1_556_MFR_145_OD_CTR",
	"MCC_M4A1_556_MFR_125_OD_CTR",
	"MCC_M4A1_556_MFR_105_OD_CTR",
	"MCC_M4A1_556_MFR_16_GRY_CTR",
	"MCC_M4A1_556_MFR_145_GRY_CTR",
	"MCC_M4A1_556_MFR_125_GRY_CTR",
	"MCC_M4A1_556_MFR_105_GRY_CTR",
	"MCC_M4A1_556_MFR_16_DE_CTR",
	"MCC_M4A1_556_MFR_145_DE_CTR",
	"MCC_M4A1_556_MFR_125_DE_CTR",
	"MCC_M4A1_556_MFR_105_DE_CTR",
	"MCC_M4A1_556_NFM_145_FDE_CTR",
	"MCC_M4A1_556_NFM_145_FDE_Bravo",
	"MCC_M4A1_556_NFM_145_FDE_SLK",
	"MCC_M4A1_556_NFM_115_FDE_CTR",
	"MCC_M4A1_556_NFM_115_FDE_Bravo",
	"MCC_M4A1_556_NFM_115_FDE_SLK",
	"MCC_M4A1_556_NFM_10_FDE_CTR",
	"MCC_M4A1_556_NFM_10_FDE_Bravo",
	"MCC_M4A1_556_NFM_10_FDE_SLK",
	"MCC_M4A1_556_NFM_145_BLK_CTR",
	"MCC_M4A1_556_NFM_145_BLK_Bravo",
	"MCC_M4A1_556_NFM_145_BLK_SLK",
	"MCC_M4A1_556_NFM_115_BLK_CTR",
	"MCC_M4A1_556_NFM_115_BLK_Bravo",
	"MCC_M4A1_556_NFM_115_BLK_SLK",
	"MCC_M4A1_556_NFM_10_BLK_CTR",
	"MCC_M4A1_556_NFM_10_BLK_Bravo",
	"MCC_M4A1_556_NFM_10_BLK_SLK",
	"MCC_M4A1_556_SMR_145_FDE_CTR",
	"MCC_M4A1_556_SMR_145_FDE_Bravo",
	"MCC_M4A1_556_SMR_145_FDE_SLK",
	"MCC_M4A1_556_SMR_115_FDE_CTR",
	"MCC_M4A1_556_SMR_115_FDE_Bravo",
	"MCC_M4A1_556_SMR_115_FDE_SLK",
	"MCC_M4A1_556_SMR_9_FDE_CTR",
	"MCC_M4A1_556_SMR_9_FDE_Bravo",
	"MCC_M4A1_556_SMR_9_FDE_SLK",
	"MCC_M4A1_556_SMR_145_BLK_CTR",
	"MCC_M4A1_556_SMR_145_BLK_Bravo",
	"MCC_M4A1_556_SMR_145_BLK_SLK",
	"MCC_M4A1_556_SMR_115_BLK_CTR",
	"MCC_M4A1_556_SMR_115_BLK_Bravo",
	"MCC_M4A1_556_SMR_115_BLK_SLK",
	"MCC_M4A1_556_SMR_9_BLK_CTR",
	"MCC_M4A1_556_SMR_9_BLK_Bravo",
	"MCC_M4A1_556_SMR_9_BLK_SLK",
	"MCC_M4A1_556_Troy_16_FDE_CTR",
	"MCC_M4A1_556_Troy_145_FDE_CTR",
	"MCC_M4A1_556_Troy_115_FDE_CTR",
	"MCC_M4A1_556_Troy_9_FDE_CTR",
	"MCC_M4A1_556_Troy_16_FDE_Bravo",
	"MCC_M4A1_556_Troy_145_FDE_Bravo",
	"MCC_M4A1_556_Troy_115_FDE_Bravo",
	"MCC_M4A1_556_Troy_9_FDE_Bravo",
	"MCC_M4A1_556_Troy_16_FDE_SLK",
	"MCC_M4A1_556_Troy_145_FDE_SLK",
	"MCC_M4A1_556_Troy_115_FDE_SLK",
	"MCC_M4A1_556_Troy_9_FDE_SLK",
	"MCC_M4A1_556_Troy_16_BLK_CTR",
	"MCC_M4A1_556_Troy_145_BLK_CTR",
	"MCC_M4A1_556_Troy_115_BLK_CTR",
	"MCC_M4A1_556_Troy_9_BLK_CTR",
	"MCC_M4A1_556_Troy_16_BLK_Bravo",
	"MCC_M4A1_556_Troy_145_BLK_Bravo",
	"MCC_M4A1_556_Troy_115_BLK_Bravo",
	"MCC_M4A1_556_Troy_9_BLK_Bravo",
	"MCC_M4A1_556_Troy_16_BLK_SLK",
	"MCC_M4A1_556_Troy_145_BLK_SLK",
	"MCC_M4A1_556_Troy_115_BLK_SLK",
	"MCC_M4A1_556_Troy_9_BLK_SLK",
	"MCC_M4A1_556_URGI",
	"MCC_MK18_URGI",
	"MCC_RattlerLT_6_556_BLK_MPLFS",
	"MCC_RattlerLT_7_556_BLK_MPLFS",
	"MCC_RD704",
	"MCC_RD701",
	"MCC_RD504",
	"MCC_RD501",
	"MCC_RD604",
	"MCC_RD601",
	"MCC_REC7_DI_556_FDE_CTR",
	"MCC_REC7_DI_556_FDE_Bravo",
	"MCC_REC7_DI_556_FDE_SLK",
	"MCC_REC7_DI_556_BLK_CTR",
	"MCC_REC7_DI_556_BLK_Bravo",
	"MCC_REC7_DI_556_BLK_SLK",
	"MCC_REC7_DI_556_GRY_CTR",
	"MCC_REC7_DI_556_GRY_Bravo",
	"MCC_REC7_DI_556_GRY_SLK",
	"MCC_REC7_DI_556_OD_CTR",
	"MCC_REC7_DI_556_OD_Bravo",
	"MCC_REC7_DI_556_OD_SLK",
	"MCC_REC7_DI_556_BRZ_CTR",
	"MCC_REC7_DI_556_BRZ_Bravo",
	"MCC_REC7_DI_556_BRZ_SLK",
	"MCC_SpearLT_16_556_ANO_MPLFS",
	"MCC_SpearLT_16_556_ANO_Bravo",
	"MCC_SpearLT_16_556_ANO_SLK",
	"MCC_SpearLT_145_556_ANO_MPLFS",
	"MCC_SpearLT_145_556_ANO_Bravo",
	"MCC_SpearLT_145_556_ANO_SLK",
	"MCC_SpearLT_115_556_ANO_MPLFS",
	"MCC_SpearLT_115_556_ANO_Bravo",
	"MCC_SpearLT_115_556_ANO_SLK",
	"MCC_SpearLT_9_556_ANO_MPLFS",
	"MCC_SpearLT_9_556_ANO_Bravo",
	"MCC_SpearLT_9_556_ANO_SLK",
	"MCC_SpearLT_16_556_FDE_MPLFS",
	"MCC_SpearLT_16_556_FDE_Bravo",
	"MCC_SpearLT_16_556_FDE_SLK",
	"MCC_SpearLT_145_556_FDE_MPLFS",
	"MCC_SpearLT_145_556_FDE_Bravo",
	"MCC_SpearLT_145_556_FDE_SLK",
	"MCC_SpearLT_115_556_FDE_MPLFS",
	"MCC_SpearLT_115_556_FDE_Bravo",
	"MCC_SpearLT_115_556_FDE_SLK",
	"MCC_SpearLT_9_556_FDE_MPLFS",
	"MCC_SpearLT_9_556_FDE_Bravo",
	"MCC_SpearLT_9_556_FDE_SLK",
	"MCC_SpearLT_16_556_BLK_MPLFS",
	"MCC_SpearLT_16_556_BLK_Bravo",
	"MCC_SpearLT_16_556_BLK_SLK",
	"MCC_SpearLT_145_556_BLK_MPLFS",
	"MCC_SpearLT_145_556_BLK_Bravo",
	"MCC_SpearLT_145_556_BLK_SLK",
	"MCC_SpearLT_115_556_BLK_MPLFS",
	"MCC_SpearLT_115_556_BLK_Bravo",
	"MCC_SpearLT_115_556_BLK_SLK",
	"MCC_SpearLT_9_556_BLK_MPLFS",
	"MCC_SpearLT_9_556_BLK_Bravo",
	"MCC_SpearLT_9_556_BLK_SLK",
	"MCC_LMT_MARSL_8_556_FDE_CTR",
	"MCC_LMT_MARSL_8_556_FDE_SOPMOD",
	"MCC_LMT_MARSL_8_556_FDE_SLK",
	"MCC_LMT_MARSL_10_556_FDE_CTR",
	"MCC_LMT_MARSL_10_556_FDE_SOPMOD",
	"MCC_LMT_MARSL_10_556_FDE_SLK",
	"MCC_LMT_MARSL_14_556_FDE_CTR",
	"MCC_LMT_MARSL_14_556_FDE_SOPMOD",
	"MCC_LMT_MARSL_14_556_FDE_SLK",
	"MCC_LMT_MARSL_16_556_FDE_CTR",
	"MCC_LMT_MARSL_16_556_FDE_SOPMOD",
	"MCC_LMT_MARSL_16_556_FDE_SLK",
	"MCC_LMT_MARSL_8_556_BLK_CTR",
	"MCC_LMT_MARSL_8_556_BLK_SOPMOD",
	"MCC_LMT_MARSL_8_556_BLK_SLK",
	"MCC_LMT_MARSL_10_556_BLK_CTR",
	"MCC_LMT_MARSL_10_556_BLK_SOPMOD",
	"MCC_LMT_MARSL_10_556_BLK_SLK",
	"MCC_LMT_MARSL_14_556_BLK_CTR",
	"MCC_LMT_MARSL_14_556_BLK_SOPMOD",
	"MCC_LMT_MARSL_14_556_BLK_SLK",
	"MCC_LMT_MARSL_16_556_BLK_CTR",
	"MCC_LMT_MARSL_16_556_BLK_SOPMOD",
	"MCC_LMT_MARSL_16_556_BLK_SLK",
	"MCC_LMT_MARSL_8_556_DE_CTR",
	"MCC_LMT_MARSL_8_556_DE_SOPMOD",
	"MCC_LMT_MARSL_8_556_DE_SLK",
	"MCC_LMT_MARSL_10_556_DE_CTR",
	"MCC_LMT_MARSL_10_556_DE_SOPMOD",
	"MCC_LMT_MARSL_10_556_DE_SLK",
	"MCC_LMT_MARSL_14_556_DE_CTR",
	"MCC_LMT_MARSL_14_556_DE_SOPMOD",
	"MCC_LMT_MARSL_14_556_DE_SLK",
	"MCC_LMT_MARSL_16_556_DE_CTR",
	"MCC_LMT_MARSL_16_556_DE_SOPMOD",
	"MCC_LMT_MARSL_16_556_DE_SLK"	
];

private _itemWeaponCarbine =
[
    //============================================================
    //5.56x45mm
    //============================================================
    "arifle_Mk20C_plain_F",
    "arifle_TRG20_F",

    "CUP_arifle_G36CA3_grip",

	"CUP_arifle_HK416_CQB_Black",
	"CUP_arifle_HK416_CQB_Desert",
	"CUP_arifle_HK416_CQB_Wood",
    "rhs_weap_hk416d10",

    "Tier1_HK416D10_CTR",

    "CUP_arifle_XM8_Compact_Rail",

    "CUP_arifle_ACRC_blk_556",
    "CUP_arifle_ACRC_snw_556",
    "CUP_arifle_ACRC_tan_556",
    "CUP_arifle_ACRC_wdl_556",

    "CUP_arifle_AK102",
    "CUP_arifle_AK102_railed",

	"CUP_arifle_mk18_black",
    "rhs_weap_mk18_KAC",

    "rhs_weap_vhsk2",

    //============================================================
    //5.45x39mm
    //============================================================
    "CUP_arifle_Fort224_Grippod",

	"CUP_arifle_AKS74U",
	"CUP_arifle_AKS74U_top_rail",
    "rhs_weap_aks74un",

	"CUP_arifle_AK105",
	"CUP_arifle_AK105_top_rail",
	"CUP_arifle_AK105_railed",
    "rhs_weap_ak105",
    "rhs_weap_ak105_zenitco01",

    //============================================================
    //7.62x39mm
    //============================================================
    "CUP_arifle_OTS14_GROZA_762",
    "CUP_arifle_Sa58_Carbine_RIS_AFG",

	"CUP_arifle_AK104",
	"CUP_arifle_AK104_top_rail",
	"CUP_arifle_AK104_railed",
    "rhs_weap_ak104",
    "rhs_weap_ak104_zenitco01",
    "rhs_weap_m92"
];

private _itemWeaponAmmo =
[
    //============================================================
    //5.56x45mm
    //============================================================
    //Magazines
    "CUP_30Rnd_556x45_Emag",
    "CUP_30Rnd_556x45_PMAG_QP",
    "CUP_30Rnd_556x45_PMAG_BLACK_PULL",
    "CUP_30Rnd_556x45_XM8",
    "CUP_25Rnd_556x45_Famas",
    "CUP_30Rnd_556x45_AK",
    "CUP_20Rnd_556x45_Stanag",

    //Loose ammo
    "greenmag_ammo_556x45_basic_60Rnd",

    //============================================================
    //5.45x39mm
    //============================================================
    //Magazines
    "CUP_30Rnd_545x39_Fort224_M",
    "CUP_30Rnd_545x39_AK_M",
    "CUP_30Rnd_545x39_AK74M_M",

    //Loose ammo
    "greenmag_ammo_545x39_basic_60Rnd",

    //============================================================
    //7.62x39mm
    //============================================================
    //Magazines
    "CUP_30Rnd_762x39_AK47_bakelite_M",
    "CUP_30Rnd_762x39_AK47_M",
    "CUP_30Rnd_Sa58_M",

    "rhs_30Rnd_762x39mm_Savz58",

    //Loose ammo
    "greenmag_ammo_762x39_basic_60Rnd",

    //============================================================
    //7.62x51mm
    //============================================================
    //Magazines
    "CUP_20Rnd_762x51_FNFAL_M",
    "CUP_20Rnd_762x51_B_SCAR",
	"CUP_20Rnd_762x51_B_SCAR_wdl",
	"CUP_20Rnd_762x51_B_SCAR_bkl",
    "CUP_20Rnd_762x51_HK417",
    "CUP_20Rnd_762x51_G3",

    //Loose ammo
    "greenmag_ammo_762x51_basic_60Rnd",

    //============================================================
    //7.62x54mm
    //============================================================
    //Magazines
    //Loose ammo
    "greenmag_ammo_762x54_basic_60Rnd",

    //============================================================
    //Grenades
    //============================================================
    //HE and frags
    "HandGrenade",

    //Smokes
    "SmokeShell",
    "SmokeShellGreen",
    "SmokeShellRed",
    "SmokeShellPurple",
    "SmokeShellBlue",

    //Make eyeballs hurt
    "tsp_flashbang_m84",
	"tsp_flashbang_cts2",
	"tsp_flashbang_fakels",
    "ACE_Chemlight_HiGreen",
	"ACE_Chemlight_IR"
];

private ['_itemWeaponTracerAmmo','_itemWeaponHighCapAmmo','_itemWeaponARAmmo'];
//Red Tracer
if (_tracer isEqualTo 'red') then {
	_itemWeaponTracerAmmo =
	[
		"CUP_64Rnd_Red_Tracer_9x19_Bizon_M",

		//============================================================
		//5.56x45mm
		//============================================================
		"CUP_30Rnd_556x45_Emag_Tracer_Red",
		"CUP_30Rnd_556x45_PMAG_BLACK_PULL_Tracer_Red",
		"CUP_30Rnd_556x45_PMAG_OD_PULL_Tracer_Red",
		"CUP_30Rnd_556x45_PMAG_COYOTE_PULL_Tracer_Red",
		"CUP_30Rnd_556x45_PMAG_QP_Tracer_Red",
		"CUP_30Rnd_TE1_Red_Tracer_556x45_XM8",
		"CUP_25Rnd_556x45_Famas_Tracer_Red",
		"CUP_30Rnd_TE1_Red_Tracer_556x45_AK",
		"CUP_30Rnd_556x45_Tracer_Red_AK19_M",
		"CUP_20Rnd_556x45_Stanag_Tracer_Red",

		//============================================================
		//5.45x39mm
		//============================================================
		"CUP_30Rnd_TE1_Red_Tracer_545x39_Fort224_M",
		"CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M",

		//============================================================
		//7.62x39mm
		//============================================================
		"CUP_30Rnd_TE1_Red_Tracer_762x39_AK47_bakelite_M",
		"CUP_30Rnd_Sa58_M_TracerR",
		"CUP_30Rnd_TE1_Red_Tracer_762x39_AK47_M",

		"rhs_30Rnd_762x39mm_Savz58_tracer",

		//============================================================
		//7.62x51mm
		//============================================================
		"CUP_20Rnd_TE1_Red_Tracer_762x51_FNFAL_M",
		"CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR",
		"CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR_wdl",
		"CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR_bkl",
		"CUP_20Rnd_TE1_Red_Tracer_762x51_HK417",
		"CUP_20Rnd_TE1_Red_Tracer_762x51_G3"
	
		//============================================================
		//7.62x54mm
		//============================================================

		//============================================================
		//Misc Calibers (SMGs, Shotguns, Etc.)
		//============================================================
	];

	_itemWeaponHighCapAmmo =
	[
		//============================================================
		//5.56x45mm
		//============================================================
		"CUP_60Rnd_556x45_SureFire",
		"CUP_60Rnd_556x45_SureFire_Tracer_Red",
		"CUP_50Rnd_556x45_Red_Tracer_Galil_Mag",

		//============================================================
		//5.45x39mm
		//============================================================
		"CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M",
		"CUP_60Rnd_545x39_AK74M_M",
		"CUP_60Rnd_TE1_Red_Tracer_545x39_AK74M_M",

		//============================================================
		//7.62x39mm
		//============================================================
		"CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M",
		"CUP_45Rnd_Sa58_M",
		"CUP_45Rnd_Sa58_M_TracerR",
		"CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M",

		//============================================================
		//7.62x51mm
		//============================================================
		"CUP_30Rnd_762x51_FNFAL_M",
		"CUP_30Rnd_TE1_Red_Tracer_762x51_FNFAL_M"

		//============================================================
		//7.62x54mm
		//============================================================
	];

	_itemWeaponARAmmo =
	[
		//============================================================
		//5.56x45mm
		//============================================================
		//Boxes
		"CUP_200Rnd_TE4_Red_Tracer_556x45_M249",
		"CUP_100Rnd_TE4_Red_Tracer_556x45_M249",
		//Loose belts
		GREENMAG_BELT(556x45),

		//============================================================
		//7.62x51mm
		//============================================================
		//Boxes
		"CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",
		"CUP_120Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",
		//Loose belts
		GREENMAG_BELT(762x51),

		//============================================================
		//7.62x54mmR
		//============================================================
		//Boxes
		"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Red_M",

		//Loose belts
		GREENMAG_BELT(762x54),

		//Bling
		"CUP_H_RUS_Altyn_Goggles",
		"CUP_H_RUS_Altyn_Shield_Up",
		"CUP_H_RUS_Altyn_Shield_Down",
		"CUP_H_RUS_Altyn_Goggles_khaki",
		"CUP_H_RUS_Altyn_Shield_Up_khaki",
		"CUP_H_RUS_Altyn_Shield_Down_khaki",
		"CUP_H_RUS_Altyn_Goggles_black",
		"CUP_H_RUS_Altyn_Shield_Down_black"
	];
} else {

// yellow trace
	_itemWeaponTracerAmmo =
	[
		"CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M",

		//============================================================
		//5.56x45mm
		//============================================================
		"CUP_30Rnd_556x45_Emag_Tracer_Yellow",
		"CUP_30Rnd_556x45_PMAG_BLACK_PULL_Tracer_Yellow",
		"CUP_30Rnd_556x45_PMAG_COYOTE_PULL_Tracer_Yellow",
		"CUP_30Rnd_556x45_PMAG_OD_PULL_Tracer_Yellow",
		"CUP_30Rnd_556x45_PMAG_QP_Tracer_Yellow",
		"CUP_30Rnd_TE1_Yellow_Tracer_556x45_XM8",
		"CUP_25Rnd_556x45_Famas_Tracer_Yellow",
		"CUP_30Rnd_TE1_Yellow_Tracer_556x45_AK",
		"CUP_30Rnd_556x45_TE1_Tracer_Green_AK19_Tan_M",
		"CUP_20Rnd_556x45_Stanag_Tracer_Yellow",

		//============================================================
		//5.45x39mm
		//============================================================
		"CUP_30Rnd_TE1_Yellow_Tracer_545x39_Fort224_M",
		"CUP_30Rnd_TE1_Yellow_Tracer_545x39_AK74M_M",

		//============================================================
		//7.62x39mm
		//============================================================
		"CUP_30Rnd_TE1_Yellow_Tracer_762x39_AK47_bakelite_M",
		"CUP_30Rnd_Sa58_M_TracerY",
		"CUP_30Rnd_TE1_Yellow_Tracer_762x39_AK47_M",

		"rhs_30Rnd_762x39mm_Savz58_tracer",

		//============================================================
		//7.62x51mm
		//============================================================
		"CUP_20Rnd_TE1_Yellow_Tracer_762x51_FNFAL_M",
		"CUP_20Rnd_TE1_Yellow_Tracer_762x51_SCAR",
		"CUP_20Rnd_TE1_Yellow_Tracer_762x51_HK417",
		"CUP_20Rnd_TE1_Yellow_Tracer_762x51_G3"

		//============================================================
		//7.62x54mm
		//============================================================

		//============================================================
		//Misc Calibers (SMGs, Shotguns, Etc.)
		//============================================================
	];

	_itemWeaponHighCapAmmo =
	[
		//============================================================
		//5.56x45mm
		//============================================================
		"CUP_60Rnd_556x45_SureFire",
		"CUP_60Rnd_556x45_SureFire_Tracer_Yellow",
		"CUP_50Rnd_556x45_Green_Tracer_Galil_Mag",

		//============================================================
		//5.45x39mm
		//============================================================
		"CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M",
		"CUP_60Rnd_545x39_AK74M_M",
		"CUP_60Rnd_TE1_Yellow_Tracer_545x39_AK74M_M",

		//============================================================
		//7.62x39mm
		//============================================================
		"CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M",
		"CUP_45Rnd_Sa58_M",
		"CUP_45Rnd_Sa58_M_TracerY",
		"CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M",

		//============================================================
		//7.62x51mm
		//============================================================
		"CUP_30Rnd_762x51_FNFAL_M",
		"CUP_30Rnd_TE1_Yellow_Tracer_762x51_FNFAL_M"

		//============================================================
		//7.62x54mm
		//============================================================
	];

	_itemWeaponARAmmo =
	[
		//============================================================
		//5.56x45mm
		//============================================================
		//Boxes
		"CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249",
		"CUP_100Rnd_TE4_Yellow_Tracer_556x45_M249",
		//Loose belts
		GREENMAG_BELT(556x45),

		//============================================================
		//7.62x51mm
		//============================================================
		//Boxes
		"CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
		"CUP_120Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M",
		//Loose belts
		GREENMAG_BELT(762x51),

		//============================================================
		//7.62x54mmR
		//============================================================
		//Boxes
		"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M",

		//Loose belts
		GREENMAG_BELT(762x54),

		//Bling
		"CUP_H_RUS_Altyn_Goggles",
		"CUP_H_RUS_Altyn_Shield_Up",
		"CUP_H_RUS_Altyn_Shield_Down",
		"CUP_H_RUS_Altyn_Goggles_khaki",
		"CUP_H_RUS_Altyn_Shield_Up_khaki",
		"CUP_H_RUS_Altyn_Shield_Down_khaki",
		"CUP_H_RUS_Altyn_Goggles_black",
		"CUP_H_RUS_Altyn_Shield_Down_black"
	];
};
//*/

private _itemWeaponCQB =
[
    //============================================================
    //Weapons
    //============================================================
    //SMGs
    "CUP_arifle_SR3M_Vikhr_VFG_top_rail",
    "CUP_smg_Mac10_rail",
    "CUP_smg_MP5A5",
    "CUP_smg_MP5A5_Rail",
    "CUP_smg_MP5A5_Rail_VFG",
    "CUP_smg_MP5A5_Rail_AFG",
    "CUP_smg_SA61",
    "CUP_smg_vityaz_vfg_top_rail",
    "CUP_smg_bizon",
    "CUP_smg_MP7",

    "rhs_weap_pp2000",
    "rhsusf_weap_MP7A2",

    //Shotguns
    "CUP_sgun_M1014_vfg",
    "CUP_sgun_Saiga12K",
    "CUP_sgun_SPAS12",

    "rhs_weap_M590_8RD",
    "rhs_weap_M590_5RD",

    //============================================================
    //Accessories
    //============================================================

    //============================================================
    //Magazines
    //============================================================
    //SMGs
    "CUP_40Rnd_46x30_MP7",
    "CUP_20Rnd_B_765x17_Ball_M",
    "CUP_30Rnd_9x39_SP5_VIKHR_M",
    "CUP_20Rnd_9x39_SP5_VSS_M",
    "CUP_30Rnd_45ACP_MAC10_M",
    "CUP_30Rnd_9x19_MP5",
    "CUP_30Rnd_9x19_Vityaz",
    "CUP_64Rnd_9x19_Bizon_M",

    "rhs_mag_9x19mm_7n21_20",
    "rhs_mag_9x19mm_7n21_44",

    //Shotguns
    "CUP_5Rnd_B_Saiga12_Buck_00",
    "CUP_5Rnd_B_Saiga12_Slug",
    "CUP_12Rnd_B_Saiga12_Buck_00",
    "CUP_12Rnd_B_Saiga12_Slug",
    "CUP_8Rnd_12Gauge_Pellets_No00_Buck",
    "CUP_8Rnd_12Gauge_Slug",

    "rhsusf_8Rnd_00Buck",
    "rhsusf_5Rnd_00Buck",
    "rhsusf_5Rnd_Slug",

    //============================================================
    //Loose ammo
    //============================================================
    "greenmag_ammo_46x30_basic_60Rnd",
    "greenmag_ammo_765x17_basic_60Rnd",
    "greenmag_ammo_9x39_ball_60Rnd",
    "greenmag_ammo_45ACP_basic_60Rnd",
    "greenmag_ammo_9x18_basic_60Rnd",
    "greenmag_ammo_9x19_basic_60Rnd",
	"greenmag_ammo_12G_basic_12Rnd",
	"greenmag_ammo_12G_basic_24Rnd"
];

private _itemWeaponAR =
[
    //============================================================
    //5.56x45mm
    //============================================================
    "CUP_lmg_L110A1",
    "CUP_lmg_minimi_railed",
    "CUP_arifle_L86A2",
    "CUP_arifle_Galil_556_black",
    "CUP_lmg_m249_SQuantoon",
    "CUP_lmg_m249_pip1",
    "CUP_lmg_m249_pip2",
    "CUP_lmg_m249_pip3",
    "CUP_lmg_m249_pip4",
    "CUP_lmg_M249_E1",
    "CUP_lmg_M249_E2",
    "CUP_lmg_m249_para",

    "rhs_weap_m249_pip_ris",
    "rhs_weap_m249_pip_L_para",
    "rhs_weap_m249_light_S",
    "rhs_weap_m249_pip_S_para",
    "rhs_weap_m27iar",
    "rhs_weap_m27iar_grip",

    "Tier1_MK46_Mod0",
    "Tier1_MK46_Mod1_Savit",

    //============================================================
    //5.45x39mm
    //============================================================
    "CUP_arifle_RPK74_45",

    "rhs_weap_rpk74m",

    //============================================================
    //7.62x39mm
    //============================================================
    "CUP_arifle_RPK74",
    "CUP_arifle_RPK74_top_rail",
    "CUP_arifle_Sa58_Klec_frontris",
    "CUP_arifle_Sa58_Klec_ris",

    //============================================================
    //7.62x51mm
    //============================================================
    //"CUP_lmg_M60E4",
    //"CUP_lmg_MG3_rail",

    //============================================================
    //7.62x54mm
    //============================================================
    //"CUP_lmg_Pecheneg_B50_vfg",
    //"CUP_lmg_Pecheneg_top_rail_B50_vfg",

    //"rhs_weap_pkm",
    //"rhs_weap_pkp",

    //============================================================
    //LMG Accessories
    //============================================================

	"CUP_optic_ElcanM145",
    "rhsusf_acc_elcan",
    "rhsusf_acc_elcan_ard"
];

private _itemWeaponSFAR =
[
    //============================================================
    //LMGs
    //============================================================

    //============================================================
    //LMG Accessories
    //============================================================
    "muzzle_snds_h_mg_blk_f",
    "muzzle_snds_93mmg",
    "muzzle_snds_93mmg_tan",
    "muzzle_snds_338_black",
    "muzzle_snds_338_sand",
    "CUP_100Rnd_556x45_BetaCMag_ar15",
    "CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_ar15",
    "CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag_ar15"
];

private _itemWeaponSharpshooter =
[
    //============================================================
    //Weapons
    //============================================================
    //7.62x51mm
	"CUP_srifle_Mk18_blk",

    "CUP_arifle_HK417_20",

    "rhs_weap_m14ebrri",
    "rhs_weap_sr25",
    "rhs_weap_sr25_ec",

    "Tier1_SR25_EC",

    //7.62x54mmR
    "CUP_srifle_SVD",
    "CUP_srifle_SVD_top_rail",

    "rhs_weap_svds",
    "rhs_weap_svdp",

    "ace_tripod",
    "ace_csw_m220CarryTripod", // can deploy bipod on these
    "ace_csw_spg9CarryTripod",

	"CUP_bipod_G3SG1", // G3 bipod

    //============================================================
    //Magazines
    //============================================================
    //7.62x51mm
    "ace_20rnd_762x51_m118lr_mag",
    "ace_20rnd_762x51_mag_tracer",

    "rhsusf_20Rnd_762x51_SR25_m993_Mag",

    //7.62x54mmR
    "ace_10rnd_762x54_tracer_mag",
	"CUP_10Rnd_762x54_SVD_M",

    "rhs_10Rnd_762x54mmR_7N14"
];

private _itemWeaponSniper =
[
    "srifle_GM6_camo_F",
    "CUP_srifle_AS50",
    "CUP_srifle_CZ750",
    "CUP_srifle_AWM_wdl",
    "CUP_srifle_ksvk",
    "CUP_srifle_M107_Pristine",
    "CUP_srifle_M24_blk",
	"CUP_srifle_M2010_blk",

    "rhs_weap_m24sws",
    "rhs_weap_m40a5",
    "rhs_weap_t5000",
    "RHS_weap_m107"
];

private _itemSniper =
[
    "U_I_GhillieSuit",
    "U_O_GhillieSuit",
    "U_B_GhillieSuit",
    "CUP_U_O_RUS_Ghillie",
    "CUP_U_B_BAF_DDPM_GHILLIE",

	//sling for defense
	"tsp_sling",

    // "optic_AMS", // marksman dlc
    "optic_LRPS",
    "CUP_optic_LeupoldMk4_25x50_LRT_pip",
    "CUP_optic_SB_3_12x50_PMII",

    "Tier1_Shortdot_Geissele_Docter_Black",
    "tier1_shortdot_geissele_black_vanilla",
    "Tier1_Razor_Gen3_110_Geissele_Docter",

	//MCC 10x
	"MCC_Mark5_10_BLK",
	"MCC_Vortex_Elanor_Acro_BLK",
	"MCC_ZCO_10_BLK_DMR",

    "rhsusf_acc_premier_mrds",
    "rhsusf_acc_leupoldmk4_2",
    "rhsusf_acc_nxs_3515x50f1_md_sun",

    "ace_5rnd_127x99_api_mag",
    "ace_10rnd_127x99_api_mag",

	"5Rnd_127x108_Mag",
	"5Rnd_127x108_APDS_Mag",

    "CUP_10Rnd_127x99_M107",
    "CUP_5Rnd_127x99_as50_M",
    "CUP_10Rnd_762x51_CZ750",
    "CUP_5Rnd_86x70_L115A1",
    "CUP_5Rnd_127x108_KSVK_M",
    "CUP_5Rnd_762x51_M24",
	"CUP_5Rnd_762x67_M2010_M",
	"CUP_5Rnd_TE1_Red_Tracer_762x67_M2010_M",

    "rhsusf_5Rnd_762x51_m118_special_Mag",
    "rhsusf_5Rnd_762x51_m993_Mag",
    "rhsusf_10Rnd_762x51_m118_special_Mag",
    "rhsusf_10Rnd_762x51_m993_Mag",
    "rhs_5Rnd_338lapua_t5000",

	"CUP_smg_MP7",
    "rhsusf_weap_MP7A2_folded",
    "rhsusf_acc_rotex_mp7",

    "CUP_40Rnd_46x30_MP7",
    "ACE_ATragMX",

	//============================================================
    //Accessories
    //============================================================
    //~1-4x 'combat sights'
    "optic_DMS",
    "optic_DMS_weathered_F",

    "cup_optic_acog",
    "cup_optic_acog_ta01nsn_rmr_black",
    "rhsusf_acc_acog_rmr",

    "CUP_optic_Elcan_SpecterDR_RMR_black",
    "cup_optic_elcan_specterdr_kf_black",
    "cup_optic_sb_11_4x20_pm",

    "rhsusf_acc_su230",
    "rhsusf_acc_su230_mrds",
    "rhsusf_acc_su230a", //zeroed for 7.62
    "rhsusf_acc_su230a_mrds", //same but with a red dot
	"rhsusf_acc_acog_mdo",

    "Tier1_razor_gen2_16",
    "tier1_razor_gen2_16_vanilla",

    //dovetail mounted
    "CUP_optic_PSO_1",
    "cup_optic_pso_1_1_open",

    "rhs_acc_pso1m21",

    // muzzle devices
    "rhsusf_acc_sr25s",
    "CUP_muzzle_snds_KZRZP_SVD",

    "CUP_muzzle_snds_AWM",
    "CUP_optic_PSO_3_open",
    "CUP_muzzle_mfsup_Suppressor_M107_Black",
    "CUP_Mxx_camo_half",
    "muzzle_snds_B",

    "rhsusf_acc_m24_silencer_black"
];
private _itemSniperAmmo = [
    "greenmag_ammo_127x99_basic_30Rnd",
    "greenmag_ammo_127x99_basic_60Rnd",
    "greenmag_ammo_127x108_basic_30Rnd",
    "greenmag_ammo_127x108_basic_60Rnd",
    "greenmag_ammo_338_basic_30Rnd",
    "greenmag_ammo_338_basic_60Rnd",
    "greenmag_ammo_46x30_basic_60Rnd",
    "greenmag_ammo_93x64_basic_60Rnd"
];

private _itemWeaponGL =
[
    //============================================================
    //Primary Weapons
    //============================================================
    //Grenade Launchers and Sling
	"CUP_glaunch_Mk13",
	"CUP_glaunch_M79",
	"tsp_sling",

	//5.56x45mm
    "arifle_Mk20_GL_plain_F",
    "arifle_TRG21_GL_F",

    "CUP_arifle_ACR_EGLM_blk_556",
    "CUP_arifle_ACR_EGLM_snw_556",
    "CUP_arifle_ACR_EGLM_tan_556",
    "CUP_arifle_ACR_EGLM_wdl_556",

    "CUP_arifle_M16A4_GL",

    "CUP_arifle_mk18_m203_black",

    "CUP_arifle_G36A3_AG36",
    "CUP_arifle_G36K_RIS_AG36",

    "CUP_arifle_XM8_Carbine_GL",

    "CUP_arifle_HK416_AGL_Black",
	"CUP_arifle_HK416_AGL_Desert",
	"CUP_arifle_HK416_AGL_Wood",

	"CUP_arifle_HK416_CQB_AG36",
	"CUP_arifle_HK416_CQB_AG36_Desert",
	"CUP_arifle_HK416_CQB_AG36_Wood",

    "CUP_arifle_AK101_GL",
    "CUP_arifle_AK101_GL_railed",
    "CUP_arifle_AK19_GP34_bicolor",

    "CUP_CZ_BREN2_556_11_GL",
    "CUP_CZ_BREN2_556_11_GL_Grn",
    "CUP_CZ_BREN2_556_11_GL_Tan",

    "rhs_weap_hk416d145_m320",

	"CUP_arifle_M16A4_GL",
    "rhs_weap_m16a4_carryhandle_M203",

    "mjb_arifle_C7Bravo",

	"CUP_arifle_mk18_m203_black",
    "rhs_weap_mk18_m320",

    "rhs_weap_vhsd2_bg",
    "rhs_weap_vhsd2_bg_ct15x",

    //5.45x39mm
    "CUP_arifle_AK74M_GL",
    "CUP_arifle_AK74M_GL_railed",
    "CUP_arifle_AK12_GP34_bicolor",

    "rhs_weap_ak74m_gp25",

    //7.62x39mm
    "CUP_arifle_AKM_GL",
    "CUP_arifle_AKM_GL_top_rail",
    "CUP_arifle_OTS14_GROZA_762_GL",
    "CUP_arifle_Sa58RIS2_gl",

	"CUP_arifle_AK103_GL",
	"CUP_arifle_AK103_GL_top_rail",
	"CUCUP_arifle_AK103_GL_railed",

    "rhs_weap_ak103_gp25",

    //7.62x51mm
    "CUP_arifle_DSA_SA58_OSW_M203",
    "CUP_arifle_Mk17_CQC_EGLM",
    "CUP_arifle_Mk17_CQC_EGLM_black",
    "CUP_arifle_Mk17_CQC_EGLM_woodland",

    "CUP_arifle_ACR_EGLM_blk_68",
    "CUP_arifle_ACR_EGLM_snw_68",
    "CUP_arifle_ACR_EGLM_tan_68",
    "CUP_arifle_ACR_EGLM_wdl_68",

    "CUP_arifle_AK15_GP34_bicolor",

    /*/ Fancy mags
    "CUP_30Rnd_TE1_Green_Tracer_545x39_AK12_Tan_M",
    "CUP_30Rnd_TE1_Green_Tracer_762x39_AK15_Tan_M",
    "CUP_30Rnd_556x45_TE1_Tracer_Green_AK19_Tan_M",*///only green
	"CUP_30Rnd_556x45_AK19_Tan_M",
    "CUP_30Rnd_680x43_Stanag_Tracer_Red",
    "CUP_30Rnd_680x43_Stanag_Tracer_Yellow",

    "greenmag_ammo_680x43_tracer_60Rnd",

    //============================================================
    //Grenade Rounds
    //============================================================
    //NATO
    "1Rnd_HE_Grenade_shell",
    "ACE_40mm_Flare_white",
    "ACE_40mm_Flare_ir",
    "1Rnd_Smoke_Grenade_shell",
    "1Rnd_SmokeRed_Grenade_shell",
    "1Rnd_SmokeBlue_Grenade_shell",
    "1Rnd_SmokeGreen_Grenade_shell",

	"CUP_1Rnd_HEDP_M203",
	"rhs_mag_M433_HEDP",

	"mjb_blug",

    //Rusfor
    "CUP_1Rnd_HE_GP25_M",
    "CUP_IlumFlareWhite_GP25_M",
    "CUP_1Rnd_SMOKE_GP25_M",
    "CUP_1Rnd_SmokeRed_GP25_M",
    "CUP_1Rnd_SmokeGreen_GP25_M",
    "rhs_VOG25",
    "rhs_VG40TB",

	"mjb_VOGMDP",
	"mjb_slog"
];

private _itemWeaponSFSL =
[
    "CUP_lmg_m249_para_gl",
    "CUP_arifle_AK107_GL_railed",
    "CUP_arifle_AK108_GL_railed",
    "CUP_arifle_AK109_GL_railed",

    "rhs_weap_ak74mr_gp25",
    "rhs_weap_M320",
    "rhs_VG40MD"
];

private _itemMedic =
[
    //BIS
    "B_Carryall_oucamo",

    "rhs_tortila_black"
];

private _itemWeaponLAT =
[
    "CUP_launch_M136", // Better than RHS HEAT
    "CUP_launch_M72A6",
    "CUP_launch_RPG26",

    //"CUP_launch_MAAWS",
    //"cup_optic_maaws_scope",

    //"rhs_weap_rpg75", // Not much better than m72s in the configs
    //"rhs_weap_M136", // HEAT
    //"rhs_weap_M136_hedp", // Not great for AT
    //"rhs_weap_M136_hp", // High Penetration

    "rhs_acc_at4_handler",

    //Launchers in Backpack - should work with the normal class now?
	"CUP_RPG26_M",
	"CUP_M72A6_M",
	"CUP_M136_M"/*,
    "CUP_launch_M136_Loaded",
    "CUP_launch_M72A6_Loaded"//,
    //"CUP_launch_RPG26_Loaded"/*/
];

//if !(isClass (configFile >> "CfgWeapons" >> "rhs_weap_rpg7")) then {};
private _itemWeaponRLAT =
[
	"CUP_launch_RPG7V"//,

    //"rhs_weap_rpg7" // reloadable
];

private _itemAmmoLAT =
[
    //RPG Rockets (Uncomment desired rockets)
	"CUP_OG7_M",
	//"CUP_PG7V_M",
	"CUP_PG7VL_M",
	"CUP_PG7VM_M"//,
	//"CUP_PG7VR_M",
	//"CUP_TBG7V_M",

    // "rhs_rpg7_OG7V_mag",
    // "rhs_rpg7_PG7V_mag",
    // "rhs_rpg7_PG7VL_mag", // High pen
    // "rhs_rpg7_PG7VM_mag", //
    // "rhs_rpg7_PG7VR_mag", // Very High Pen Tandem
    // "rhs_rpg7_PG7VS_mag", // Between VM and VL, ~AT4 HEAT
    // "rhs_rpg7_TBG7V_mag",
    // "rhs_rpg7_type69_airburst_mag"

    //"MRAWS_HE_F",
    //"MRAWS_HEAT55_F"
];
//if !(isClass (configFile >> "CfgWeapons" >> "rhs_weap_rpg7")) then {_itemAmmoLAT append _cupRPGs};

private _itemWeaponMAT =
[
    "launch_MRAWS_sand_rail_F",
	"launch_MRAWS_green_rail_F",
	"launch_MRAWS_olive_rail_F"
];

private _itemWeaponSFMAT =
[
    "launch_MRAWS_green_F",
	"launch_MRAWS_olive_F",
	"launch_MRAWS_sand_F"
];

private _itemAmmoMAT =
[
	"MRAWS_HEAT_F",
    "MRAWS_HEAT55_F",
    "MRAWS_HE_F"
];

private _itemWeaponHAT =
[
    "launch_I_Titan_short_F"//,
	//"CUP_launch_Metis"
];

private _itemAmmoHAT =
[
    "Titan_AT",
	//"Vorona_HE",
	//"Vorona_HEAT",
    "Rangefinder",
    "ACE_Vector"
];

private _itemWeaponSPAA =
[
    "launch_I_Titan_F"
];

private _itemAmmoSPAA =
[
    "Titan_AA",
    "Rangefinder",
    "ACE_Vector"
];

private _itemWeaponMortar =
[
    "NDS_W_M224_mortarCarry"
];

private _itemMortarAmmo =
[
    "NDS_M_6Rnd_60mm_HE",
    "NDS_M_6Rnd_60mm_HE_0",
    "NDS_M_6Rnd_60mm_ILLUM",
    "NDS_M_6Rnd_60mm_SMOKE",
    "Rangefinder",
    "ACE_Vector"
];

private _itemWeaponMMG =
[
    "CUP_lmg_Mk48",
	"CUP_lmg_Mk48_des",
	"CUP_lmg_Mk48_od",
	"CUP_lmg_Mk48_tan",
	"CUP_lmg_Mk48_wdl",
    "CUP_lmg_M60",
	"CUP_lmg_M240_B",
	"CUP_lmg_M240",

    "rhs_weap_m240G",
    "rhs_weap_m240B",

    "Tier1_MK48_Mod1",

    "cup_optic_hensoldtzo",
    "cup_optic_acog2",

    "rhsusf_acc_su230",
    "rhsusf_acc_su230_mrds",
    "rhsusf_acc_su230a",
    "rhsusf_acc_su230a_mrds",

    "Tier1_Mk48Mod1_LA5_M600V_Black_FL",

    "dzn_mg_tripod_universal",
    "dzn_mg_tripod_m122a1_m60mount",
    "dzn_mg_tripod_m122a1_m240mount",
    "dzn_mg_tripod_m122a1_m249mount_rhs",
    "dzn_mg_tripod_m122a1_m240mount_rhs"
];

private _itemWeaponSFMMG =
[
    "CUP_lmg_Mk48",
    "CUP_lmg_M60",
	"CUP_lmg_M240_B",
	"CUP_lmg_M240",

    "rhs_weap_m240G",
    "rhs_weap_m240B",

    "Tier1_MK48_Mod1",

    "cup_optic_hensoldtzo",
    "cup_optic_acog2",

    "rhsusf_acc_su230",
    "rhsusf_acc_su230_mrds",
    "rhsusf_acc_su230a",
    "rhsusf_acc_su230a_mrds",

    "Tier1_Mk48Mod1_LA5_M600V_Black_FL",

    "dzn_mg_tripod_universal",
    "dzn_mg_tripod_m122a1_m60mount",
    "dzn_mg_tripod_m122a1_m240mount",
    "dzn_mg_tripod_m122a1_m249mount_rhs",
    "dzn_mg_tripod_m122a1_m240mount_rhs"
];

private _itemWeaponMMGAmmo =
[
	"ace_150rnd_762x54_box_red",
	"CUP_200Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",
    "150Rnd_762x51_Box_Tracer",
    "130Rnd_338_Mag",
    "mjb_130Rnd_338_Mag_trc_red",
    "mjb_130Rnd_338_Mag_trc_ylw",
    "150Rnd_93x64_Mag",
    "mjb_150Rnd_93x64_Mag_trc_red",
    "mjb_150Rnd_93x64_Mag_trc_ylw",
    GREENMAG_BELT(338),
    GREENMAG_BELT(93x64),
    "Rangefinder",
    "ACE_Vector",
    "ace_tripod",
    "ace_csw_m220CarryTripod", // can deploy bipod on these
    "ace_csw_spg9CarryTripod"
];

private _itemSF =
[
    //BIS and Mods
    "O_NVGoggles_grn_F",
    "DemoCharge_Remote_Mag",
    "tsp_flashbang_cts",
    "ACE_CableTie",
    "ACE_IR_Strobe_Item",
    "ACE_Clacker",
    "ACE_DeadManSwitch",
    "ACE_wirecutter",

    //Vests + Backpack
    "CUP_U_O_RUS_Gorka_Green_gloves_kneepads",
    "CUP_V_B_Ciras_Black",
    "CUP_V_B_Ciras_Black2",
    "CUP_V_B_Ciras_Khaki",
    "CUP_V_B_Ciras_Khaki2",
    "CUP_V_B_Ciras_Olive",
    "CUP_V_B_Ciras_Olive2",

    "mjb_carryallplus_cbr",
    "mjb_carryallplus_taiga_F",
    "mjb_carryallplus_eaf_F",
    "mjb_carryallplus_oli",
    "mjb_carryallplus_black",
    "mjb_carryallplus_grey",
    "mjb_carryallplus_khaki",
    "mjb_carryallplus_olive",

    "Mechanism",
    "G2_Gunslinger",
    "Paratus",
    "rhsusf_plateframe_rifleman",
    "rhsusf_plateframe_machinegunner",
    "rhsusf_plateframe_medic",
    "rhsusf_plateframe_teamleader",
    "rhsusf_mbav_mg",
	"CUP_V_B_MTV_MG",
	"CUP_V_B_Ciras_Khaki3",
	"CUP_V_B_Ciras_Khaki2",
	"CUP_V_B_Ciras_Khaki",

    //Weapons
    "CUP_arifle_AK107_railed",
    "CUP_arifle_AK108_railed",
    "CUP_arifle_AK109_railed",
    "CUP_arifle_AK12_AFG_bicolor",
    "CUP_arifle_AK15_VG_bicolor",
    "CUP_arifle_AK19_bicolor",
    "CUP_smg_MP5SD6",
    "CUP_sgun_AA12",

    "CUP_20Rnd_B_AA12_Buck_00",
    "CUP_20Rnd_B_AA12_Slug",
    "CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",

    "mjb_13Rnd_65x25_Browning_HP",
    "mjb_16Rnd_65x25_cz75",
    "mjb_17Rnd_65x25_M17",
    "mjb_15Rnd_65x25_M9",
    "mjb_17Rnd_65x25_glock17",
    "mjb_30Rnd_65x25_MP5",
    "mjb_30Rnd_65x25_Vityaz",

    "rhs_weap_ak74mr",
    "rhs_weap_asval_grip",
    "rhs_20rnd_9x39mm_SP6",

    "rhs_weap_6p53",
    "rhs_18rnd_9x21mm_7BT3",
    "rhs_18rnd_9x21mm_7N29",

    "Tier1_SIG_MCX_115_Virtus_300BLK",
    "Tier1_30Rnd_762x35_300BLK_RNBT_EMag",
    "Tier1_30Rnd_762x35_300BLK_SMK_EMag",
    "Tier1_30Rnd_762x35_300BLK_EMag",

    "Tier1_P320_TB",
    "tier1_agency_compensator",
    "tier1_sig_romeo1",
    "muzzle_snds_l",

    // manpad
    "CUP_launch_FIM92Stinger",

    //Attachments
    "cup_acc_flashlight_mp5sd",
    "Tier1_SOCOM762MG_Black",
    "Tier1_Agency_Compensator",

    // SF Drip
    "G_Bandanna_aviator",
    "G_Bandanna_blk",
    "rhsusf_shemagh_gogg_tan",
    "rhsusf_shemagh2_gogg_tan",
    "rhsusf_oakley_goggles_blk",
    "rhsusf_shemagh_tan",
    "rhsusf_shemagh2_tan"
];

private _itemBreacher =
[
    // Shock Tube detonator for breaching charges
	"tsp_breach_shock", // shock tube

	// lock poppers
	"tsp_breach_popper_auto_mag", // lock popper autofuse

	// Medium Sized Breaching Charges
	"tsp_breach_linear_mag", // linear charge
	"tsp_breach_linear_auto_mag", // linear charge autofuse
	"tsp_breach_block_mag", // breach block
	"tsp_breach_block_auto_mag", // breach block autofuse
	
	// Large Breaching Items
	"tsp_breach_package_mag", // Package Charge
	"tsp_breach_silhouette_mag" // Silhouette Charge
];

private _itemEngineer =
[
    //Tools
    "ACRE_148",
    "DemoCharge_Remote_Mag",
    "ACE_Clacker",
    "Toolkit",
    "ACE_M14",
    "ACE_wirecutter",
    "ACE_EntrenchingTool",
    "ACE_Fortify",
    "ACE_DefusalKit",
    "ATMine_Range_Mag",
    "ACE_FlareTripMine_Mag",
    "APERSTripMine_Wire_Mag",
    "SLAMDirectionalMine_Wire_Mag",
    "ClaymoreDirectionalMine_Remote_Mag",
    "TrainingMine_Mag",
    "ACE_SpraypaintBlack",
    "ACE_Rope36",
    "ACE_Rope15",
    "MineDetector",
    "ACE_Chemlight_HiBlue",
    "ACE_Chemlight_HiYellow",
    "ACE_Chemlight_UltraHiOrange",
    "ACE_TacticalLadder_Pack",
    "Rangefinder",
    "ACE_Vector",

    "rhs_charge_sb3kg_mag",
    "rhs_charge_tnt_x2_mag",
    "rhs_tr8_periscope",
    "rhsusf_bino_leopold_mk4",
    "rhs_mag_an_m14_th3",

    //Equipment
    "CUP_V_MBSS_PACA_Tan",
    "CUP_V_MBSS_PACA_CB",
    "CUP_V_MBSS_PACA_RGR",
    "CUP_V_MBSS_PACA_Black",
    "CUP_V_MBSS_PACA_Green",
    "B_UAV_01_backpack_F",
    "B_UGV_02_Demining_backpack_F"
];

private _sideTerminal = ["O_UavTerminal","B_UavTerminal","I_UavTerminal","C_UavTerminal","","","","","",""] select _sideID;
private _itemUAVTermial = [
    _sideTerminal,
    "ACE_UAVBattery"
];
_itemEngineer append _itemUAVTermial;

private _itemCrewHelm = [
	"CUP_H_SPH4",
	"CUP_H_SPH4_khaki",
	"CUP_H_SPH4_grey",
	"CUP_H_SPH4_green"
];

private _itemTankCrew =
[
    //"diw_armor_plates_main_plate",
    "greenmag_item_speedloader",
    "CUP_V_PMC_CIRAS_Black_Veh",
    "CUP_V_PMC_CIRAS_Khaki_Veh",
    "CUP_V_PMC_CIRAS_Coyote_Veh",
    "CUP_V_PMC_CIRAS_OD_Veh",
    "ACRE_PRC148",
    "ACRE_PRC343",
    "SmokeShellBlue",
    "H_HelmetCrew_I",
    "Rangefinder",
    "ACE_Vector",
    "ACE_IR_Strobe_Item",
    "ItemMap",
    "ItemGPS",
    "ItemCompass",
    "ItemWatch",
    "Toolkit",
    "ACE_MapTools",
	"ACE_RangeTable_82mm",
	"ACE_artilleryTable",
    "ACE_microDAGR",

    // Ctab
    "ItemcTabHCam",
	"ItemAndroid",
    "ItemMicroDAGR",
    "ItemMicroDAGRMisc",

    "rhsgref_6b23_khaki",
    "rhsusf_oakley_goggles_blk",
    "Tier1_EXPS3_0_Black",
    "Tier1_Larue_FUG_Black"
];
_itemTankCrew append _itemHats;
_itemTankCrew append _itemNVG;
_itemTankCrew append _itemWeaponMelee;
_itemTankCrew append _itemArmNVG;
_itemTankCrew append _itemPackLight;
_itemTankCrew append _itemUniforms;
_itemTankCrew append _itemCrewHelm;
if (_winter) then {
	_itemTankCrew append _itemSantaH;
	_itemTankCrew append _winterCamo;
};

private _airHelm = [
    "H_PilotHelmetHeli_B",
    "H_PilotHelmetHeli_O",
    "H_PilotHelmetHeli_I",
	"rhsusf_ihadss",
	"rhsusf_hgu56p_visor",
	"rhsusf_hgu56p_visor_mask",
	"rhsusf_hgu56p_visor_mask_mo",
	"rhsusf_hgu56p_mask_smiley",
	"rhsusf_hgu56p_visor_mask_smiley",
	"rhsusf_hgu56p_green",
	"rhsusf_hgu56p_visor_green",
	"rhsusf_hgu56p_visor_mask_green",
	"rhsusf_hgu56p_visor_mask_green_mo",
	"rhsusf_hgu56p_green",
	"rhsusf_hgu56p_black",
	"rhsusf_hgu56p_visor_mask_black",
	"rhsusf_hgu56p_visor_mask_Empire_black",
	"rhsusf_hgu56p_white",
	"rhsusf_hgu56p_visor_white",
	"rhsusf_hgu56p_pink",
	"rhsusf_hgu56p_visor_pink",
	"rhsusf_hgu56p_visor_mask_pink",
	"rhsusf_hgu56p_saf",
	"rhsusf_hgu56p_visor_saf",
	"rhsusf_hgu56p_visor_mask_saf",
	"rhsusf_hgu56p_tan",
	"rhsusf_hgu56p_visor_tan",
	"rhsusf_hgu56p_visor_mask_tan",
	"rhs_zsh7a_mike_alt",
	"rhs_zsh7a_mike_green",
	"rhs_zsh7a_mike_green_alt",
	"rhs_zsh7a_mike"
];

private _itemHeloCrew =
[
    //"diw_armor_plates_main_plate",
    "greenmag_item_speedloader",
    "CUP_V_PMC_CIRAS_Black_Veh",
    "CUP_V_PMC_CIRAS_Khaki_Veh",
    "CUP_V_PMC_CIRAS_Coyote_Veh",
    "CUP_V_PMC_CIRAS_OD_Veh",
	"CUP_V_JPC_lightbelt_rngr",
    "ACRE_PRC148",
    "ACRE_PRC343",
    "SmokeShellBlue",
    "WU_B_HeliPilotCoveralls",
    "WU_I_HeliPilotCoveralls",
    "U_B_HeliPilotCoveralls",
    "Rangefinder",
    "ACE_Vector",
    "ACE_IR_Strobe_Item",
    "ItemMap",
    "ItemGPS",
    "ItemCompass",
    "ItemWatch",
    "Toolkit",
    "ACE_MapTools",
    "ACE_microDAGR",

    // Ctab
    "ItemcTabHCam",
    "ItemAndroidMisc",
    "ItemMicroDAGR",
    "ItemMicroDAGRMisc",

    "G_Bandanna_aviator",
    "rhsusf_mbav_light",
    "Tier1_EXPS3_0_Black",
    "Tier1_Larue_FUG_Black"
];
_itemHeloCrew append _itemHats;
_itemHeloCrew append _airHelm;
_itemHeloCrew append _itemNVG;
_itemHeloCrew append _itemWeaponMelee;
_itemHeloCrew append _itemArmNVG;
_itemHeloCrew append _itemPackLight;
_itemHeloCrew append _itemUniforms;
_itemHeloCrew append _itemCrewHelm;
if (_winter) then {
	_itemHeloCrew append _itemSantaH;
	_itemHeloCrew append _winterCamo;
};

private _itemAirCrew =
[
    "U_I_pilotCoveralls",
    "WU_O_PilotCoveralls",
    "ACE_IR_Strobe_Item",
    "greenmag_item_speedloader",
    "ACRE_PRC148",
    "ACRE_PRC343",
    "ACE_Chemlight_UltraHiOrange",
    "SmokeShellOrange",
    "H_PilotHelmetFighter_B",
    "H_PilotHelmetFighter_O",
    "H_PilotHelmetFighter_I",
    "Rangefinder",
    "ACE_Vector",
    "ItemMap",
    "ItemGPS",
    "ItemCompass",
    "ItemWatch",
    "ACE_MapTools",
    "ACE_microDAGR",

    // Ctab
    "ItemcTabHCam",
	"ItemAndroid",
    "ItemAndroidMisc",
    "ItemMicroDAGR",
    "ItemMicroDAGRMisc",

    "G_Bandanna_aviator",
	"rhs_zsh7a_alt",
	"rhs_zsh7a",
	"RHS_jetpilot_usaf"
];
_itemAirCrew append _itemHats;
_itemAirCrew append _airHelm;
_itemAirCrew append _itemNVG;
_itemAirCrew append _itemWeaponMelee;
_itemAirCrew append _itemArmNVG;
if (_winter) then {
	_itemAirCrew append _itemSantaH;
};

private _itemMedical = [""];
private _itemMedicalAdv = [""];

if (_aceMedLoaded) then { //Check for ace med
    _itemMedical =
    [
        //Bandages
        "ACE_fieldDressing",
        //"ACE_elasticBandage",
        //"ACE_packingBandage",
        //"ACE_quikclot",
        //Specialized Equipments
        "ACE_splint",
        "ACE_tourniquet",
        //Rifleman Medications
        "ACE_epinephrine",
        "ACE_morphine"
    ];
    {_x append _itemMedical} forEach [_itemEquipment, _itemTankCrew, _itemHeloCrew, _itemAirCrew];
    // Append ACE Med Items
    _itemMedicalAdv =
    [
		"ACE_packingBandage",
        "ACE_quikclot",
        "ACE_elasticBandage",
        //Fluids
        "ACE_bloodIV",
        "ACE_bloodIV_250",
        "ACE_bloodIV_500",
        "ACE_plasmaIV",
        "ACE_plasmaIV_250",
        "ACE_plasmaIV_500",
        "ACE_salineIV",
        "ACE_salineIV_250",
        "ACE_salineIV_500",
        //Medications
        //"ACE_adenosine",
        //Specialized Equipments
        "ACE_personalAidKit",
        "ACE_surgicalKit",
		"ACRE_PRC148"
    ];
	_itemMedic append _itemMedicalAdv;
} else { // Add base med items
    {_x pushBack "FirstAidKit";} forEach [_itemEquipment, _itemTankCrew, _itemHeloCrew, _itemAirCrew];
    _itemMedic append ["Medikit", "diw_armor_plates_main_autoInjector"];
};

private _ownedDLCs = getDLCs 1; // DLC check, Credit to MajorDanvers
private _hasApex = 395180 in _ownedDLCs;
private _hasContact = 1021790 in _ownedDLCs;
private _hasMarksmen = 332350 in _ownedDLCs;
private _hasLoW = 571710 in _ownedDLCs;

if (_hasApex) then {
    _itemEquipment append [
        "U_I_C_Soldier_Bandit_3_F",
        "U_I_C_Soldier_Para_2_F",
        "U_I_C_Soldier_Para_3_F",
        "U_I_C_Soldier_Para_4_F",
        "U_I_C_Soldier_Para_1_F",

        "H_HelmetB_TI_tna_F",
        "H_HelmetB_TI_arid_F",
        "U_I_C_Soldier_Camo_F"
    ];

    _itemMod append [
        "optic_ERCO_blk_F"
    ];
};
if !(_hasApex) then {
    _itemFacewear = _itemFacewear - [
        "G_Balaclava_TI_blk_F",
        "G_Balaclava_TI_G_blk_F",
		"G_Balaclava_TI_G_tna_F",
		"G_Balaclava_TI_tna_F"
    ];
};

if !(_hasLoW) then {
    _itemFacewear = _itemFacewear - [
        "G_Respirator_blue_F",
        "G_Respirator_white_F",
		"G_Respirator_yellow_F",
		"G_EyeProtectors_F",
		"G_EyeProtectors_Earpiece_F",
		"G_WirelessEarpiece_F"
    ];
};


if (_hasContact) then {

    _itemLeaderEquipment append [
        "H_Beret_EAF_01_F"
    ];

    _itemAirCrew append [
        "U_I_E_Uniform_01_coveralls_F"
    ];

    _itemSF append [
        "H_HelmetHBK_chops_F",
        "H_HelmetHBK_ear_F"
    ];
};
if !(_hasContact) then {
    _itemFacewear = _itemFacewear - [
        "G_Blindfold_01_black_F",
        "G_Blindfold_01_white_F"
	];
};
if (!_enableCBRN) then {
    _itemFacewear = _itemFacewear - [
		"G_AirPurifyingRespirator_01_F",
		"G_AirPurifyingRespirator_02_black_F",
		"G_AirPurifyingRespirator_02_olive_F",
		"G_AirPurifyingRespirator_02_sand_F",
		"G_RegulatorMask_F"
    ];
};


if (_hasMarksmen) then {
    _itemWeaponSFMMG append [
        "MMG_01_tan_F",
        "MMG_02_black_F",
        "MMG_02_sand_F"
    ];

    _itemSniper pushBack "optic_AMS";
};

//Add Existing Player Items
if (canSuspend) then {waitUntil { !isNull player };}; // should prevent FAKs/Medikits from adding when ACE enabled.

private _exWeap = weaponsItems player; // Weapons, attachments, loaded mags/ub
for "_y" from 0 to (count _exWeap - 1) do {
    {
        if (count _x == 2) then { _itemEquipment pushBackUnique (_x # 0);}
        else { _itemEquipment pushBackUnique _x;};
    } forEach (_exWeap # _y);
};

_itemEquipment append (assignedItems player + itemsWithMagazines player + [uniform player, vest player, backpack player, headgear player]);

private _tarkovuniforms = ["Tarkov_Uniforms_49"]; // most cursed is not cursed
private _whiteTexBugged = [55,56,58,59,61,62,63,64,65,68,71,72]; // bugged shirts
for [{_i = 2}, {_i < 623}, {_i = _i + 24}] do // skips Beltstaff pants
{ for "_j" from (_i) to (_i + 22) do
  { if ((_whiteTexBugged findIf {_j == _x}) == -1) then {
    _tarkovuniforms pushback ("Tarkov_Uniforms_" + str _j) }; };
};
for "_i" from (1) to (49) do { _tarkovuniforms pushback ("Tarkov_Uniforms_Scavs_" + str _i) };

// add function arg, if this is the function
if !(isNil '_additions') then {_itemEquipment append _additions};

private _unitRole = (player getVariable ["tmf_assignGear_role",typeOf player]);
if (!isNil '_role' && {_role isNotEqualTo ""}) then {systemChat ("Using set role: " + _role); _unitRole = _role;
} else { systemChat ("No role set, defaulting to: " + _unitRole); };
private _leaderRole = ["tl","sl","B_officer_F","B_Soldier_SL_F"];

if (_unitRole in (["sfsl","sfar","sfaar","sfmed","sfmat","sfdmr","sniper","spotter","aircrew"] )) then { _itemMod append _itemSuppressor}; //append _leaderRole

//Match unitrole name with the classnames in loadout.
switch (true) do
{
    case (_unitRole in ["ar","B_Soldier_AR_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponAR + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _tarkovuniforms + _itemPackMedLight)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole in ["aar","B_Soldier_AAR_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _tarkovuniforms + _itemWeaponAR + _itemPackMedLight + ["Binocular"])] call ace_arsenal_fnc_initBox;// _itemPackMedium + 
    };
    case (_unitRole in _leaderRole) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemBreacher + _itemSpecial + _itemMod + _itemReflexSight + _itemWeaponGL + _itemWeaponCQB + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole in ["r","B_Soldier_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemWeaponGL)] call ace_arsenal_fnc_initBox;

        //player setVariable ["ace_medical_medicClass", 1, true];
    };
    case (_unitRole in ["cls","B_medic_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemMedic)] call ace_arsenal_fnc_initBox;

        player setVariable ["ace_medical_medicClass", 2, true];
    };
    case (_unitRole in ["mat","B_Soldier_LAT_F"]) : // for old missions, will be wrong without tmf role
    {
        [arsenal, (_itemEquipment + _itemSpecial + _itemFacewear + _itemWeaponMAT + _itemMod + _itemReflexSight +  _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemAmmoMAT + _itemLeaderEquipment + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["amat","B_T_Soldier_AAT_F"]) :
    {
        [arsenal, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemAmmoMAT + _itemLeaderEquipment + _itemPackMedium + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["lat","B_Soldier_LAT2_F","B_Soldier_LAT_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemAmmoLAT + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemPackMedLight + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    }; // + _itemWeaponRLAT
        case (_unitRole in ["sniper","B_Sharpshooter_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemSpecial + _itemWeaponSharpshooter + _itemWeaponPistol + _itemWeaponCQB + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemWeaponSniper + _itemSniper + _itemSniperAmmo + _itemLeaderEquipment + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["spotter","B_Spotter_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemSpecial + _itemWeaponSharpshooter + _itemWeaponRifle + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemSniper + _itemLeaderEquipment + _itemSniperAmmo + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["sfsl","B_recon_TL_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponGL + _itemWeaponSFSL + _itemWeaponCQB + _itemWeaponRifle + _itemWeaponCarbine + _itemBreacher + _itemSpecial + _itemWeaponHighCapAmmo + _itemAmmoMAT + _itemWeaponARAmmo + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemLeaderEquipment + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemPackMedium + _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;

        player setUnitTrait ["Medic", true];
    };
        case (_unitRole in ["sfmed","B_recon_medic_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponRLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemAmmoMAT + _itemMedic + ["mjb_carryallplus_oucamo"] + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;

        player setUnitTrait ["Medic", true];
        player setVariable ["ace_medical_medicClass", 2, true];
    };
        case (_unitRole in ["sfmat","B_recon_LAT_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponRLAT + _itemAmmoLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSFMAT + _itemAmmoMAT + _itemPackMedium + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;

        player setUnitTrait ["Medic", true];
    };
        case (_unitRole in ["sfar","B_Patrol_Soldier_MG_F","B_Recon_exp_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponAR + _itemWeaponARAmmo + _itemWeaponSFAR + _itemWeaponHighCapAmmo + _itemAmmoMAT + _itemMod + _itemReflexSight + _itemWeaponPistol +_itemWeaponSFMMG + _itemWeaponMMGAmmo + _itemPackMedium + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;

        player setUnitTrait ["Medic", true];
    };
        case (_unitRole in ["sfaar","B_recon_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemAmmoMAT + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemWeaponMMGAmmo + _itemPackMedium + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox;

        player setUnitTrait ["Medic", true];
    };
        case (_unitRole in ["sfdmr","B_recon_M_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponLAT + _itemWeaponCQB + _itemSpecial + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponSharpshooter + _itemSniper + _itemAmmoMAT + _itemMod + _itemReflexSight + _itemWeaponRifle + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemSF + _tarkovuniforms)] call ace_arsenal_fnc_initBox; //+ _itemWeaponSniper

        player setUnitTrait ["Medic", true];
    };
    case (_unitRole in ["ceng","B_engineer_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemBreacher + _itemEngineer + _itemLeaderEquipment + _itemPackHeavy + _itemUAVTermial + _tarkovuniforms)] call ace_arsenal_fnc_initBox;

        player setUnitTrait ["UAVHacker", true];

        /*if (isNil "mjb_engiButtonId") then {mjb_engiButtonId = -1;};
        mjb_engiButtonId = [(_itemEngineer), "Engineer","\A3\ui_f\data\igui\cfg\actions\repair_ca.paa", mjb_engiButtonId] call ace_arsenal_fnc_addRightPanelButton;*/
    };
    case (_unitRole in ["crew","B_crew_F"]) :
    {
        [arsenal, (_ItemTankCrew + ( _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo) + _itemFacewear + _itemWeaponCQB + _itemMod + _itemWeaponPistol + _itemReflexSight + _itemLeaderEquipment + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole in ["helocrew","B_helipilot_F"]) :
    {
        [arsenal, (_ItemHeloCrew + ( _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo) + _itemFacewear + _itemWeaponCQB + _itemMod + _itemWeaponPistol + _itemReflexSight + _itemLeaderEquipment + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole in ["aircrew","B_Pilot_F","B_Fighter_Pilot_F"]) :
    {
        [arsenal, (_ItemAirCrew + _itemFacewear + _itemWeaponPistol + _itemMod + _itemLeaderEquipment)] call ace_arsenal_fnc_initBox;
    };
    case (_unitRole in ["hat","B_Soldier_AT_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponHAT + _itemLeaderEquipment + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["ahat","B_Soldier_AAT_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoHAT + _itemLeaderEquipment + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
		case (_unitRole in ["spaa","B_Soldier_AA_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemWeaponSPAA + _itemLeaderEquipment + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoSPAA + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["aspaa","B_Soldier_AAA_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo +  _itemAmmoSPAA + _itemLeaderEquipment + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["mmg","B_HeavyGunner_F"]) :
    {
        [arsenal, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponPistol + _itemWeaponAR + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponMMG + _itemWeaponMMGAmmo + _itemLeaderEquipment + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["ammg","B_Soldier_A_F"]) :
    {
        [arsenal, (_itemEquipment + _itemSpecial + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine+ _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponARAmmo + _itemWeaponHighCapAmmo + _itemWeaponMMGAmmo + _itemLeaderEquipment  + _itemPackHeavy + _tarkovuniforms + ["Binocular"])] call ace_arsenal_fnc_initBox;
    };
		case (_unitRole in ["isr","B_Soldier_UAV_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemLeaderEquipment + _itemUAVTermial)] call ace_arsenal_fnc_initBox;
    };
		case (_unitRole in ["mrt","B_support_Mort_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemWeaponMortar + _itemMortarAmmo + _itemLeaderEquipment + _itemPackHeavy + ["NDS_M224_B_Ammo"] + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
		case (_unitRole in ["amrt","B_support_AMort_F"]) :
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB + _itemWeaponPistol + _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponAmmo + _itemWeaponTracerAmmo + _itemMortarAmmo + _itemLeaderEquipment + _itemPackHeavy + _tarkovuniforms)] call ace_arsenal_fnc_initBox;
    };
        case (_unitRole in ["full","zeus","B_RangeMaster_F"]) :
    {
        [arsenal, true] call ace_arsenal_fnc_initBox;
    };
    default
    {
        [arsenal, (_itemEquipment + _itemFacewear + _itemMod + _itemReflexSight + _itemWeaponCQB +  _itemWeaponRifle + _itemWeaponCarbine + _itemWeaponPistol + _itemWeaponAmmo + _itemWeaponTracerAmmo + _tarkovuniforms + _itemWeaponGL)] call ace_arsenal_fnc_initBox;

        //player setVariable ["ace_medical_medicClass", 1, true];
    };
};

if (isNil "ace_medical_engine") then {
	if !(isNil "mjb_medicalButtonId") then {mjb_medicalButtonId = -1;};
	mjb_medicalButtonId = [(["diw_armor_plates_main_plate","diw_armor_plates_main_autoInjector","FirstAidKit","Medikit"] + _itemMedical + _itemMedicalAdv), "Medical/Plates","\A3\ui_f\data\igui\cfg\cursors\unitHealer_ca.paa", mjb_medicalButtonId] call ace_arsenal_fnc_addRightPanelButton;
};

private _limitedItems = []; // Items to be limited to default loadout amount

[arsenal, _limitedItems] call ace_arsenal_fnc_removeVirtualItems;

if !(isNil 'missionArsenal') then {
	[missionArsenal, _limitedItems] call ace_arsenal_fnc_removeVirtualItems;
};

private _action =
[
    "personal_arsenal","Personal Arsenal","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa",
    {
        lockIdentity player;
        [arsenal, _player] call ace_arsenal_fnc_openBox
    },
    {
        (player distance2d (player getVariable ["startpos",[0,0,0]])) < 200
    },
    {},
    [],
    [0,0,0],
    3
] call ace_interact_menu_fnc_createAction;

["CAManBase", 1, ["ACE_SelfActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

if !(isNil "tmf_safestart_instance" && {time < 5}) exitWith {};
[player, currentWeapon player, currentMuzzle player] call ACE_SafeMode_fnc_lockSafety;
