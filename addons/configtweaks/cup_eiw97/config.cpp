class CfgPatches {
  class mjb_cup_eiw97 {
		ammo[] = {};
		magazines[] = {};
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Alien314";
		name = "MJB CUP EIW97";
		requiredAddons[]=
		{
			"CUP_Weapons_L85"
		};
		skipWhenMissingDependencies = 1;
	};
};

class Extended_PreInit_EventHandlers
{
	class mjb_cup_eiw97
	{
		init="call compileScript ['z\mjb\addons\configtweaks\cup_eiw97\XEH_preInit.sqf']";
	};
};
class Extended_PreStart_EventHandlers
{
	class mjb_cup_eiw97
	{
		init="call compileScript ['z\mjb\addons\configtweaks\cup_eiw97\XEH_preStart.sqf']";
	};
};

class Mode_FullAuto;
class Mode_Burst;
class CfgWeapons {
	class Rifle_Base_F;
	class CUP_l85a2_base : Rifle_Base_F {
		class FullAuto;
	};
	class CUP_l85a2 : CUP_l85a2_base { };
	class CUP_arifle_L85A2 : CUP_l85a2 { };

	class mjb_cup_eiw97 : CUP_arifle_L85A2 {
		displayName = "EIW97";
		class EventHandlers {
			fired = "_this call mjb_eiw97_fnc_firedEH";
		};
		modes[] = {"Single","Burst","Electronic","FullAuto","fullauto_medium","single_medium_optics1","single_far_optics2"};
		class Electronic : FullAuto {
			displayName = "Electronic";
			reloadTime = 1;
		};
		class Burst : FullAuto {
			autoFire = 0;
			displayName = "Burst";
			textureType = "burst";
			maxRangeProbab = 0;
			midRangeProbab = 0;
			minRangeProbab = 0;
		};
		class FullAuto : FullAuto {
			showToPlayer = 0;
		};
	};

	class CUP_l85a2_ris_ng : CUP_l85a2_base { };
	class CUP_arifle_L85A2_NG : CUP_l85a2_ris_ng { };
	class mjb_cup_eiw97_ng : CUP_arifle_L85A2_NG {
		displayName = "EIW97 (RIS)";
		class EventHandlers {
			fired = "_this call mjb_eiw97_fnc_firedEH";
		};
		modes[] = {"Single","Burst","Electronic","FullAuto","fullauto_medium","single_medium_optics1","single_far_optics2"};
		class Electronic : FullAuto {
			displayName = "Electronic";
			reloadTime = 1;
		};
		class Burst : FullAuto {
			autoFire = 0;
			displayName = "Burst";
			textureType = "burst";
			maxRangeProbab = 0;
			midRangeProbab = 0;
			minRangeProbab = 0;
		};
		class FullAuto : FullAuto {
			showToPlayer = 0;
		};
	};
};
