

class CfgMagazines
{
	class Default;
	class CA_Magazine : Default { 
		//tracersEvery = 5; // might apply to too many things, vanilla locks down base mags with te0, could make new mags that apply to every gun of a caliber and add them to arsenal
	};
	class CA_LauncherMagazine;
	class 30Rnd_556x45_Stanag : CA_Magazine {};

   // greenmag fix
	class 30Rnd_556x45_Stanag_Sand : 30Rnd_556x45_Stanag {

	};

	class 200Rnd_556x45_Box_F : CA_Magazine {
		mass = 66;
		reloadAction = "GestureReloadLIM";
	};

	// MMG Tracer magazines rounds
	class 130Rnd_338_Mag : CA_Magazine {};
	class mjb_130Rnd_338_Mag_trc_gr: 130Rnd_338_Mag {
		author = "Alien314";
		ammo = "mjb_338_NM_trc_grn";
		displayName = ".338 Norma Magnum 130Rnd Green Mixed Belt";
		displayNameShort = "Mixed/Green";
	};
	class mjb_130Rnd_338_Mag_trc_ylw : mjb_130Rnd_338_Mag_trc_gr {
		ammo = "mjb_338_NM_trc_ylw";
		displayName = ".338 Norma Magnum 130Rnd Yellow Mixed Belt";
		displayNameShort = "Mixed/Yellow";
	};


	class 30Rnd_580x42_Mag_F;
	class 100Rnd_580x42_Mag_F : 30Rnd_580x42_Mag_F {
		mass = 45;
	};
	class 30Rnd_580x42_Mag_Tracer_F;
	class mjb_30Rnd_580x42_Mag_Tracer_Red : 30Rnd_580x42_Mag_Tracer_F {
		author = "Alien314";
		ammo = "mjb_580x42_Ball_trc_red";
		displayName = "5.8 mm 30Rnd Tracer (Red) Mag";
	};
	class 100Rnd_580x42_Mag_Tracer_F : 100Rnd_580x42_Mag_F {
		mass = 45;
	};
	class mjb_100Rnd_580x42_Mag_Tracer_Red : 100Rnd_580x42_Mag_Tracer_F {
		author = "Alien314";
		ammo = "mjb_580x42_Ball_trc_red";
		displayName = "5.8 mm 100Rnd Tracer (Red) Mag";
	};
	class 100Rnd_580x42_hex_Mag_Tracer_F;
	class mjb_100Rnd_580x42_hex_Mag_Tracer_Red : 100Rnd_580x42_hex_Mag_Tracer_F {
		author = "Alien314";
		ammo = "mjb_580x42_Ball_trc_red";
		displayName = "5.8 mm 100Rnd Tracer (Red) Hex Mag";
	};
	class 100Rnd_580x42_ghex_Mag_Tracer_F;
	class mjb_100Rnd_580x42_ghex_Mag_Tracer_Red : 100Rnd_580x42_ghex_Mag_Tracer_F {
		author = "Alien314";
		ammo = "mjb_580x42_Ball_trc_red";
		displayName = "5.8 mm 100Rnd Tracer (Red) Green Hex Mag";
	};
	
	class 150Rnd_93x64_Mag : CA_Magazine {};
	class mjb_150Rnd_93x64_Mag_trc_red : 150Rnd_93x64_Mag { 
		author = "Alien314"; 
		ammo = "mjb_93x64_trc_red";
		displayName = "9.3mm 150Rnd Red Mixed Belt";
		displayNameShort = "Mixed/Red";
	};
	class mjb_150Rnd_93x64_Mag_trc_ylw : mjb_150Rnd_93x64_Mag_trc_red {
		ammo = "mjb_93x64_trc_ylw";
		displayName = "9.3mm 150Rnd Yellow Mixed Belt";
		displayNameShort = "Mixed/Yellow";
	};
	class mjb_150Rnd_93x64_Mag_trc_grn_full : 150Rnd_93x64_Mag {
		displayName = "9.3mm 150Rnd Green Tracer Belt";
		displayNameShort = "Full/Green";
		tracersEvery = 1;
		lastRoundsTracer = 0;
	};
	class mjb_150Rnd_93x64_Mag_trc_red_full : mjb_150Rnd_93x64_Mag_trc_red {
		displayName = "9.3mm 150Rnd Red Tracer Belt";
		displayNameShort = "Full/Red";
		tracersEvery = 1;
		lastRoundsTracer = 0;
	};
	class mjb_150Rnd_93x64_Mag_trc_ylw_full : mjb_150Rnd_93x64_Mag_trc_ylw {
		displayName = "9.3mm 150Rnd Yellow Tracer Belt";
		displayNameShort = "Full/Yellow";
		tracersEvery = 1;
		lastRoundsTracer = 0;
	};
	class mjb_150Rnd_93x64_Mag_trc_rbw_full : 150Rnd_93x64_Mag {
		author = "Alien314";
		ammo = "mjb_93x64_trc_wht";
		displayName = "9.3mm 150Rnd Rainbow Tracer Belt";
		displayNameShort = "Full/Rainbow";
		tracersEvery = 1;
		lastRoundsTracer = 0;
	};

#if __has_include("\z\greenmag\addons\main\script_component.hpp")

#define RND545X39(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_545x39_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND556X45(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_556x45_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND65X39(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_650x39_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND762X39(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND762X51(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_762x51_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define BELT762X51(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_beltlinked_762x51_basic"; \
		greenmag_canSpeedload = 0; \
		greenmag_needBelt = 1; \
	};
#define RND9X19(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_9x19_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND45ACP(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND65X39(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_650x39_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};
#define RND12G(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		greenmag_basicammo = "greenmag_ammo_12G_basic_1Rnd"; \
		greenmag_canSpeedload = 1; \
		greenmag_needBelt = 0; \
	};

	// fix greenmag error
	class 30Rnd_9x21_Mag;
	class 30Rnd_45ACP_Mag_SMG_01_Tracer_Red : 30Rnd_9x21_Mag {
		ammo = "B_45ACP_Ball_Red";
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd";
	};
	class 30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow : 30Rnd_9x21_Mag {
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd";
	};

	RND12G(2Rnd_12Gauge_Pellets,CA_Magazine);
	
// Quick and dirty 'Simple' sim complexity setting only Greenmag compatibility for CUP and RHS
    RND556X45(CUP_30Rnd_556x45_Stanag,CA_Magazine);
    RND556X45(CUP_25Rnd_556x45_Famas,CA_Magazine);
    RND556X45(CUP_30Rnd_556x45_AK,CA_Magazine);
    RND556X45(CUP_30Rnd_556x45_AK19_M,CA_Magazine);
    RND556X45(CUP_30Rnd_556x45_X95,CA_Magazine);
    RND556X45(CUP_35Rnd_556x45_Galil_Mag,CA_Magazine);
    RND556X45(CUP_50Rnd_556x45_Galil_Mag,CA_Magazine);
	
	RND545X39(CUP_30Rnd_545x39_AK_M,CA_Magazine);
	RND545X39(CUP_30Rnd_545x39_AK12_M,CA_Magazine);
	RND545X39(CUP_30Rnd_545x39_Fort224_M,CA_Magazine);
	RND545X39(CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M,CA_Magazine);
	
	RND762X39(CUP_30Rnd_762x39_AK47_M,CA_Magazine);
	RND762X39(CUP_30Rnd_762x39_CZ807,CA_Magazine);
	RND762X39(CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M,CA_Magazine);
	
	RND762X51(CUP_20Rnd_762x51_DMR,CA_Magazine);
	RND762X51(CUP_10Rnd_762x51_FNFAL_M,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_FNFAL_M,CA_Magazine);
	RND762X51(CUP_30Rnd_762x51_FNFAL_M,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_G3,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_HK417,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_L129_M,CA_Magazine);
	RND762X51(CUP_25Rnd_762x51_Galil_Mag,CA_Magazine);
	RND762X51(CUP_30Rnd_762x51_1_B_SCAR,CA_Magazine);
	RND762X51(CUP_30Rnd_762x51_2_B_SCAR,CA_Magazine);
	RND762X51(CUP_50Rnd_762x51_B_SCAR,CA_Magazine);
	RND762X51(CUP_5Rnd_762x51_M24,CA_Magazine);
	RND762X51(CUP_5x_22_LR_17_HMR_M,CA_Magazine);
	RND762X51(CUP_1Rnd_762x51_CZ584,CA_Magazine);
	RND762X51(CUP_10Rnd_762x51_CZ750,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_B_M110,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_B_SCAR,CA_Magazine);
	RND762X51(CUP_20Rnd_762x51_CZ805B,CA_Magazine);
	
	class CUP_5Rnd_762x54_Mosin_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x54_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_10Rnd_762x54_SVD_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_762x54_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_50Rnd_UK59_762x54R_Tracer: CA_Magazine
	{
		greenmag_ammo = "greenmag_beltlinked_762x54_tracer";
		greenmag_basicammo = "greenmag_beltlinked_762x54_basic";
	};
	
	RND9X19(CUP_10Rnd_9x19_Compact,CA_Magazine);
	RND9X19(CUP_15Rnd_9x19_M9,CA_Magazine);
	RND9X19(CUP_17Rnd_9x19_M17_Coyote,CA_Magazine);
	RND9X19(CUP_17Rnd_9x19_glock17,CA_Magazine);
	RND9X19(CUP_16Rnd_9x19_cz75,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19_MP5,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19_EVO,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19_UZI,CA_Magazine);
	RND9X19(CUP_72Rnd_9x19_UZI_M,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19_Vityaz,CA_Magazine);
	RND9X19(CUP_30Rnd_9x19AP_Vityaz,CA_Magazine);
	RND9X19(CUP_32Rnd_9x19_TEC9,CA_Magazine);
	RND9X19(CUP_13Rnd_9x19_Browning_HP,CA_Magazine);
	RND9X19(CUP_18Rnd_9x19_Phantom,CA_Magazine);
	
	RND45ACP(CUP_30Rnd_45ACP_M3A1_M,CA_Magazine);
	RND45ACP(CUP_30Rnd_45ACP_MAC10_M,CA_Magazine);
	RND45ACP(CUP_12Rnd_45ACP_mk23,CA_Magazine);
	RND45ACP(CUP_6Rnd_45ACP_M,CA_Magazine);
	RND45ACP(CUP_7Rnd_45ACP_1911,CA_Magazine);
	
	class CUP_10Rnd_B_765x17_Ball_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_765x17_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_10Rnd_127x99_M107: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_127x99_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_5Rnd_127x99_as50_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_127x99_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_5Rnd_127x108_KSVK_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_127x108_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;		
	};
	class CUP_5Rnd_762x67_G22: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_5Rnd_762x67_M2010_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_5Rnd_TE1_Red_Tracer_762x67_M2010_M: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
	class CUP_5Rnd_86x70_L115A1: CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_338_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};

	RND12G(CUP_5Rnd_B_Saiga12_Buck_00,CA_Magazine);
	RND12G(CUP_5Rnd_B_Saiga12_Slug,CA_Magazine);
	RND12G(CUP_1Rnd_12Gauge_Pellets_No00_Buck,CA_Magazine);
	RND12G(CUP_1Rnd_12Gauge_Slug,CA_Magazine);
	RND12G(CUP_20Rnd_B_AA12_Buck_00,CA_Magazine);
	RND12G(CUP_20Rnd_B_AA12_Slug,CA_Magazine);
	RND12G(CUP_20Rnd_B_AA12_HE,CA_Magazine);

// 300 WM: ACE_762x67_Ball_Mk248_Mod_1, ACE_762x67_Ball_Mk248_Mod_0, ACE_762x67_Ball_Berger_Hybrid_OTM
// ACE_762x54_Ball_7T2
// ACE_762x51_Ball_Subsonic, ACE_762x51_Ball_Mk319_Mod_0, ACE_762x51_Ball_Mk316_Mod_0, ACE_762x51_Ball_M993_AP, ACE_762x51_Ball_M118LR
// ACE_65x47_Ball_Scenar, ACE_65x39_Caseless_Tracer_Dim, ACE_65x39_Caseless_green_Tracer_Dim, ACE_65_Creedmor_Ball
// ACE_580x42_DBP88_Ball
// ACE_556x45_Ball_Mk318, ACE_556x45_Ball_Mk262, ACE_556x45_Ball_M995_AP
// ACE_408_Ball
// ACE_338_Ball_API526, ACE_338_Ball
// ACE_127x99_Ball_AMAX, ACE_127x99_API
	
	// RHS
#if __has_include("\rhsafrf\addons\rhs_c_weapons\script_component.hpp")
	class rhs_mag_30Rnd_556x45_M855A1_Stanag: 30Rnd_556x45_Stanag {};
	
	RND545X39(rhs_30Rnd_545x39_AK,CA_Magazine);
	class rhs_30Rnd_545x39_7N6_AK: rhs_30Rnd_545x39_AK {};	
	class rhs_30Rnd_762x39mm: rhs_30Rnd_545x39_7N6_AK
	{
		greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
	};
	class rhs_20rnd_9x39mm_SP5: rhs_30Rnd_762x39mm
	{
		greenmag_basicammo = "greenmag_ammo_9x39_ball_1Rnd";
	};
	class rhs_100Rnd_762x54mmR: rhs_30Rnd_545x39_7N6_AK
	{
		greenmag_basicammo = "greenmag_beltlinked_762x54_basic";
		greenmag_canSpeedload = 0;
		greenmag_needBelt = 1;
	};
	class rhs_10Rnd_762x54mmR_7N1: rhs_30Rnd_545x39_7N6_AK
	{
		greenmag_basicammo = "greenmag_ammo_762x54_basic_1Rnd";
	};	
	RND762X51(rhs_mag_20Rnd_762x51_m80_fnfal,CA_Magazine);
	RND762X51(rhs_mag_20Rnd_SCAR_762x51_m80_ball,CA_Magazine);
	RND9X19(rhs_mag_9x19_17,CA_Magazine);
	class rhs_mag_9x18_12_57N181S: rhs_mag_9x19_17
	{
		greenmag_basicammo = "greenmag_ammo_9x18_basic_1Rnd";
	};
	class rhs_18rnd_9x21mm_7N28: rhs_mag_9x19_17
	{
		greenmag_basicammo = "greenmag_ammo_9x21_basic_1Rnd";
	};
	class rhs_5Rnd_338lapua_t5000: rhs_30Rnd_762x39mm
	{
		greenmag_basicammo = "greenmag_ammo_338_basic_1Rnd";
	};

	// GREF
	#if __has_include("\rhsgref\addons\rhsgref_c_weapons\script_component.hpp")
		RND556X45(rhsgref_30rnd_556x45_m21,CA_Magazine);
		RND556X45(rhsgref_30rnd_556x45_vhs2,CA_Magazine);
		
		
		RND45ACP(rhsgref_30rnd_1143x23_M1911B_SMG,CA_Magazine);
		class rhs_mag_762x25_8: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_762x25_ball_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;		
		};
		class rhs_mag_6x8mm_mhp: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_762x25_ball_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;		
		};
		class rhsgref_20rnd_765x17_vz61: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_765x17_ball_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;		
		};
		RND762X51(rhsgref_5Rnd_792x57_kar98k,CA_Magazine);
		class rhsgref_296Rnd_792x57_SmE_belt: CA_Magazine
		{
			greenmag_basicammo = "greenmag_beltlinked_762x51_basic";
			greenmag_canSpeedload = 0;
			greenmag_needBelt = 1;		
		};
		class rhsgref_50Rnd_792x57_SmE_drum: CA_Magazine
		{
			greenmag_basicammo = "greenmag_beltlinked_762x51_basic";
			greenmag_canSpeedload = 0;
			greenmag_needBelt = 1;		
		};
		class rhsgref_25Rnd_792x33_SmE_StG: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;
		};
		class rhsgref_30Rnd_792x33_SmE_StG: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_762x39_basic_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;
		};
		class rhsgref_5Rnd_762x54_m38: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_762x54_basic_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;
		};
		class rhsgref_8Rnd_762x63_M2B_M1rifle: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;
		};
	#else
	#endif
	
	// USF
	#if __has_include("\rhsusf\addons\rhsusf_c_weapons\script_component.hpp")
		class rhsusf_100Rnd_556x45_soft_pouch: rhs_mag_30Rnd_556x45_M855A1_Stanag
		{
			greenmag_ammo = "greenmag_beltlinked_556x45_basic";
			greenmag_basicammo = "greenmag_beltlinked_556x45_basic";
			greenmag_canSpeedload = 0;
			greenmag_needBelt = 1;
		};
		RND762X51(rhsusf_20Rnd_762x51_m118_special_Mag,CA_Magazine);
		RND762X51(rhsusf_5Rnd_762x51_m118_special_Mag,CA_Magazine);
		RND762X51(rhsusf_10Rnd_762x51_m118_special_Mag,CA_Magazine);
		RND762X51(rhsusf_50Rnd_762x51,CA_Magazine);
		class rhsusf_mag_40Rnd_46x30_AP: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_46x30_basic_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;		
		};
		class rhsusf_mag_40Rnd_46x30_FMJ: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_46x30_basic_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;		
		};		
		class rhsusf_mag_40Rnd_46x30_JHP: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_46x30_basic_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;		
		};	
		RND9X19(rhsusf_mag_17Rnd_9x19_FMJ,CA_Magazine);
		class 10Rnd_RHS_50BMG_Box: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_127x99_basic_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;		
		};
		class rhsusf_5Rnd_300winmag_xm2010: CA_Magazine
		{
			greenmag_basicammo = "greenmag_ammo_303_ball_1Rnd";
			greenmag_canSpeedload = 1;
			greenmag_needBelt = 0;
		};	
		RND45ACP(rhsusf_mag_7x45acp_MHP,CA_Magazine);

		RND12G(rhsusf_5Rnd_00Buck,CA_Magazine);
		
		class rhs_mag_30Rnd_556x45_M855A1_EPM;
		class rhs_mag_30Rnd_556x45_M855A1_PMAG;
		class rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan;
		class rhs_mag_30Rnd_556x45_Mk318_Stanag_Ranger;
		class rhs_mag_30Rnd_556x45_Mk318_Stanag_Pull;
		
		/*/ Tier 1
		class Tier1_30Rnd_556x45_M855A1_EMag;
		RND762X51(Tier1_20Rnd_762x51_M118_Special_SR25_Mag,CA_Magazine);
		RND65X39(Tier1_20Rnd_65x48_Creedmoor_SR25_Mag,Tier1_20Rnd_762x51_M118_Special_SR25_Mag); // no cal
		RND762X39(Tier1_30Rnd_762x35_300BLK_EMag,Tier1_30Rnd_556x45_M855A1_EMag); // no cal
		
		RND762X39(Tier1_30Rnd_762x35_300BLK_EPM,rhs_mag_30Rnd_556x45_M855A1_EPM); // no cal
		RND762X39(Tier1_30Rnd_762x35_300BLK_PMAG,rhs_mag_30Rnd_556x45_M855A1_PMAG);
		RND762X39(Tier1_30Rnd_762x35_300BLK_PMAG_Tan,rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan);	
		RND762X39(Tier1_30Rnd_762x35_300BLK_RNBT_EPM,rhs_mag_30Rnd_556x45_M855A1_EPM);	
		RND762X39(Tier1_30Rnd_762x35_300BLK_RNBT_PMAG,rhs_mag_30Rnd_556x45_M855A1_PMAG);
		RND762X39(Tier1_30Rnd_762x35_300BLK_RNBT_PMAG_Tan,rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan);	
		RND762X39(Tier1_30Rnd_762x35_300BLK_RNBT_Stanag_Ranger,rhs_mag_30Rnd_556x45_Mk318_Stanag_Ranger);
		RND762X39(Tier1_30Rnd_762x35_300BLK_SMK_EPM,rhs_mag_30Rnd_556x45_M855A1_EPM);
		RND762X39(Tier1_30Rnd_762x35_300BLK_SMK_PMAG,rhs_mag_30Rnd_556x45_M855A1_PMAG);
		RND762X39(Tier1_30Rnd_762x35_300BLK_SMK_PMAG_Tan,rhs_mag_30Rnd_556x45_M855A1_PMAG_Tan);
		RND762X39(Tier1_30Rnd_762x35_300BLK_SMK_Stanag_Ranger,rhs_mag_30Rnd_556x45_Mk318_Stanag_Ranger);	
		RND762X39(Tier1_30Rnd_762x35_300BLK_Stanag,rhs_mag_30Rnd_556x45_M855A1_Stanag);	
		RND762X39(Tier1_30Rnd_762x35_300BLK_Stanag_Pull,rhs_mag_30Rnd_556x45_Mk318_Stanag_Pull);	
		RND762X39(Tier1_30Rnd_762x35_300BLK_Stanag_Ranger,rhs_mag_30Rnd_556x45_Mk318_Stanag_Ranger);
		
		BELT762X51(Tier1_100Rnd_762x51_Belt_M61_AP,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_100Rnd_762x51_Belt_M62_Tracer,30Rnd_556x45_Stanag);	
		BELT762X51(Tier1_100Rnd_762x51_Belt_M80,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_100Rnd_762x51_Belt_M80A1_EPR,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_100Rnd_762x51_Belt_M82_Blank,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_100Rnd_762x51_Belt_M993_AP,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_250Rnd_762x51_Belt_M61_AP,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_250Rnd_762x51_Belt_M62_Tracer,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_250Rnd_762x51_Belt_M80,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_250Rnd_762x51_Belt_M80A1_EPR,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_250Rnd_762x51_Belt_M82_Blank,30Rnd_556x45_Stanag);
		BELT762X51(Tier1_250Rnd_762x51_Belt_M993_AP,30Rnd_556x45_Stanag);
		
		RND9X19(Tier1_15Rnd_9x19_FMJ,CA_Magazine);
		RND9X19(Tier1_17Rnd_9x19_P320_FMJ,CA_Magazine);
		RND9X19(Tier1_20Rnd_9x19_FMJ,CA_Magazine);
		RND9X19(Tier1_21Rnd_9x19_P320_FMJ,CA_Magazine);
		RND45ACP(Tier1_15Rnd_40SW_FMJ,CA_Magazine); // no cal
		RND45ACP(Tier1_20Rnd_40SW_FMJ,CA_Magazine);*/
	#else
	#endif
#else

#endif
	
	// 3CB
	
	// g3
	// m14
	// fn fal
	// sten
	// mp5
	// 20rnd DMR
	// Enfield
#else

#endif

// cup mags weight fixes
	class CUP_100Rnd_556x45_BetaCMag : CUP_30Rnd_556x45_Stanag {
		mass = 45;
	};
	class CUP_200Rnd_TE4_Green_Tracer_556x45_M249 : CA_Magazine {
		mass = 66;
	};

	class CUP_64Rnd_9x19_Bizon_M : CA_Magazine {
		mass = 20;
	};
	class CUP_64Rnd_Green_Tracer_9x19_Bizon_M : CA_Magazine {
		mass = 20;
	};
	class CUP_64Rnd_Red_Tracer_9x19_Bizon_M : CA_Magazine {
		mass = 20;
	};
	class CUP_64Rnd_White_Tracer_9x19_Bizon_M : CA_Magazine {
		mass = 20;
	};
	class CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M : CA_Magazine {
		mass = 20;
	};
	class CUP_30Rnd_9x39_SP5_VIKHR_M : CA_Magazine {
		mass = 14;
	};

	class mjb_cup_64Rnd_46x30_Bizon_M : CUP_64Rnd_9x19_Bizon_M {
		ammo = "CUP_B_46x30_Ball";
		greenmag_ammo = "greenmag_ammo_46x30_ball_1Rnd";
		greenmag_basicammo = "greenmag_ammo_46x30_basic_1Rnd";
		initSpeed = 725;
		descriptionShort = "Caliber:4.6x30mm <br/>Rounds: 64 <br/>Used in: Bizon PP-19";
		displayname = "4.6mm 64Rnd Bizon Magazine";
	};

	class CUP_SMAW_HEDP_M : CA_LauncherMagazine {
		mass = 54;
	};

	class CUP_SMAW_HEAA_M : CUP_SMAW_HEDP_M {
		displayname = "Mk 6 Mod 0 (AA/Anti-Armor) Rocket";
		mass = 60;
	};

	class CUP_SMAW_NE_M : CUP_SMAW_HEDP_M {
		displayname = "Mk 80 Mod 0 (NE/Thermobaric) Rocket";
		mass = 100;
	};

	// backpack disposable inconsistency fix
	class CUP_M136_M : CA_LauncherMagazine {
		mass = 0; // squeak two at4 into kitbag
	};
	class CUP_M72A6_M : CA_LauncherMagazine {
		descriptionshort = "Range: 0 - 200 m<br/>Type: Anti-Tank<br/>Used in: M72A5";
		displayname = "M72A5 (Anti-Tank) Rocket";
		mass = 0;
	};
	class CUP_RPG18_M : CA_LauncherMagazine {
		mass = 0;
	};
	class CUP_RPG26_M : CA_LauncherMagazine {
		mass = 0;
	};
	class CUP_RSHG2_M : CA_LauncherMagazine {
		mass = 0;
	};

	// M72A8
	class mjb_M72A10_M : CUP_M72A6_M {
		ammo = "mjb_R_M72A10_MP";
		descriptionshort = "Range: 0 - 200 m<br/>Type: Dual Purpose<br/>Used in: M72A8";
		displayname = "M72A8 (HEDP) Rocket";
		displaynameshort = "HEDP";
		//initSpeed = 120;
	};
	// M72A10
	class mjb_M72A10_HE_M : CUP_M72A6_M {
		ammo = "mjb_R_M72A10_HE";
		descriptionshort = "Range: 0 - 200 m<br/>Type: Anti-Structure/Frag<br/>Used in: M72A10";
		displayname = "M72A10 (HE) Rocket";
		displaynameshort = "HE";
		//initSpeed = 120;
	};
	
	/*/ Bizon class name fix, magwell at bottom
	class CUP_64Rnd_9x18_Bizon_M : CUP_64Rnd_9x19_Bizon_M
	{scope = 2};
	class CUP_64Rnd_Green_Tracer_9x18_Bizon_M : CUP_64Rnd_Green_Tracer_9x19_Bizon_M
	{scope = 2};
	class CUP_64Rnd_Red_Tracer_9x18_Bizon_M : CUP_64Rnd_Red_Tracer_9x19_Bizon_M
	{scope = 2};
	class CUP_64Rnd_White_Tracer_9x18_Bizon_M : CUP_64Rnd_White_Tracer_9x19_Bizon_M
	{scope = 2};
	class CUP_64Rnd_Yellow_Tracer_9x18_Bizon_M : CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M
	{scope = 2};*/

	//class rhs_rpg7_PG7V_mag;
	//class rhs_rpg7_PG7VL_mag;
	// globmob compat tweak
	//class gm_1Rnd_40mm_heat_pg7v_rpg7 : rhs_rpg7_PG7V_mag {};
	//class gm_1Rnd_40mm_heat_pg7vl_rpg7 : rhs_rpg7_PG7VL_mag {};
#define magPistol65X25(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		ammo = "mjb_65x25_CBJ"; \
        initSpeed = 720;\
        lastRoundsTracer=0;\
        tracersEvery=0;\
		displayNameMFDFormat= "APDS";

#define magSMG65X25(NAME,PARENT) \
	class ##NAME## : ##PARENT## \
	{ \
		ammo = "mjb_65x25_CBJ"; \
        initSpeed = 855;\
        lastRoundsTracer=0;\
        tracersEvery=0;\
		displayNameMFDFormat= "APDS"; \
		descriptionShort = "6.5x25mm Armor Piercing Discarding Sabot<br />Rounds: 30<br />Used in: 9mm Parabellum barrel converted weapons.";

	magPistol65X25(mjb_13Rnd_65x25_Browning_HP,CUP_13Rnd_9x19_Browning_HP)
		displayName= "9mm 13rnd Browning HP CBJ APDS Mag";
		descriptionShort = "6.5x25mm Armor Piercing Discarding Sabot<br />Rounds: 13<br />Used in: Browning HP";
	};
	magPistol65X25(mjb_15Rnd_65x25_M9,CUP_15Rnd_9x19_M9)
		displayName= "9mm 15rnd M9 CBJ APDS Mag";
		descriptionShort = "6.5x25mm Armor Piercing Discarding Sabot<br />Rounds: 15<br />Used in: M9";
	};
	magPistol65X25(mjb_16Rnd_65x25_cz75,CUP_16Rnd_9x19_cz75)
		displayName= "9mm 16rnd CZ 75 CBJ APDS Mag";
		descriptionShort = "6.5x25mm Armor Piercing Discarding Sabot<br />Rounds: 16<br />Used in: CZ 75";
	};
	class CUP_17Rnd_9x19_M17_Black;
	magPistol65X25(mjb_17Rnd_65x25_M17,CUP_17Rnd_9x19_M17_Black)
		displayName= "9mm 17rnd M17 CBJ APDS Mag";
		descriptionShort = "6.5x25mm Armor Piercing Discarding Sabot<br />Rounds: 17<br />Used in: M17";
	};
	class CUP_21Rnd_9x19_M17_Black;
	magPistol65X25(mjb_21Rnd_65x25_M17,CUP_21Rnd_9x19_M17_Black)
		displayName= "9mm 21rnd M17 CBJ APDS Mag";
		descriptionShort = "6.5x25mm Armor Piercing Discarding Sabot<br />Rounds: 21<br />Used in: M17";
	};
	magPistol65X25(mjb_17Rnd_65x25_glock17,CUP_17Rnd_9x19_glock17)
		displayName= "9mm 17rnd G17 CBJ APDS Mag";
		descriptionShort = "6.5x25mm Armor Piercing Discarding Sabot<br />Rounds: 17<br />Used in: G17";
	};
	magSMG65X25(mjb_30Rnd_65x25_Vityaz,CUP_30Rnd_9x19_Vityaz)
		displayName= "9mm 30rnd Vityaz CBJ APDS Mag";
	};
	magSMG65X25(mjb_30Rnd_65x25_MP5,CUP_30Rnd_9x19_MP5)
		displayName= "9mm 30rnd MP5 CBJ APDS Mag";
	};
	magSMG65X25(mjb_30Rnd_65x25_EVO,CUP_30Rnd_9x19_EVO)
		displayName= "9mm 30rnd CBJ APDS Mag";
	};

	// IR Tracer, ammo = "ACE_B_762x51_Tracer_Dim"; ammo = "ACE_B_556x45_Ball_Tracer_Dim";
	class mjb_150Rnd_93x64_Mag_trc_IR : 150Rnd_93x64_Mag {
		ammo = "mjb_B_93x64_Ball_Tracer_Dim";
		displayName = "9.3mm 150Rnd IR Mixed Belt";
		displayNameShort = "Mixed/IR";
	};
	class mjb_130Rnd_338_Mag_trc_IR : 130Rnd_338_Mag {
		ammo = "mjb_338_NM_trc_IR";
		displayName = ".338 Norma Magnum 130Rnd IR Mixed Belt";
		displayNameShort = "Mixed/IR";
	};

#define IRMAG(CLASS,BASE,AMMO,NAME) class BASE; \
	class CLASS : BASE { \
		ammo = QUOTE(AMMO); \
		displayName = QUOTE(NAME); \
		displayNameShort = "IR Tracer"; \
	}
	IRMAG(mjb_CUP_200Rnd_TE4_IR_Tracer_556x45_M249,CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249,ACE_B_556x45_Ball_Tracer_Dim,5.56mm 200Rnd M249 (IR-DIM TE4) Box);
	IRMAG(mjb_CUP_100Rnd_TE4_IR_Tracer_556x45_M249,CUP_100Rnd_TE4_Yellow_Tracer_556x45_M249,ACE_B_556x45_Ball_Tracer_Dim,5.56mm 100Rnd M249 (IR-DIM TE4) Pouch);

	class CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag;
	class mjb_CUP_100Rnd_TE1_IR_Tracer_556x45_BetaCMag : CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag {
		ammo = "ACE_B_556x45_Ball_Tracer_Dim";
		displayName = "5.56mm 100Rnd G36 (IR-DIM) Beta-C Mag";
		displayNameShort = "IR Tracer";
	};
	class CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag_ar15;
	class mjb_CUP_100Rnd_TE1_IR_Tracer_556x45_BetaCMag_ar15 : CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag_ar15 {
		ammo = "ACE_B_556x45_Ball_Tracer_Dim";
		displayName = "5.56mm 100Rnd Beta-C (IR-DIM) Mag";
		displayNameShort = "IR Tracer";
	};

	class CUP_60Rnd_556x45_SureFire_Tracer_Yellow;
	class mjb_CUP_60Rnd_556x45_SureFire_Tracer_IR : CUP_60Rnd_556x45_SureFire_Tracer_Yellow {
		ammo = "ACE_B_556x45_Ball_Tracer_Dim";
		displayName = "5.56mm 60Rnd Surefire (IR-DIM) Mag";
		displayNameShort = "IR Tracer";
	};

	// 7.62
	class CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M;
	class mjb_CUP_100Rnd_TE4_LRT4_IR_Tracer_762x51_Belt_M : CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M {
		ammo = "ACE_B_762x51_Tracer_Dim";
		displayName = "7.62mm 100Rnd M240 (IR-DIM TE4) Box";
		displayNameShort = "IR Tracer";
	};
	IRMAG(mjb_CUP_120Rnd_TE4_LRT4_IR_Tracer_762x51_Belt_M,CUP_120Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M,ACE_B_762x51_Tracer_Dim,7.62mm 120Rnd MG-3 (IR-DIM TE4) Box);

   
	IRMAG(mjb_CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_IR_M,CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M,mjb_CUP_B_762x54_Ball_IR,7.62mm 100Rnd PKM (IR-DIM TE4) Box);

	class mjb_CUP_95Rnd_TE4_LRT4_IR_Tracer_545x39_RPK_M : CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M {
		ammo = "mjb_CUP_B_545x39_Ball_IR";
		displayName = "5.45mm 95Rnd RPK (IR-DIM TE4) Drum";
		descriptionShort = "Caliber: 5.45x39 mm <br/>Rounds: 95  <br/>Used in: RPK-74";
		greenmag_basicammo = "greenmag_ammo_545x39_basic_1Rnd";
		initSpeed = 880;
		mass = 23;
	};
	class mjb_CUP_95Rnd_TE4_LRT4_Red_Tracer_545x39_RPK_M : mjb_CUP_95Rnd_TE4_LRT4_IR_Tracer_545x39_RPK_M {
		ammo = "CUP_B_545x39_Ball_Tracer_Red";
		displayName = "5.45mm 95Rnd RPK (Red TE4) Drum";
	};
	class mjb_CUP_95Rnd_TE4_LRT4_Yellow_Tracer_545x39_RPK_M : mjb_CUP_95Rnd_TE4_LRT4_IR_Tracer_545x39_RPK_M {
		ammo = "CUP_B_545x39_Ball_Tracer_Yellow";
		displayName = "5.45mm 95Rnd RPK (Yellow TE4) Drum";
	};
	class mjb_CUP_95Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M : mjb_CUP_95Rnd_TE4_LRT4_IR_Tracer_545x39_RPK_M {
		ammo = "CUP_B_545x39_Ball_Tracer_Green";
		displayName = "5.45mm 95Rnd RPK (Green TE4) Drum";
	};


	class mjb_CUP_100Rnd_TE4_IR_Tracer_545x39 : mjb_CUP_100Rnd_TE4_IR_Tracer_556x45_M249 {
		ammo = "mjb_CUP_B_545x39_Ball_IR";
		displayName = "5.45mm 100Rnd RPK SPU (IR-DIM TE4) Pouch";
		descriptionShort = "Caliber: 5.45x39 mm <br/>Rounds: 100  <br/>Used in: RPK SPU";
	};

	// Vehicle Magazines
	class VehicleMagazine;
	class CUP_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M : VehicleMagazine {
		displayName = "M789 12-Pak Red";
	};
	class CUP_1200Rnd_TE1_Green_Tracer_30x113mm_M789_HEDP_M : CUP_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M {displayName = "M789 12-Pak Green";};
	class CUP_1200Rnd_TE1_Yellow_Tracer_30x113mm_M789_HEDP_M : CUP_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M {displayName = "M789 12-Pak Yellow";};
	class CUP_1200Rnd_TE1_White_Tracer_30x113mm_M789_HEDP_M : CUP_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M {displayName = "M789 12-Pak White";};
	class mjb_300Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M : CUP_1200Rnd_TE1_Red_Tracer_30x113mm_M789_HEDP_M {
		displayName = "M789 Combo-Pak Red";
		count = 300;
	};
	class mjb_300Rnd_TE1_Green_Tracer_30x113mm_M789_HEDP_M : CUP_1200Rnd_TE1_Green_Tracer_30x113mm_M789_HEDP_M {
		displayName = "M789 Combo-Pak Green";
		count = 300;
	};
	class mjb_300Rnd_TE1_Yellow_Tracer_30x113mm_M789_HEDP_M : CUP_1200Rnd_TE1_Yellow_Tracer_30x113mm_M789_HEDP_M {
		displayName = "M789 Combo-Pak Yellow";
		count = 300;
	};
	class mjb_300Rnd_TE1_White_Tracer_30x113mm_M789_HEDP_M : CUP_1200Rnd_TE1_White_Tracer_30x113mm_M789_HEDP_M {
		displayName = "M789 Combo-Pak White";
		count = 300;
	};
	

#if __has_include("\rhsafrf\addons\rhs_c_weapons\script_component.hpp")
	class rhs_VOG25;
	class mjb_VOGMDP : rhs_vog25 {
		ammo = "mjb_g_VOGMDP";
		displayName = "VOG-MDP";
		descriptionshort = "Type: HEDP Grenade Round<br />Caliber: 40 mm<br />Rounds: 1<br />Used in: GP25";
		displaynameshort = "HEDP Grenade";
	};
	class mjb_slog : rhs_vog25 {
		ammo = "mjb_g_slog";
		displayName = "SLOG";
		descriptionshort = "Type: Solid Slug <br />Caliber: 40 mm<br />Rounds: 1<br />Used in: GP25";
		displaynameshort = "Slug";
	};
#else
	class CUP_1Rnd_HE_GP25_M;
	class mjb_VOGMDP : CUP_1Rnd_HE_GP25_M {
		ammo = "mjb_G_40mm_HEDP";
		displayName = "VOG-MDP";
		descriptionshort = "Type: HEDP Grenade Round<br />Caliber: 40 mm<br />Rounds: 1<br />Used in: GP25";
		displaynameshort = "HEDP Grenade";
	};
	class mjb_slog : CUP_1Rnd_HE_GP25_M {
		ammo = "mjb_g_slog";
		displayName = "SLOG";
		descriptionshort = "Type: Solid Slug <br />Caliber: 40 mm<br />Rounds: 1<br />Used in: GP25";
		displaynameshort = "Slug";
	};
#endif
	class 1Rnd_HE_Grenade_shell;
	// west ver slug
	class mjb_blug : 1Rnd_HE_Grenade_shell {
		ammo = "mjb_g_blug";
		displayName = "Slug";
		descriptionshort = "Type: Solid Slug <br />Caliber: 40 mm<br />Rounds: 1<br />Used in: EGLM, M203";
		displaynameshort = "Slug";
	};//*/

	class mjb_M576buck : 1Rnd_HE_Grenade_shell {
		ammo = "mjb_g_M576buck";
		displayName = "M576 #00 Buckshot";
		descriptionshort = "Type: #00 Buckshot <br />Caliber: 40 mm<br />Rounds: 1<br />Used in: EGLM, M203";
		displayNameShort = "#00 Buckshot";
		initSpeed = 269;
		picture = "\A3\Weapons_F\Data\UI\gear_UGL_Flare_CA.paa";
	};

	class CUP_1Rnd_HEDP_M203 : 1Rnd_HE_Grenade_shell {
		ammo = "mjb_G_40mm_HEDP";
		displaynameshort = "HEDP Grenade";
	};

	class 1Rnd_Smoke_Grenade_shell;
	class mjb_1Rnd_impactSmonk : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkWhite";
		descriptionShort = "Type: Smoke Round - Impact, White<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (White)";
		displayNameShort = "Wht Imp. Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_white_CA.paa";
	};
	class mjb_1Rnd_impactSmonkBlue : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkBlue";
		descriptionShort = "Type: Smoke Round - Impact, Blue<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (Blue)";
		displayNameShort = "Blu Imp. Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_blue_CA.paa";
	};
	class mjb_1Rnd_impactSmonkGreen : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkGreen";
		descriptionShort = "Type: Smoke Round - Impact, Green<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (Green)";
		displayNameShort = "Grn Imp. Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_green_CA.paa";
	};
	class mjb_1Rnd_impactSmonkOrange : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkOrange";
		descriptionShort = "Type: Smoke Round - Impact, Orange<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (Orange)";
		displayNameShort = "Orng Imp. Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_orange_CA.paa";
	};
	class mjb_1Rnd_impactSmonkPurple : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkPurple";
		descriptionShort = "Type: Smoke Round - Impact, Purple<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (Purple)";
		displayNameShort = "Prpl Imp. Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_purple_CA.paa";
	};
	class mjb_1Rnd_impactSmonkRed : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkRed";
		descriptionShort = "Type: Smoke Round - Impact, Red<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (Red)";
		displayNameShort = "Red Imp. Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_red_CA.paa";
	};
	class mjb_1Rnd_impactSmonkYellow : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkYellow";
		descriptionShort = "Type: Smoke Round - Impact, Yellow<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (Yellow)";
		displayNameShort = "Ylw Imp. Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_yellow_CA.paa";
	};
	class mjb_1Rnd_impactSmonkLightBlue : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkLightBlue";
		descriptionShort = "Type: Smoke Round - Impact, Light Blue<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (Light Blue)";
		displayNameShort = "LBlu Imp. Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_blue_CA.paa";
	};
	class mjb_1Rnd_impactSmonkPink : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_impactSmonkPink";
		descriptionShort = "Type: Smoke Round - Impact, Pink<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Impact (Pink)";
		displayNameShort = "Pink Imp. Smoke";
		//picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_yellow_CA.paa";
	};

	class mjb_1Rnd_SmonkLightBlue : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_smokeLightBlue";
		descriptionShort = "Type: Smoke Round - Light Blue<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Round (Light Blue)";
		displayNameShort = "LBlu Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_blue_CA.paa";
	};
	class mjb_1Rnd_SmonkPink : 1Rnd_Smoke_Grenade_shell {
		ammo = "mjb_g_smokePink";
		descriptionShort = "Type: Smoke Round - Pink<br />Rounds: 1<br />Used in: EGLM, 3GL";
		displayName = "Smoke Round (Pink)";
		displayNameShort = "Pink Smoke";
		picture = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_red_CA.paa";
	};

	class SmokeShell;
	class SmokeShellBlue;
	class SmokeShellRed;
	class SmokeShellGreen;
	class SmokeShellYellow;
	class SmokeShellOrange;
	class SmokeShellPurple;

	class mjb_SmokeShellLightBlue : SmokeShell {
		ammo = "mjb_SmokeShellLightBlue";
		descriptionShort = "Type: Smoke Grenade - Light Blue<br />Rounds: 1<br />Used in: Hand";
		displayName = "M18 Smoke Grenade (Light Blue)";
		displayNameShort = "Light Blue Smoke";
		model = "\A3\Weapons_f\ammo\smokegrenade_blue";
		picture = "\A3\Weapons_f\data\ui\gear_smokegrenade_blue_ca.paa";
	};

	class mjb_SmokeShellPink : SmokeShell {
		ammo = "mjb_SmokeShellPink";
		descriptionShort = "Type: Smoke Grenade - Pink<br />Rounds: 1<br />Used in: Hand";
		displayName = "M18 Smoke Grenade (Pink)";
		displayNameShort = "Pink Smoke";
		model = "\A3\Weapons_f\ammo\smokegrenade_red";
		picture = "\A3\Weapons_f\data\ui\gear_smokegrenade_red_ca.paa";
	};

	class mjb_SmokeShellBurst : SmokeShell {
		ammo = "mjb_SmokeShellBurst";
		descriptionShort = "Type: Bursting Smoke Grenade - White<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (White)";
		displayNameShort = "Wht Brst Smoke";
	};

	class mjb_SmokeShellBurstBlue : SmokeShellBlue {
		ammo = "mjb_SmokeShellBurstBlue";
		descriptionShort = "Type: Bursting Smoke Grenade - Blue<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (Blue)";
		displayNameShort = "Blue Brst Smoke";
	};
	class mjb_SmokeShellBurstRed : SmokeShellRed {
		ammo = "mjb_SmokeShellBurstRed";
		descriptionShort = "Type: Bursting Smoke Grenade - Red<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (Red)";
		displayNameShort = "Red Brst Smoke";
	};
	class mjb_SmokeShellBurstGreen : SmokeShellGreen {
		ammo = "mjb_SmokeShellBurstGreen";
		descriptionShort = "Type: Bursting Smoke Grenade - Green<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (Green)";
		displayNameShort = "Grn Brst Smoke";
	};
	class mjb_SmokeShellBurstOrange : SmokeShellOrange {
		ammo = "mjb_SmokeShellBurstOrange";
		descriptionShort = "Type: Bursting Smoke Grenade - Orange<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (Orange)";
		displayNameShort = "Orng Brst Smoke";
	};
	class mjb_SmokeShellBurstPurple : SmokeShellPurple {
		ammo = "mjb_SmokeShellBurstPurple";
		descriptionShort = "Type: Bursting Smoke Grenade - Purple<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (Purple)";
		displayNameShort = "Prpl Brst Smoke";
	};
	class mjb_SmokeShellBurstYellow : SmokeShellYellow {
		ammo = "mjb_SmokeShellBurstYellow";
		descriptionShort = "Type: Bursting Smoke Grenade - Yellow<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (Yellow)";
		displayNameShort = "Ylw Brst Smoke";
	};
	class mjb_SmokeShellBurstLightBlue : mjb_SmokeShellLightBlue {
		ammo = "mjb_SmokeShellBurstLightBlue";
		descriptionShort = "Type: Bursting Smoke Grenade - Light Blue<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (Light Blue)";
		displayNameShort = "L.Blu Brst Smoke";
	};
	class mjb_SmokeShellBurstPink : mjb_SmokeShellPink {
		ammo = "mjb_SmokeShellBurstPink";
		descriptionShort = "Type: Bursting Smoke Grenade - Pink<br />Rounds: 1<br />Used in: Hand";
		displayName = "M106 Smoke Grenade (Pink)";
		displayNameShort = "Pnk Brst Smoke";
	};
};

class CfgMagazineWells {
    class CBA_338NM_LINKS {
        mjb_mags[] = {
			"mjb_130Rnd_338_Mag_trc_gr",
			"mjb_130Rnd_338_Mag_trc_ylw","mjb_130Rnd_338_Mag_trc_IR"
        };
    };

	class CBA_545x39_AK {
		mjb_mags[] = {
			"mjb_CUP_95Rnd_TE4_LRT4_IR_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Red_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Yellow_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M"
		};
	};
	class CBA_545x39_RPK {
		mjb_mags[] = {
			"mjb_CUP_95Rnd_TE4_LRT4_IR_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Red_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Yellow_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M"
		};
	};
	class AK_545x39 {
		mjb_mags[] = {
			"mjb_CUP_95Rnd_TE4_LRT4_IR_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Red_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Yellow_Tracer_545x39_RPK_M","mjb_CUP_95Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M"
		};
	};

	class CBA_545x39_belt {
		mjb_mags[] = {
			"mjb_CUP_100Rnd_TE4_IR_Tracer_545x39"//,"mjb_CUP_100Rnd_TE4_LRT4_IR_Tracer_762x51_Belt_M","mjb_CUP_100Rnd_TE4_LRT4_IR_Tracer_762x51_Belt_M","mjb_CUP_200Rnd_TE4_IR_Tracer_556x45_M249","CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M"
			//invisible "mjb_CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_IR_M","mjb_CUP_120Rnd_TE4_LRT4_IR_Tracer_762x51_Belt_M","CUP_50Rnd_UK59_762x54R_Tracer"
		};
	};
    
	class CBA_556x45_G36 {
        mjb_mags[] = {
			"mjb_CUP_100Rnd_TE1_IR_Tracer_556x45_BetaCMag"
		};
	};
	class CBA_556x45_MINIMI {
        mjb_mags[] = {
			"mjb_CUP_100Rnd_TE4_IR_Tracer_556x45_M249",
			"mjb_CUP_200Rnd_TE4_IR_Tracer_556x45_M249"
		};
	};
	class CBA_556x45_STANAG_L {
        mjb_mags[] = {
			"mjb_CUP_60Rnd_556x45_SureFire_Tracer_IR"
		};
	};
	class CBA_556x45_STANAG_2D {
        mjb_mags[] = {
			"mjb_CUP_100Rnd_TE1_IR_Tracer_556x45_BetaCMag_ar15"
		};
	};

	class CBA_580x42_TYPE95 {
        mjb_mags[] = {
			"mjb_30Rnd_580x42_Mag_Tracer_Red"
		};
	};
	class CBA_580x42_TYPE95_XL {
		mjb_mags[] = {
			"mjb_100Rnd_580x42_Mag_Tracer_Red",
			"mjb_100Rnd_580x42_hex_Mag_Tracer_Red",
			"mjb_100Rnd_580x42_ghex_Mag_Tracer_Red"
		};
	};
	class CTAR_580x42 {
        mjb_mags[] = {
			"mjb_30Rnd_580x42_Mag_Tracer_Red"
		};
	};
	class CTAR_580x42_Large {
		mjb_mags[] = {
			"mjb_100Rnd_580x42_Mag_Tracer_Red",
			"mjb_100Rnd_580x42_hex_Mag_Tracer_Red",
			"mjb_100Rnd_580x42_ghex_Mag_Tracer_Red"
		};
	};

	class CBA_762x51_LINKS {
		mjb_mags[] = {
			"mjb_CUP_100Rnd_TE4_LRT4_IR_Tracer_762x51_Belt_M"
		};
	};

	class CBA_762x54R_LINKS {
		mjb_mags[] = {
			"mjb_CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_IR_M"
		};
	};
	class PK_762x54R {
		mjb_mags[] = {
			"mjb_CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_IR_M"
		};
	};
	
    class CBA_93x64_LINKS {
        mjb_mags[] = {
			"mjb_150Rnd_93x64_Mag_trc_IR","mjb_150Rnd_93x64_Mag_trc_red",
			"mjb_150Rnd_93x64_Mag_trc_ylw",
			"mjb_150Rnd_93x64_Mag_trc_grn_full",
			"mjb_150Rnd_93x64_Mag_trc_red_full",
			"mjb_150Rnd_93x64_Mag_trc_ylw_full",
			"mjb_150Rnd_93x64_Mag_trc_rbw_full"
        };
    };

    class CBA_9x19_CZ75_Full {
        mjb_mags[] = {
			"mjb_16Rnd_65x25_cz75"
        };
    };
    class CBA_9x19_Glock_Full {
        mjb_mags[] = {
			"mjb_17Rnd_65x25_glock17"
        };
    };
    class CBA_9x19_HiPower {
        mjb_mags[] = {
			"mjb_13Rnd_65x25_Browning_HP"
        };
    };
    class CBA_9x19_M9 {
        mjb_mags[] = {
			"mjb_15Rnd_65x25_M9"
        };
    };
    class CBA_9x19_P320 {
        mjb_mags[] = {
			"mjb_17Rnd_65x25_M17"
        };
    };
    class CBA_9x19_MP5 {
        mjb_mags[] = {
			"mjb_30Rnd_65x25_MP5"
        };
    };
    class CBA_9x19_ScorpionEvo3 {
        mjb_mags[] = {
			"mjb_30Rnd_65x25_EVO"
        };
    };
    class CBA_9x19_Vityaz {
        mjb_mags[] = {
			"mjb_30Rnd_65x25_Vityaz"
        };
    };


	// East GLs
		//CUP_mags[] = {"CUP_1Rnd_HE_GP25_M","CUP_IlumFlareWhite_GP25_M","CUP_IlumFlareRed_GP25_M","CUP_IlumFlareGreen_GP25_M","CUP_FlareWhite_GP25_M","CUP_FlareGreen_GP25_M","CUP_FlareRed_GP25_M","CUP_FlareYellow_GP25_M","CUP_1Rnd_SMOKE_GP25_M","CUP_1Rnd_SMOKERED_GP25_M","CUP_1Rnd_SMOKEGREEN_GP25_M","CUP_1Rnd_SMOKEYELLOW_GP25_M"};
    class CBA_40mm_GP {
        mjb_mags[] = {
			"mjb_VOGMDP","mjb_slog","mjb_1Rnd_impactSmonk","mjb_1Rnd_impactSmonkBlue","mjb_1Rnd_impactSmonkGreen","mjb_1Rnd_impactSmonkOrange","mjb_1Rnd_impactSmonkPurple","mjb_1Rnd_impactSmonkRed","mjb_1Rnd_impactSmonkYellow","mjb_1Rnd_impactSmonkLightBlue","mjb_1Rnd_impactSmonkPink","mjb_1Rnd_SmonkLightBlue","mjb_1Rnd_SmonkPink"
        };
#if __has_include("\rhsafrf\addons\rhs_c_weapons\script_component.hpp")
		RHS_Magazines[] = {"rhs_VOG25","rhs_VOG25p","rhs_vg40tb","rhs_vg40sz","rhs_vg40op_white","rhs_vg40op_green","rhs_vg40op_red","rhs_GRD40_white","rhs_GRD40_green","rhs_GRD40_red","rhs_VG40MD","rhs_VG40MD_White","rhs_VG40MD_Green","rhs_VG40MD_Red","rhs_GDM40"};
#else
#endif
    };
	
    class VOG_40mm {
        mjb_mags[] = {
			"mjb_VOGMDP","mjb_slog","mjb_1Rnd_impactSmonk","mjb_1Rnd_impactSmonkBlue","mjb_1Rnd_impactSmonkGreen","mjb_1Rnd_impactSmonkOrange","mjb_1Rnd_impactSmonkPurple","mjb_1Rnd_impactSmonkRed","mjb_1Rnd_impactSmonkYellow","mjb_1Rnd_impactSmonkLightBlue","mjb_1Rnd_impactSmonkPink","mjb_1Rnd_SmonkLightBlue","mjb_1Rnd_SmonkPink"
        };
    };

	// west GLs
    class CBA_40mm_EGLM {
        mjb_mags[] = {
			"mjb_blug","mjb_M576buck","mjb_1Rnd_impactSmonk","mjb_1Rnd_impactSmonkBlue","mjb_1Rnd_impactSmonkGreen","mjb_1Rnd_impactSmonkOrange","mjb_1Rnd_impactSmonkPurple","mjb_1Rnd_impactSmonkRed","mjb_1Rnd_impactSmonkYellow","mjb_1Rnd_impactSmonkLightBlue","mjb_1Rnd_impactSmonkPink","mjb_1Rnd_SmonkLightBlue","mjb_1Rnd_SmonkPink"
        };
    };
	
    class CBA_40mm_M203 {
        mjb_mags[] = {
			"mjb_blug","mjb_M576buck","mjb_1Rnd_impactSmonk","mjb_1Rnd_impactSmonkBlue","mjb_1Rnd_impactSmonkGreen","mjb_1Rnd_impactSmonkOrange","mjb_1Rnd_impactSmonkPurple","mjb_1Rnd_impactSmonkRed","mjb_1Rnd_impactSmonkYellow","mjb_1Rnd_impactSmonkLightBlue","mjb_1Rnd_impactSmonkPink","mjb_1Rnd_SmonkLightBlue","mjb_1Rnd_SmonkPink"
        };
    };
	
    class UGL_40x36 {
        mjb_mags[] = {
			"mjb_blug","mjb_M576buck","mjb_1Rnd_impactSmonk","mjb_1Rnd_impactSmonkBlue","mjb_1Rnd_impactSmonkGreen","mjb_1Rnd_impactSmonkOrange","mjb_1Rnd_impactSmonkPurple","mjb_1Rnd_impactSmonkRed","mjb_1Rnd_impactSmonkYellow","mjb_1Rnd_impactSmonkLightBlue","mjb_1Rnd_impactSmonkPink","mjb_1Rnd_SmonkLightBlue","mjb_1Rnd_SmonkPink"
        };
    };
	
	class CBA_9x19_PP19 
	{
		mjb_mags[] = {
			"mjb_cup_64Rnd_46x30_Bizon_M"
		};
	};
};
