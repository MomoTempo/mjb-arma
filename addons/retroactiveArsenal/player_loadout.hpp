/*
	Base Player Loadout for MJB ARMA
	Based on veerserif's revised loadout and SuperJam's revised mission templates
	Edited by NotherDuck on 2021-08-20
	Changenotes:
		- Removed all ACRE radios
		- Added tracers to Leader and AR roles
	Edited by Beagle on 2021-08-24
	Edited by Alien314 on 2021-12-10
	  Changenotes:
		- Added code to initialize players/respawns, disabling base game stamina and adding APS plates and actions.
        - 2022-02-02: Uncommented RHS vests for SF
        - Switched default rifle and TL weapons for RHS ones
        - 2022-02-11: Add MMG team (mjbLOVE for Banzerschreck)
		- 2025-11-03: ACE med and plate regen tweaks. Removed rhs in base loadouts, remains in aresenal for now
*/

// CHANGES HERE WILL NOT BE REFLECTED UNLESS A LINE IN DESCRIPTION.ext IS UNCOMMENTED

// Weaponless Baseclass
class basetrooper
{
	displayName = "Unarmed";
	// All Randomized.
	// Pants Beagle used - Blackhawk, Deep Recon, G99, Jeans, Tier 3, Triarius,
	uniform[] = {
		"Tarkov_Uniforms_26",
		"Tarkov_Uniforms_30",
		"Tarkov_Uniforms_32",
		"Tarkov_Uniforms_36",
		"Tarkov_Uniforms_43",
		"Tarkov_Uniforms_44",
		"Tarkov_Uniforms_50",
		"Tarkov_Uniforms_54",
		//"Tarkov_Uniforms_56", white tex bug
		"Tarkov_Uniforms_60",
		"Tarkov_Uniforms_67",
		//"Tarkov_Uniforms_68", white tex bug
		"Tarkov_Uniforms_338",
		"Tarkov_Uniforms_342",
		"Tarkov_Uniforms_344",
		"Tarkov_Uniforms_348",
		"Tarkov_Uniforms_355",
		"Tarkov_Uniforms_356",
		"Tarkov_Uniforms_98",
		"Tarkov_Uniforms_102",
		"Tarkov_Uniforms_104",
		"Tarkov_Uniforms_108",
		"Tarkov_Uniforms_115",
		"Tarkov_Uniforms_116",
		"Tarkov_Uniforms_410",
		"Tarkov_Uniforms_414",
		"Tarkov_Uniforms_416",
		"Tarkov_Uniforms_420",
		"Tarkov_Uniforms_427",
		"Tarkov_Uniforms_428",
		"Tarkov_Uniforms_146",
		"Tarkov_Uniforms_150",
		"Tarkov_Uniforms_152",
		"Tarkov_Uniforms_163",
		"Tarkov_Uniforms_156",
		"Tarkov_Uniforms_164",
		"Tarkov_Uniforms_170",
		"Tarkov_Uniforms_174",
		"Tarkov_Uniforms_176",
		"Tarkov_Uniforms_180",
		"Tarkov_Uniforms_187",
		"Tarkov_Uniforms_188",
		"Tarkov_Uniforms_194",
		"Tarkov_Uniforms_198",
		"Tarkov_Uniforms_200",
		"Tarkov_Uniforms_204",
		"Tarkov_Uniforms_211",
		"Tarkov_Uniforms_212",
		"Tarkov_Uniforms_242",
		"Tarkov_Uniforms_246",
		"Tarkov_Uniforms_248",
		"Tarkov_Uniforms_252",
		"Tarkov_Uniforms_259",
		"Tarkov_Uniforms_260",
		"Tarkov_Uniforms_530",
		"Tarkov_Uniforms_534",
		"Tarkov_Uniforms_536",
		"Tarkov_Uniforms_540",
		"Tarkov_Uniforms_547",
		"Tarkov_Uniforms_548",
		"Tarkov_Uniforms_266",
		"Tarkov_Uniforms_272",
		"Tarkov_Uniforms_276",
		"Tarkov_Uniforms_270",
		"Tarkov_Uniforms_283",
		"Tarkov_Uniforms_284",
		"Tarkov_Uniforms_290",
		"Tarkov_Uniforms_294",
		"Tarkov_Uniforms_296",
		"Tarkov_Uniforms_300",
		"Tarkov_Uniforms_307",
		"Tarkov_Uniforms_308",
		"Tarkov_Uniforms_602",
		"Tarkov_Uniforms_606",
		"Tarkov_Uniforms_608",
		"Tarkov_Uniforms_612",
		"Tarkov_Uniforms_619",
		"Tarkov_Uniforms_620",
		"Tarkov_Uniforms_624"
	};
	vest[] = {
		"V_PlateCarrier2_blk"
	};
	backpack[] = {
		"B_AssaultPack_rgr"
	};
	headgear[] = {
		"H_HelmetSpecB_blk"
	};
	goggles[] = {};
	hmd[] = {
		"CUP_NVG_GPNVG_green_WP"
	};

	//All Randomized. Add Primary Weapon and attachments.
	//Leave Empty to remove all. {"Default"} for using original items the character start with.
	primaryWeapon[] = {};
	scope[] = {};
	bipod[] = {};
	attachment[] = {};
	silencer[] = {};

	// *WARNING* secondaryAttachments[] arrays are NOT randomized.
	secondaryWeapon[] = {};
	secondaryAttachments[] = {};
	sidearmWeapon[] = {"CUP_hgun_M9A1"};
	sidearmAttachments[] = {};

	// These are added to the uniform or vest first - overflow goes to backpack if there's any.
	magazines[] = {
		LIST_2("HandGrenade"),
		LIST_2("SmokeShell")
	};
	items[] = {
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
			#else
				LIST_20("ACE_fieldDressing"),
				//LIST_10("ACE_packingBandage"),
				//LIST_5("ACE_quikclot"),
				LIST_4("ACE_tourniquet"),
				LIST_2("ACE_epinephrine"),
				LIST_2("ACE_morphine"),
				LIST_2("ACE_splint"),
				//LIST_3("ACE_bloodIV_500"),
			#endif
		#else
		#endif
		"ACE_CableTie",
		"ACE_IR_Strobe_Item",
		"greenmag_item_speedloader",
		"ACE_RangeCard",
		"ACE_MapTools"
	};

	// These are added directly into their respective slots
	linkedItems[] = {
		"ItemWatch",
		"ItemMap",
		#if __has_include("\ctab\script_component.hpp")
			"ItemAndroid",
		#else
			"ItemGPS",
		#endif
		"ItemCompass"
	};

	// These are put directly into the backpack.
	backpackItems[] = {
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_5("FirstAidKit")
			#else
			#endif
		#else
			LIST_5("FirstAidKit")
		#endif
	};

	// This is executed (server-side) after the unit init is complete. Argument: _this = _unit.
	code = "if !(local _this) exitWith {}; _this spawn mjb_arsenal_fnc_tmfSpawnFix;";//"0 = _this execVM ""loadouts\TMFspawnFix.sqf"";"; //
    /* tmfSpawnFix sets stam/fatigue off, iFatigue sway, and adds APS stuff for TMF Respawns */
};

// Basic RAT Rifle/JIP slot
class r : basetrooper
{
	displayName = "Rifletrooper";
	primaryWeapon[] = {
		"CUP_arifle_HK416_Black"
	};
	scope[] = {
		"optic_hamr"
	};
	attachment[] = {
		"CUP_acc_ANPEQ_15_Flashlight_Black_L"
	};
	magazines[] += {
		LIST_2("tsp_flashbang_m84"),
		"mjb_SmokeShellLightBlue",
		"CUP_15Rnd_9x19_M9",
		LIST_7("CUP_30Rnd_556x45_PMAG_BLACK_PULL")
	};
	backpackItems[] += {
		LIST_6("CUP_30Rnd_556x45_PMAG_BLACK_PULL"),
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
				LIST_20("ACE_fieldDressing"),
				//LIST_10("ACE_packingBandage"),
				//LIST_5("ACE_quikclot"),
				LIST_4("ACE_tourniquet"),
				LIST_2("ACE_epinephrine"),
				LIST_2("ACE_morphine"),
				LIST_2("ACE_splint"),
				//LIST_2("ACE_bloodIV"),
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_2("HandGrenade"),
		LIST_2("SmokeShell")
	};

};

// RATS Rifle Respawn
class riflerespawn : r
{
	displayName = "Rifle RAT";
	primaryWeapon[] = {
		"CUP_arifle_HK416_Black"
	};
	scope[] = {
		"optic_hamr"
	};
	attachment[] = {
		"CUP_acc_ANPEQ_15_Flashlight_Black_L"
	};
	magazines[] += {
		LIST_2("tsp_flashbang_m84"),
		"mjb_SmokeShellLightBlue",
		"CUP_15Rnd_9x19_M9",
		LIST_7("CUP_30Rnd_556x45_PMAG_BLACK_PULL")
	};
	backpackItems[] += {
		LIST_6("CUP_30Rnd_556x45_PMAG_BLACK_PULL"),
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
				LIST_20("ACE_fieldDressing"),
				//LIST_10("ACE_packingBandage"),
				//LIST_5("ACE_quikclot"),
				LIST_4("ACE_tourniquet"),
				LIST_2("ACE_epinephrine"),
				LIST_2("ACE_morphine"),
				LIST_2("ACE_splint"),
				//LIST_2("ACE_bloodIV"),
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_2("HandGrenade"),
		LIST_2("SmokeShell")
	};
};

// RATS SF Respawn
class sfrespawn : r {
	displayName = "SF Rifle RAT";
	silencer[] = {
		"CUP_muzzle_snds_SCAR_L"
	};
	headgear[] = {
		"H_HelmetB_camo"
	};
	goggles[] =
	{
		"CUP_G_ESS_BLK_Facewrap_Black"
	};
	magazines[] = {
		LIST_12("CUP_30Rnd_556x45_Emag"),
		LIST_2("tsp_flashbang_cts"),
		LIST_2("SmokeShellBlue"),
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		"HandGrenade",
		"CUP_12Rnd_45ACP_mk23"
	};
	vest[] = {
		//"rhsusf_plateframe_rifleman"
		"CUP_V_B_Ciras_Khaki3"
	};
	backpack[] = {
		"G2_Gunslinger"
	};
	sidearmWeapon[] = {
		"CUP_hgun_Mk23"
	};
	sidearmAttachments[] = {
		"cup_acc_mk23_lam_f",
		"cup_muzzle_snds_mk23",
	};
	items[] += {
		"ACE_CableTie",
		"ACE_IR_Strobe_Item"
	};
};

// RATS Automatic Rifle Slot
class ar : basetrooper
{
	displayName = "Machinegun";
	primaryWeapon[] = {
		"CUP_lmg_L110A1"
	};
	scope[] = {
		"optic_hamr"
	};
	bipod[] = {};
	silencer[] = {
		"CUP_muzzle_mfsup_Flashhider_556x45_Black"
	};
	magazines[] +=
	{
		LIST_2("tsp_flashbang_m84"),
		"mjb_SmokeShellLightBlue",
		"CUP_15Rnd_9x19_M9",
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_2("FirstAidKit"),
			#else
			#endif
		#else
			LIST_2("FirstAidKit"),
		#endif
		LIST_2("greenmag_beltlinked_556x45_basic_200")
	};
	backpack[] = {
		"B_Kitbag_rgr"
	};
	// Commented out, we may want this back in the future
	// backpack[] = {
	//	"B_Carryall_cbr"
	// };
	backpackItems[] = {
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_4("CUP_100Rnd_TE4_Yellow_Tracer_556x45_M249"),
		LIST_3("greenmag_beltlinked_556x45_basic_200")
	};
};

// RATS Rifle Ammo Bearer
class aar : r
{
	displayName = "Machinegun Ammo Bearer";
	backpack[] = {
		"B_Kitbag_rgr"
	};
	// Commented out, we may want this back in the future
	// backpack[] = {
	// 	"B_Carryall_cbr"
	// };
	items[] += {
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_5("FirstAidKit")
			#else
			#endif
		#else
			LIST_5("FirstAidKit")
		#endif
	};
	backpackItems[] = {
		LIST_2("greenmag_ammo_556x45_basic_60Rnd"),
		LIST_2("greenmag_beltlinked_556x45_basic_200"),
		LIST_2("CUP_100Rnd_TE4_Yellow_Tracer_556x45_M249")
	};
	linkedItems[] += {
		"Binocular"
	};
};

// RATS Medium Machine Gunner
class mmg : ar
{
	displayName = "MMG Gunner";
	items[] += {
		#if __has_include("\ctab\script_component.hpp")
			"ItemAndroidMisc"
		#endif
	};
	primaryWeapon[] =
	{
		"CUP_lmg_Mk48"
	};
	scope[] = {
		"CUP_optic_HensoldtZO_low_RDS" //?
	};
	silencer[] = {
		"ACE_muzzle_mzls_B"
	};
	magazines[] =
	{
		LIST_2("tsp_flashbang_m84"),
		"mjb_SmokeShellLightBlue",
		LIST_3("greenmag_beltlinked_762x51_basic_200"),
		"CUP_15Rnd_9x19_M9"
	};
	backpack[] = {
		"B_Carryall_cbr"
	};
	backpackItems[] = {
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_4("FirstAidKit"),
			#else
			#endif
		#else
			LIST_4("FirstAidKit"),
		#endif
		LIST_4("CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M"),
		LIST_1("greenmag_beltlinked_762x51_basic_200")
	};
	linkedItems[] += {
		"Rangefinder"
	};
};

// RATS Medium Machine Gunner Assistant
class ammg : aar
{
  displayName = "Assistant MMG";
	backpack[] = {
		"B_Carryall_cbr"
	};
	backpackItems[] = {
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_4("FirstAidKit"),
			#else
			#endif
		#else
			LIST_4("FirstAidKit"),
		#endif
		LIST_4("greenmag_beltlinked_762x51_basic_200"),
		LIST_2("CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M")
	};
	linkedItems[] += {
		"Rangefinder"
	};
};

// RATS Sniper
class sniper : basetrooper
{
	displayName = "Sniper";
	primaryWeapon[] =
	{
		"CUP_srifle_M107_Pristine"
	};
	scope[] = {
		"CUP_optic_LeupoldMk4_25x50_LRT"
	};
	bipod[] = {};
	silencer[] = {
		"CUP_muzzle_mfsup_Suppressor_M107_Black"
	};
	sidearmWeapon[] =
	{
		"CUP_hgun_MP7"
	};
	linkedItems[] += {
		"Rangefinder"
	};
	magazines[] = {
		"ACE_ATragMX",
		"ACE_Clacker",
		"DemoCharge_Remote_Mag",
		LIST_2("greenmag_ammo_127x99_basic_60Rnd"),
		LIST_2("CUP_40Rnd_46x30_MP7"),
		LIST_2("ACE_10Rnd_127x99_API_Mag"),
		"HandGrenade",
		LIST_2("SmokeShell")
	};
	items[] += {
		#if __has_include("\ctab\script_component.hpp")
			"ItemAndroidMisc"
		#endif
	};
	backpackItems[] += {
		"ACE_Tripod",
		LIST_3("ACE_10Rnd_127x99_API_Mag")
	};
};

// RATS Spotter
class spotter : r
{
	displayName = "Spotter";
	scope[] = {
		"CUP_optic_Elcan_SpecterDR_RMR_black"
	};
	bipod[] =
	{
		"CUP_bipod_Harris_1A2_L_BLK"
	};
	linkedItems[] += {
		"Rangefinder"
	};
};

// RATS Rifle Fireteam Leader
class tl : r
{
	displayName = "Team Leader";
	primaryWeapon[] = {
		"CUP_arifle_mk18_m203_black"
	};
	attachment[] = {
		"CUP_acc_llm_black"
	};
	bipod[] = {};
	items[] += {
		#if __has_include("\ctab\script_component.hpp")
			"ItemAndroidMisc"
		#endif
	};
	magazines[] = {
		LIST_2("tsp_flashbang_m84"),
		LIST_2("greenmag_ammo_556x45_basic_60Rnd"),
		"mjb_SmokeShellLightBlue",
		"SmokeShellBlue",
		"CUP_15Rnd_9x19_M9",
		LIST_10("CUP_30Rnd_556x45_Emag_Tracer_Yellow")
	};
	linkedItems[] += {
		"Rangefinder"
	};
	backpackItems[] = {
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_21("1Rnd_HE_Grenade_shell"),
		LIST_2("1Rnd_Smoke_Grenade_shell"),
		LIST_4("CUP_30Rnd_556x45_Emag_Tracer_Yellow")
	};
};

// RATS Squad Leader
class sl : tl
{
	displayName = "Squad Leader";
	backpackItems[] += {
		LIST_2("1Rnd_SmokeBlue_Grenade_shell"),
		LIST_2("1Rnd_SmokeRed_Grenade_shell")
	};
};

// RATS Medic
class cls : r
{
	displayName = "Medic";
	traits[] = {
		"medic"
	};
	backpack[] = {
		"B_Carryall_oucamo"
	};
	magazines[] = {
		LIST_2("tsp_flashbang_m84"),
		"CUP_15Rnd_9x19_M9",
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_5("diw_armor_plates_main_autoInjector"),
			#else
			#endif
		#else
			LIST_5("diw_armor_plates_main_autoInjector"),
		#endif
		LIST_1("HandGrenade"),
		LIST_1("SmokeShell"),
		LIST_12("CUP_30Rnd_556x45_PMAG_BLACK_PULL")
	};
	backpackItems[] =
	{
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_10("FirstAidKit"),
				"Medikit",
			#else
				"ACE_surgicalKit",
				LIST_1("ACE_personalAidKit"),
				LIST_40("ACE_elasticBandage"),
				LIST_20("ACE_elasticBandage"),
				LIST_30("ACE_fieldDressing"),
				//LIST_30("ACE_packingBandage"),
				//LIST_10("ACE_quikclot"),
				LIST_15("ACE_epinephrine"),
				LIST_15("ACE_morphine"),
				LIST_12("ACE_bloodIV"),
				LIST_10("ACE_splint"),
				LIST_6("ACE_tourniquet"),
				//LIST_2("ACE_adenosine"),
			#endif
		#else
			LIST_10("FirstAidKit"),
			"Medikit",
		#endif
		LIST_1("SmokeShell"),
		LIST_2("mjb_SmokeShellLightBlue"),
		LIST_2("mjb_SmokeShellPink")
	};
};

// RATS Rifle Light Anti-Tank
class lat : r
{
	displayName = "Trooper (Light Anti-tank)";
	secondaryWeapon[] = {
		"CUP_launch_M136"
	};
	backpack[] = {
		"B_Kitbag_rgr"
	};
	backpackItems[] =
	{
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		LIST_1("CUP_launch_M136")
	};
};

// RATS Medium Anti-Tank
class mat : r
{
	displayName = "Antitank Trooper";
	items[] += {
		#if __has_include("\ctab\script_component.hpp")
			"ItemAndroidMisc"
		#endif
	};
	secondaryWeapon[] = {
		"launch_MRAWS_green_rail_F"
	};
	backpack[] = {
		"B_Carryall_cbr"
	};
	backpackItems[] =
	{
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_4("MRAWS_HEAT_F")
	};
};

// RATS Assistant Medium Anti-Tank
class amat : r
{
	displayName = "Antitank ammo bearer";
	backpack[] = {
		"B_Carryall_cbr"
	};
	linkedItems[] += {
		"Rangefinder"
	};
	backpackItems[] =
	{
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		LIST_4("MRAWS_HEAT_F")
	};
};

// RATS Weapons Team Leader
class wpntl : tl {
	displayName = "Weapons Team Leader";
	backpack[] = {
		"B_Carryall_cbr"
	};
	backpackItems[] = {
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_21("1Rnd_HE_Grenade_shell"),
		LIST_2("1Rnd_Smoke_Grenade_shell"),
		LIST_4("CUP_30Rnd_556x45_Emag_Tracer_Yellow"),
		LIST_3("MRAWS_HEAT_F")
	};
};

// RATS Heavy Anti-Tank
class hat : mat
{
	displayName = "Heavy Antitank Trooper";
	secondaryWeapon[] = {
		"launch_I_Titan_short_F"
	};
	backpack[] = {
		"B_Bergen_mcamo_F"
	};
	backpackItems[] =
	{
		LIST_3("Titan_AT"),
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_5("FirstAidKit"),
			#else
			#endif
		#else
			LIST_5("FirstAidKit"),
		#endif
		LIST_2("greenmag_ammo_556x45_basic_60Rnd")
	};
	linkedItems[] += {
		"Rangefinder"
	};
};

// RATS Assistant Anti-Tank
class ahat : hat
{
	displayName = "Heavy Antitank ammo bearer";
	secondaryWeapon[] = {};
	items[] += {
		LIST_2("SmokeShell")
	};
};

// RATS Anti-Air
class spaa : hat
{
	displayName = "Specialized Antiair";
	secondaryWeapon[] = {
		"launch_I_Titan_F"
	};
	backpackItems[] =
	{
		LIST_3("Titan_AA"),
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_5("FirstAidKit"),
			#else
			#endif
		#else
			LIST_5("FirstAidKit"),
		#endif
		LIST_2("greenmag_ammo_556x45_basic_60Rnd")
	};
};

// RATS Assistant Anti-Air
class aspaa : spaa
{
	displayName = "Specialized Antiair ammo bearer";
	secondaryWeapon[] = {};
	items[] += {
		LIST_2("SmokeShell")
	};
};
// RATS Mortar Gunner
class mrt : r
{
	displayName = "Mortar Gunner";
	items[] += {
		#if __has_include("\ctab\script_component.hpp")
			"ItemAndroidMisc"
		#endif
	};
	secondaryWeapon[] = {
		"NDS_W_M224_mortarCarry"
	};
	backpack[] = {
		"mjb_carryallplus_oli"
	};
	linkedItems[] += {
		"Rangefinder"
	};
	backpackItems[] =
	{
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_1("NDS_M_6Rnd_60mm_HE"),
		LIST_1("NDS_M_6Rnd_60mm_SMOKE")
	};
};

// RATS Mortar Assistant
class amrt : r
{
	displayName = "Mortar Assistant";
	backpack[] = {
		"B_Carryall_cbr"
	};
	linkedItems[] += {
		"Rangefinder"
	};
	backpackItems[] =
	{
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_3("FirstAidKit"),
			#else
			#endif
		#else
			LIST_3("FirstAidKit"),
		#endif
		LIST_1("NDS_M_6Rnd_60mm_HE"),
		LIST_1("NDS_M_6Rnd_60mm_ILLUM")
	};
};

// RATS Special Forces Team Leader/Squad Leader
class sfsl : sl
{
	displayName = "SF Team Leader";
	silencer[] = {
		"CUP_muzzle_snds_SCAR_L"
	};
	headgear[] = {
		"H_HelmetB_camo"
	};
	goggles[] = {
		"CUP_G_ESS_BLK_Facewrap_Black"
	};
	vest[] = {
		//"rhsusf_plateframe_teamleader"
		"CUP_V_B_Ciras_Khaki2"
	};
	backpack[] = {
		"G2_Gunslinger"
	};
	sidearmWeapon[] = {
		"CUP_hgun_Mk23"
	};
	sidearmAttachments[] = {
		"cup_acc_mk23_lam_f",
		"cup_muzzle_snds_mk23",
	};
	items[] += {
		"ACE_CableTie",
		"ACE_IR_Strobe_Item",
		"Laserbatteries"
	};
	magazines[] = {
		LIST_7("CUP_30Rnd_556x45_Emag_Tracer_Yellow"),
		LIST_4("tsp_flashbang_cts"),
		LIST_2("HandGrenade"),
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		"CUP_12Rnd_45ACP_mk23"
	};
	backpackItems[] +={
		LIST_3("1Rnd_HE_Grenade_Shell")
	};
	linkedItems[] += {
		"Laserdesignator_01_khk_F"
	};
};

// RATS Special Forces Platoon Leader
class sfl : sfsl
{
	displayName = "SF Commander";
};

// RATS Special Forces Medic
class sfmed : cls
{
	displayName = "SF Medic";
	headgear[] = {
		"H_HelmetB_camo"
	};
	goggles[] = {
		"CUP_G_ESS_BLK_Facewrap_Black"
	};
	vest[] = {
		//"rhsusf_plateframe_medic"
		"CUP_V_B_Ciras_Khaki"
	};
	backpack[] = {
		"G2_Gunslinger"
	};
	primaryWeapon[] =
	{
		"CUP_sgun_AA12"
	};
	attachment[] = {};
	sidearmWeapon[] = {
		"CUP_hgun_Mk23"
	};
	sidearmAttachments[] = {
		"cup_acc_mk23_lam_f",
		"cup_muzzle_snds_mk23",
	};
	magazines[] = {
		LIST_5("CUP_20Rnd_B_AA12_Slug"),
		LIST_3("greenmag_ammo_12G_basic_24Rnd"),
		"mjb_SmokeShellLightBlue",
		LIST_2("mjb_SmokeShellPink"),
		LIST_2("tsp_flashbang_cts"),
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_5("diw_armor_plates_main_autoInjector"),
			#else
			#endif
		#else
			LIST_5("diw_armor_plates_main_autoInjector"),
		#endif
		"CUP_12Rnd_45ACP_mk23"
	};
	linkedItems[] += {
		"Rangefinder"
	};
	backpackItems[] =
	{
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_10("FirstAidKit"),
				"Medikit",
			#else
				"ACE_surgicalKit",
				LIST_1("ACE_personalAidKit"),
				LIST_40("ACE_elasticBandage"),
				LIST_20("ACE_elasticBandage"),
				LIST_30("ACE_fieldDressing"),
				//LIST_30("ACE_packingBandage"),
				//LIST_10("ACE_quikclot"),
				LIST_15("ACE_epinephrine"),
				LIST_15("ACE_morphine"),
				LIST_12("ACE_bloodIV"),
				LIST_10("ACE_splint"),
				LIST_6("ACE_tourniquet"),
				//LIST_2("ACE_adenosine"),
			#endif
		#else
			LIST_10("FirstAidKit"),
			"Medikit",
		#endif
		LIST_2("SmokeShell"),
		LIST_2("mjb_SmokeShellLightBlue"),
		LIST_1("mjb_SmokeShellPink")
	};
};

// RATS Special Forces AT Operator
class sfmat : mat
{
	displayName = "SF Antitank trooper";
	silencer[] = {
		"CUP_muzzle_snds_SCAR_L"
	};
	headgear[] = {
		"H_HelmetB_camo"
	};
	goggles[] =
	{
		"CUP_G_ESS_BLK_Facewrap_Black"
	};
	vest[] = {
		//"rhsusf_plateframe_rifleman"
		"CUP_V_B_Ciras_Khaki3"
	};
	backpack[] = {
		"G2_Gunslinger"
	};
	sidearmWeapon[] = {
		"CUP_hgun_Mk23"
	};
	sidearmAttachments[] = {
		"cup_acc_mk23_lam_f",
		"cup_muzzle_snds_mk23",
	};
	items[] += {
		"ACE_CableTie",
		"ACE_IR_Strobe_Item"
	};
	magazines[] = {
		LIST_12("CUP_30Rnd_556x45_Emag"),
		LIST_2("tsp_flashbang_cts"),
		LIST_2("SmokeShellBlue"),
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		"HandGrenade",
		"CUP_12Rnd_45ACP_mk23"
	};
	backpackItems[] += {};
	linkedItems[] += {
		"Rangefinder"
	};
};

// RATS Special Forces Machine Gunner
class sfar : ar
{
	displayName = "SF Machinegunner";
	headgear[] = {
		"H_HelmetB_camo"
	};
	goggles[] = {
		"CUP_G_ESS_BLK_Facewrap_Black"
	};
	vest[] = {
		//"rhsusf_plateframe_machinegunner"
		"CUP_V_B_MTV_MG"
	};
	backpack[] = {
		"G2_Gunslinger"
	};
	primaryWeapon[] =
	{
		"CUP_lmg_Mk48"
	};
	scope[] = {
		"CUP_optic_Elcan_SpecterDR_RMR_black"
	};
	attachment[] = {
		"CUP_acc_ANPEQ_15_Flashlight_Black_L"
	};
	silencer[] = {
		"muzzle_snds_h_mg_blk_f"
	};
	sidearmWeapon[] = {
		"CUP_hgun_Mk23"
	};
	sidearmAttachments[] = {
		"cup_acc_mk23_lam_f",
		"cup_muzzle_snds_mk23",
	};
	magazines[] = {
		LIST_2("CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M"),
		LIST_2("tsp_flashbang_cts"),
		LIST_2("SmokeShellBlue"),
		"HandGrenade",
		"CUP_12Rnd_45ACP_mk23"
	};
	backpackItems[] =
	{
		LIST_3("CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M"),
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_4("FirstAidKit"),
			#else
			#endif
		#else
			LIST_4("FirstAidKit"),
		#endif
	};
	linkedItems[] += {
		"Rangefinder"
	};
};

// RATS Special Forces Sharpshooter
class sfdmr : spotter {
	displayName = "SF Sharpshooter";
	silencer[] = {
		"CUP_muzzle_snds_SCAR_L"
	};
	headgear[] = {
		"H_HelmetB_camo"
	};
	goggles[] =
	{
		"CUP_G_ESS_BLK_Facewrap_Black"
	};
	vest[] = {
		//"rhsusf_plateframe_rifleman"
		"CUP_V_B_Ciras_Khaki3"
	};
	backpack[] = {
		"G2_Gunslinger"
	};
	sidearmWeapon[] = {
		"CUP_hgun_Mk23"
	};
	sidearmAttachments[] = {
		"cup_acc_mk23_lam_f",
		"cup_muzzle_snds_mk23",
	};
	items[] += {
		"ACE_CableTie",
		"ACE_IR_Strobe_Item"
	};
};

// RATS Special Forces Ammo Bearer
class sfaar : aar {
	displayName = "SF Ammo Bearer";
	silencer[] = {
		"CUP_muzzle_snds_SCAR_L"
	};
	headgear[] = {
		"H_HelmetB_camo"
	};
	goggles[] =
	{
		"CUP_G_ESS_BLK_Facewrap_Black"
	};
	vest[] = {
		//"rhsusf_plateframe_rifleman"
		"CUP_V_B_Ciras_Khaki3"
	};
	backpack[] = {
		"G2_Gunslinger"
	};
	magazines[] = {
		LIST_12("CUP_30Rnd_556x45_Emag"),
		LIST_2("tsp_flashbang_cts"),
		LIST_2("SmokeShellBlue"),
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		"HandGrenade",
		"CUP_12Rnd_45ACP_mk23"
	};
	sidearmWeapon[] = {
		"CUP_hgun_Mk23"
	};
	sidearmAttachments[] = {
		"cup_acc_mk23_lam_f",
		"cup_muzzle_snds_mk23",
	};
	items[] += {
		"ACE_CableTie",
		"ACE_IR_Strobe_Item"
	};
	backpackItems[] =
	{
		LIST_2("CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M"),
		LIST_2("MRAWS_HEAT_F")
	};
};

// RATS Combat Engineer
class ceng : basetrooper
{
	displayName = "Combat Engineer";
	headgear[] = {
		"H_HelmetSpecB_Sand"
	};
	vest[] = {
		"CUP_V_MBSS_PACA_RGR"
		//"rhsusf_mbav_mg"
	};
	backpack[] = {
		"B_Bergen_mcamo_F"
	};
	primaryWeapon[] =
	{
		"CUP_smg_MP7"
	};
	scope[] = {
		"CUP_optic_ZeissZPoint"
	};
	silencer[] = {
		"CUP_muzzle_snds_mp7"
	};
	items[] += {
		#if __has_include("\ctab\script_component.hpp")
			"ItemAndroidMisc",
		#endif
		"ACE_DefusalKit",
		"ACE_Clacker"
	};
	magazines[] = {
		LIST_6("CUP_40Rnd_46x30_MP7"),
		LIST_2("ACE_M14"),
		LIST_2("SmokeShellBlue"),
		"HandGrenade",
		LIST_2("ACE_Chemlight_HiBlue"),
		LIST_2("ACE_Chemlight_HiYellow"),
		LIST_2("ACE_Chemlight_UltraHiOrange"),
		"CUP_15Rnd_9x19_M9"
	};
	backpackItems[] =
	{
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_5("FirstAidKit"),
			#else
			#endif
		#else
			LIST_5("FirstAidKit"),
		#endif
		"greenmag_ammo_46x30_basic_60Rnd",
		"ACE_Wirecutter",
		"ToolKit",
		LIST_2("ACE_UAVBattery"),
		"MineDetector",
		LIST_2("APERSTripMine_Wire_Mag"),
		LIST_2("DemoCharge_Remote_Mag"),
		LIST_2("SLAMDirectionalMine_Wire_Mag")
	};
	linkedItems[] += {
		"Rangefinder"
	};
};

// RATS Intelligence, Surveillance, and Reconnaissance Operator. AKA Drone Operator
class isr : r {
	displayName = "Intel Surveillance Recon Specialist";
	items[] += {
		#if __has_include("\ctab\script_component.hpp")
			"ItemAndroidMisc",
			"ItemcTabMisc",
		#endif
	};
	linkedItems[] = {
		"ItemWatch",
		"ItemMap",
		"ItemCompass"
	};
	backpackItems[] =
	{
		LIST_5("ACE_UAVBattery")
	};

	code = "if !(local _this) exitWith {}; _this spawn mjb_arsenal_fnc_tmfSpawnFix; private _sideID = ((side _this) call BIS_fnc_sideID); private _sideTerminal = (['O_UavTerminal', 'B_UavTerminal', 'I_UavTerminal', 'C_UavTerminal', '','','','','',''] select _sideID); _this linkItem _sideTerminal;";
};

// RATS Ground Vehicle Operators
class crew : basetrooper
{
	displayName = "Crew";
	uniform[] = {
		"Tarkov_Uniforms_32",
		"Tarkov_Uniforms_60",
		"Tarkov_Uniforms_200"
	};
	headgear[] = {
		"H_HelmetCrew_I"
	};
	goggles[] =
	{
		"CUP_G_ESS_BLK_Facewrap_Black"
	};
	vest[] = {
		//"rhsgref_6b23_khaki"
		"CUP_V_PMC_CIRAS_Khaki_Veh"
	};
	primaryWeapon[] = {
		"CUP_arifle_HK416_CQB_Black"
	};
	scope[] = {
		"CUP_optic_ZeissZPoint"
	};
	magazines[] += {
		LIST_2("tsp_flashbang_m84"),
		"mjb_SmokeShellLightBlue",
		"CUP_15Rnd_9x19_M9",
		LIST_2("CUP_30Rnd_556x45_PMAG_BLACK_PULL")
	};
	backpackItems[] += {
		"Toolkit",
		LIST_3("greenmag_ammo_556x45_basic_60Rnd"),
		LIST_3("CUP_30Rnd_556x45_PMAG_BLACK_PULL")
	};
	linkedItems[] += {
		"Rangefinder"
	};
};

// RATS Helicopter Crew
class helocrew : crew
{
	displayName = "Helo Crew";
	uniform[] = {
		"Tarkov_Uniforms_420",
		"Tarkov_Uniforms_342",
		"Tarkov_Uniforms_262",
		"Tarkov_Uniforms_499"
	};
	//backpack[] = {
    //    "B_AssaultPack_rgr"
    //};
	backpackItems[] = {
		"Toolkit",
		LIST_2("greenmag_ammo_556x45_basic_60Rnd"),
		LIST_3("CUP_30Rnd_556x45_PMAG_BLACK_PULL")
    };
	headgear[] = {
		"H_PilotHelmetHeli_B"
	};
	vest[] = {
		//"rhsusf_mbav_light"
		"CUP_V_JPC_lightbelt_rngr"
	};
};

// RATS Fixed-Wing Pilots
class aircrew : basetrooper
{
	displayName = "Aircrew";
	uniform[] = {
		"U_I_pilotCoveralls"
	};
	headgear[] = {
		"H_PilotHelmetFighter_B"
	};
	hmd[] = {};
	vest[] = {};
	backpack[] = {};
	primaryWeapon[] ={};
	scope[] = {};
	bipod[] = {};
	attachment[] = {};
	silencer[] = {};
	sidearmWeapon[] = {
		"CUP_hgun_Mk23"
	};
	sidearmAttachments[] = {
		"cup_acc_mk23_lam_f",
		"cup_muzzle_snds_mk23",
	};
	items[] = {
		"ACE_IR_Strobe_Item",
		#if __has_include("\z\ace\addons\medical_engine\script_component.hpp")
			#if __has_include("\z\ace\addons\nomedical\script_component.hpp")
				LIST_2("FirstAidKit"),
			#else
				LIST_12("ACE_fieldDressing"),
				//LIST_10("ACE_packingBandage"),
				LIST_4("ACE_tourniquet"),
				LIST_2("ACE_epinephrine"),
				LIST_2("ACE_morphine"),
				LIST_2("ACE_splint"),
			#endif
		#else
			LIST_2("FirstAidKit"),
		#endif
		"ACE_Chemlight_UltraHiOrange",
		"ACE_MapTools"
	};
	magazines[] = {
		LIST_2("CUP_12Rnd_45ACP_mk23"),
		"SmokeShellOrange"
	};
	backpackItems[] = {};
	linkedItems[] += {
		"Rangefinder"
	};
};
