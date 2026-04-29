
class CfgAmmo
{
	class BulletCore;
	class BulletBase: BulletCore {};
	class B_556x45_Ball: BulletBase	{};
	class B_762x51_Ball: BulletBase	{};

	// MMG Tracer ammo
	class B_338_NM_Ball: BulletBase {};
	class mjb_338_NM_trc_grn: B_338_NM_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_green"; };
	class mjb_338_NM_trc_ylw: B_338_NM_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_yellow"; };

	class B_580x42_Ball_F;
	class mjb_580x42_Ball_trc_red: B_580x42_Ball_F { model = "\A3\Weapons_f\Data\bullettracer\tracer_red"; };
	
	class B_93x64_Ball: BulletBase {};
	class mjb_93x64_trc_red: B_93x64_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_red"; };
	class mjb_93x64_trc_ylw: B_93x64_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_yellow"; };
	class mjb_93x64_trc_wht: B_93x64_Ball { model = "\A3\Weapons_f\Data\bullettracer\tracer_white"; };

#if __has_include("\rhsafrf\addons\rhs_c_weapons\script_component.hpp")
	class rhs_g_vog25;
	class mjb_g_VOGMDP : rhs_g_vog25 {
		indirectHitRange = 4;
		submunitionAmmo = "rhs_ammo_40mmHEDP_penetrator";
		warheadName = "HEAT";
	};
#else
#endif
	class B_12Gauge_Slug;
	class mjb_g_slog : B_12Gauge_Slug {
		airfriction = -0.0012;
		cartridge = "";
		model = "\A3\weapons_f\ammo\UGL_slug";
		simulation = "shotShell";
		typicalSpeed = 76.5;
		timeToLive = 30;
	};
	class mjb_g_blug : B_12Gauge_Slug {
		airFriction = -0.001;
		cartridge = "";
		model = "\A3\weapons_f\ammo\UGL_slug";
		simulation = "shotShell";
		typicalSpeed = 185;
		timeToLive = 30;
	};

	// fix missing penetrator
	class G_40mm_HE;
	class G_40mm_HEDP : G_40mm_HE {
		submunitionAmmo = "ammo_Penetrator_grenade_40mm";
	};

// impact smonk
	class G_40mm_Smoke;
	class mjb_g_smonkWhite : G_40mm_Smoke {
		effectsSmoke = "mjb_SmokeShellWhiteImpactEffect";
		explosionTime = 0;
		//submunitionAmmo = "G_40mm_Smoke";
		timeToLive = 60;
		//triggerOnImpact = 1;
	};
#define SMONKAVAR(VAR,VAR2)  mjb_SmokeShell##VAR##VAR2
#define SMONKAMMO(VAR) class G_40mm_Smoke##VAR; \
	class mjb_g_smonk##VAR : G_40mm_Smoke##VAR { \
		effectsSmoke = QUOTE(SMONKAVAR(VAR,ImpactEffect)); \
		explosionTime = 0; \
		timeToLive = 60; \
	} //QUOTE(SMONKAVAR(VAR,ImpactEffect));"mjb_SmokeShellWhiteImpactEffect";
	SMONKAMMO(Blue);
	SMONKAMMO(Green);
	SMONKAMMO(Orange);
	SMONKAMMO(Purple);
	SMONKAMMO(Red);
	SMONKAMMO(Yellow);
	class mjb_g_smonkLightBlue : mjb_g_smonkWhite {
		effectsSmoke = "mjb_SmokeShellLightBlueImpactEffect";
		smokeColor[] = {0.4000,0.7764,0.9568,1};
	};
	class mjb_g_smonkPink : mjb_g_smonkWhite {
		effectsSmoke = "mjb_SmokeShellPinkImpactEffect";
		smokeColor[] = {0.9568,0.6733,0.8305,1};
	};

	class mjb_g_smokeLightBlue : G_40mm_Smoke {
		effectsSmoke = "mjb_SmokeShellLightBlueEffect";
		smokeColor[] = {0.4000,0.7764,0.9568,1};
	};
	class mjb_g_smokePink : G_40mm_Smoke {
		effectsSmoke = "mjb_SmokeShellPinkEffect";
		smokeColor[] = {0.9568,0.6733,0.8305,1};
	};

	class SmokeShell;
	class mjb_SmokeShellLightBlue : SmokeShell {
		effectsSmoke = "mjb_SmokeShellLightBlueEffect";
		model = "\A3\Weapons_f\ammo\smokegrenade_blue_throw";
		smokeColor[] = {0.4000,0.7764,0.9568,1};
	};
	class mjb_SmokeShellPink : SmokeShell {
		effectsSmoke = "mjb_SmokeShellPinkEffect";
		model = "\A3\Weapons_f\ammo\smokegrenade_red_throw";
		smokeColor[] = {0.9568,0.6733,0.8305,1};
	};


	// impact
	class mjb_g_impactSmonkWhite : G_40mm_Smoke {
		deflecting = 5;
		explosive = 1;
		explosionTime = 0;
		simulation = "shotDeploy";
#if __has_include("z\jsrs2025\addons\sounds_sfx\sounds\FlyBys\40mm_1.wss")
		soundfly[] = {"z\jsrs2025\addons\sounds_sfx\sounds\FlyBys\40mm_1.wss",1,1,50};
#else
#endif
		submunitionAmmo = "mjb_g_smonkWhite";
		timeToLive = 20;
		triggerOnImpact = 1;
	};
	class mjb_g_impactSmonkBlue : mjb_g_impactSmonkWhite {
		submunitionAmmo = "mjb_g_smonkBlue";
	};
	class mjb_g_impactSmonkGreen : mjb_g_impactSmonkWhite {
		submunitionAmmo = "mjb_g_smonkGreen";
	};
	class mjb_g_impactSmonkOrange : mjb_g_impactSmonkWhite {
		submunitionAmmo = "mjb_g_smonkOrange";
	};
	class mjb_g_impactSmonkPurple : mjb_g_impactSmonkWhite {
		submunitionAmmo = "mjb_g_smonkPurple";
	};
	class mjb_g_impactSmonkRed : mjb_g_impactSmonkWhite {
		submunitionAmmo = "mjb_g_smonkRed";
	};
	class mjb_g_impactSmonkYellow : mjb_g_impactSmonkWhite {
		submunitionAmmo = "mjb_g_smonkYellow";
	};
	class mjb_g_impactSmonkLightBlue : mjb_g_impactSmonkWhite {
		submunitionAmmo = "mjb_g_smonkLightBlue";
	};
	class mjb_g_impactSmonkPink : mjb_g_impactSmonkWhite {
		submunitionAmmo = "mjb_g_smonkPink";
	};

    class ACE_9x19_Ball;
	class mjb_65x25_CBJ : ACE_9x19_Ball {
		ACE_ballisticCoefficients[] = {0.1455};
		ACE_bulletLength = 13.005;
		ACE_bulletMass = 2.1;
        ACE_caliber = 4.0;
		ACE_dragModel = 1;
        ACE_muzzleVelocities[] = {720, 764, 855};
		ace_vehicle_damage_incendiary = 0.0;
		airFriction = -0.0014;
		caliber = 3.4;
		typicalSpeed = 855;
		deflecting = 10;
		deflectionSlowDown = 0.5;
	};



	// Rocket use flags
	// cup rpg18, smaw hedp n, smaw spotting


	// had too short life for autocannon, vanilla does 30, these were 6 secs
#define AC_TIME(var)	class var : BulletBase {\
		timeToLive = 30;\
	}
	AC_TIME(CUP_B_20mm_AP_Tracer_Red);
	AC_TIME(CUP_B_20mm_APHE_Tracer_Red);
	AC_TIME(CUP_B_20mm_API_Tracer_Red);
	AC_TIME(CUP_B_23mm_AA);
	AC_TIME(CUP_B_23mm_APHE_No_Tracer);
	AC_TIME(CUP_B_25mm_APFSDS_White_Tracer);
	AC_TIME(CUP_B_30mm_CAS_Red_Tracer);
	AC_TIME(CUP_B_30x113mm_M789_HEDP_Red_Tracer);
	
	class RocketBase;
	
	class R_MRAAWS_HEAT_F : RocketBase {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 70;
	};
	class R_MRAAWS_HEAT55_F : R_MRAAWS_HEAT_F {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 50;
	};
	class R_MRAAWS_HE_F : R_MRAAWS_HEAT_F {
		aiAmmoUsageFlags = "64 + 128 + 256";
		airLock = 1;
		allowAgainstInfantry = 1;
		cost = 50;
	};
	
	class R_PG32V_F : RocketBase {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 70;
	};
	class R_PG7_F : RocketBase {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 30;
	};
	class R_TBG32V_F : R_PG32V_F {
		aiAmmoUsageFlags = "64 + 128 + 256";
		airLock = 1;
		allowAgainstInfantry = 1;
		cost = 50;
	};

	class M_NLAW_AT_F;
	class ACE_NLAW : M_NLAW_AT_F {
		cost = 50;
		//submunitionAmmo = "ACE_NLAW_Penetrator";
	};
	class ammo_Penetrator_NLAW;
	class ACE_NLAW_Penetrator : ammo_Penetrator_NLAW {
		//hit = 525;
		//warheadName = "AP";
	};

	// CUP
	class CUP_R_APILAS_AT : RocketBase {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 50;
	};
	class CUP_R_M136_AT : RocketBase {
		airLock = 1;
		cost = 50;
	};
	class CUP_R_M72A6_AT : RocketBase {
		airLock = 1;
		cost = 50;
	};
	class CUP_R_MEEWS_HEDP : RocketBase {
		aiAmmoUsageFlags = "64 + 128 + 256 + 512";
		airLock = 1;
		cost = 50;
	};
	class CUP_R_MEEWS_HEAT : CUP_R_MEEWS_HEDP {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 70;
	};
	class CUP_R_OG7_AT : RocketBase {
		airLock = 1;
		allowAgainstInfantry = 1;
		indirectHit = 30;
		cost = 25;
	};
	class CUP_R_PG26_AT : RocketBase {
		airLock = 1;
		cost = 50;
	};
	class CUP_R_PG7V_AT : RocketBase {
		airLock = 1;
		cost = 30;
	};
	class CUP_R_PG7VL_AT : RocketBase {
		airLock = 1;
		cost = 50;
	};
	class CUP_R_PG7VM_AT : RocketBase {
		airLock = 1;
		cost = 50;
	};
	class CUP_R_PG7VR_AT : RocketBase {
		cost = 100;
	};
	class CUP_R_PZF3IT_AT : RocketBase {
		cost = 100;
	};
	class CUP_R_PZFBB_HE : CUP_R_PZF3IT_AT {
		airLock = 1;
		allowAgainstInfantry = 1;
		cost = 40;
	};
	class CUP_R_RPG18_AT : RocketBase {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 30;
	};
	class CUP_R_RSHG2_HE : RocketBase {
		aiAmmoUsageFlags = "64 + 128 + 256";
		allowAgainstInfantry = 1;
		indirecthit = 15;
		indirecthitrange = 6;
		airLock = 1;
		cost = 25;
	};
	class CUP_R_SMAW_HEDP : RocketBase {
		aiAmmoUsageFlags = "64 + 128 + 256 + 512";
		allowAgainstInfantry = 1;
		airLock = 1;
		cost = 50;
	};
	class CUP_R_SMAW_HEDP_N : RocketBase {
		aiAmmoUsageFlags = "64 + 128 + 256 + 512";
		allowAgainstInfantry = 1;
		airLock = 1;
		cost = 50;
	};
	class CUP_R_SMAW_HEAA : CUP_R_SMAW_HEDP {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 100;
	};
	class CUP_R_SMAW_HEAA_N : CUP_R_SMAW_HEDP_N {
		aiAmmoUsageFlags = "128 + 256 + 512";
		airLock = 1;
		cost = 100;
	};
	class CUP_R_TBG7V_AT : RocketBase {
		aiAmmoUsageFlags = "64 + 128";
		allowAgainstInfantry = 1;
		airLock = 1;
		cost = 50;
		fuseDistance = 20;
	};

	class CUP_P_M72A6_AT;
	class mjb_P_M72A10_MP : CUP_P_M72A6_AT {
		hit = 280;
		caliber = 10;
	};

	class mjb_R_M72A10_MP : CUP_R_M72A6_AT {
		aiAmmoUsageFlags = "64 + 128 + 256";
		allowAgainstInfantry = 1;
		cost = 30;
		CraterEffects = "GrenadeCrater";
		//explosionEffects = "GrenadeExplosion";
		explosive = 1;
		fuseDistance = 15;
		hit = 140;
		indirectHit = 15;
		indirectHitRange = 4;
		submunitionAmmo = "mjb_P_M72A10_MP";
		warheadName = "HEDP";
	};
	
	
	// Ammo Balance, spreadsheet with changes: https://docs.google.com/spreadsheets/d/1hBv11wZy6fM9IIj6Qh0-j3qezPhqOBt0XZLNUT1HfvQ/edit#gid=0
	// RHS has very different stats for ammo, resulting in stronger or weaker than expected performance.
	// These configs change them to closer match ACE/Vanilla and balance ammos in general
	// airFriction: affects bullet drop and damage falloff, 0 is no drop/falloff, -0.001 is ~average
	// caliber: how well a bullet penetrates, higher is more penetrative
	// hit: base damage of a bullet
	// Initial bullet speed is set on magazines with a possible override on weapons, will be much more difficult to change
	/*
	// Vanilla
	class B_12Gauge_Slug: BulletBase
	{
		airFriction = -0.002042; // faster bullet drop/damage falloff
		caliber = 0.54; // less pen, easily destroyed cars before, can still brick engines
		hit = 34.51; // less damage than vanilla
	};
	class B_65x39_Caseless: BulletBase 
	{
		hit = 9.5; // Slight reduction to 6.5, still much stronger than other rifle calibers at range	
	};
	
	
	// CUP	
	class CUP_B_46x30_Ball: BulletBase // MP7 toward RHS values
	{
		caliber = 0.52;
		airFriction = -0.002155;
	};
	
	class CUP_B_545x39_Ball: BulletBase {};
	class CUP_B_545x39_Ball_Subsonic: CUP_B_545x39_Ball // 5.45 subsonic toward RHS
	{
		caliber = 0.34;
		hit = 4;
	};
	class CUP_B_762x39_Ball: BulletBase {};
	class CUP_B_762x39_Ball_Subsonic: CUP_B_762x39_Ball // 7.62x39 subsonic toward RHS
	{
		caliber = 0.455063;
		hit = 5.79;
	};
	class CUP_680x43_Ball_Tracer_Red: B_762x51_Ball
	{
		hit = 10;
	};
	class CUP_12Gauge_Slug: B_12Gauge_Slug
	{
		caliber = 0.54; // inherits everything except caliber
	};
	
	
	// RHS 5.56
	class rhs_ammo_556x45_M193_Ball: B_556x45_Ball
	{
		airFriction = -0.001325;
	};
	class rhs_ammo_556x45_M855_Ball: B_556x45_Ball
	{
		airFriction = -0.001354;
	};
	class rhs_ammo_556x45_M855A1_Ball: B_556x45_Ball
	{
		airFriction = -0.00130094;
	};
	class rhs_ammo_556x45_M995_AP: B_556x45_Ball
	{
		airFriction = -0.00126182;
		caliber = 1.6;
	};
	class rhs_ammo_556x45_Mk262_Ball: B_556x45_Ball
	{
		airFriction = -0.00111805;
		caliber = 0.869;
		hit = 9;
	};
	class rhs_ammo_556x45_Mk318_Ball: B_556x45_Ball
	{
		airFriction = -0.0012588;
		caliber = 0.869;
		hit = 9;
	};	
	
	//RHS Sub/Pistol
	class rhs_ammo_46x30_FMJ: rhs_ammo_556x45_M855A1_Ball
	{
		airFriction = -0.001865;
	};
	class rhs_ammo_46x30_AP: rhs_ammo_46x30_FMJ
	{
		airFriction = -0.002155;
	};
	class rhs_ammo_rhs_ammo_46x30_JHP: rhs_ammo_46x30_FMJ
	{
		airFriction = -0.002635;
	};
	
	// RHS 5.45
	class rhs_B_545x39_Ball: B_556x45_Ball
	{
		hit = 8;
		airFriction = -0.00129458;
		caliber = 0.34;
	};
	class rhs_B_545x39_7N10_Ball: rhs_B_545x39_Ball
	{
		airFriction = -0.00119458;
		hit = 8.5;
	};
	class rhs_B_545x39_7N22_Ball: rhs_B_545x39_Ball
	{
		airFriction = -0.00095;
		hit = 8.8;
	};
	class rhs_B_545x39_7N24_Ball: rhs_B_545x39_Ball
	{
		airFriction = -0.00095;
		hit = 7;
	};
	class rhs_B_545x39_7N6_Ball: rhs_B_545x39_Ball
	{
		airFriction = -0.00119458;
		caliber = 0.54;
		hit = 8.3;
	};
	class rhs_B_545x39_7U1_Ball: rhs_B_545x39_Ball
	{
		caliber = 0.34;
		hit = 4;
	};
	
	// RHS 7.62x39
	class rhs_B_762x39_Ball: B_762x51_Ball
	{
		airFriction = -0.00150173;
		caliber = 0.928;
		hit = 9.8;
	};
	class rhs_B_762x39_Ball_89: rhs_B_762x39_Ball
	{
		caliber = 1.2;
		hit = 11;
	};
	class rhs_B_762x39_U_Ball: rhs_B_762x39_Ball
	{
		airFriction = -0.0007324;
	};
	
	// RHS 7.62x51
	class rhs_ammo_762x51_M80_Ball: BulletBase
	{
		airFriction = -0.00103711;
		caliber = 1;
	};
	class rhs_ammo_762x51_M118_Special_Ball: rhs_ammo_762x51_M80_Ball
	{
		airFriction = -0.00085147;
		caliber = 1.8;
		hit = 16;
	};
	class rhs_ammo_762x51_M61_AP: rhs_ammo_762x51_M80_Ball
	{
		caliber = 1.9;
	};
	class rhs_ammo_762x51_M80A1EPR_Ball: rhs_ammo_762x51_M80_Ball
	{
		airFriction = -0.00118711;
		caliber = 1.2;
	};
	class rhs_ammo_762x51_M993_Ball: rhs_ammo_762x51_M80_Ball
	{
		airFriction = -0.0010939;
		caliber = 2.2;
		hit = 11;
	};
	class rhs_ammo_762x51_Mk316_Special_Ball: rhs_ammo_762x51_M118_Special_Ball
	{
		airFriction = -0.00084311;
	};
	
	// RHS 12gauge
	class rhs_ammo_12g_slug: B_12Gauge_Slug
	{
		airFriction = -0.002042; // RHS slugs do their own thing
		caliber = 0.54; // for each of these, I kept everything but 
		hit = 34.51; // caliber and applied it to vanilla/CUP
	};
	*/
};
