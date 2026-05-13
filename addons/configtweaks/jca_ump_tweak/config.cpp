class CfgPatches {
  class mjb_jca_ump_tweak {
		ammo[] = {};
		magazines[] = {};
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Alien314";
		name = "JCA ump tweak";
		requiredAddons[]=
		{
			"Weapons_F_JCA_UMP"
		};
		skipWhenMissingDependencies = 1;
	};
};

class CfgWeapons {
	class Rifle_Short_Base_F;
	class JCA_smg_UMP_base_F : Rifle_Short_Base_F {
		discreteDistance[] = {50,100,200,300,400};
	};
};

class CfgMagazines {
	class CA_Magazine;
	class JCA_25Rnd_45ACP_UMP_Mag : CA_Magazine
	{
		greenmag_basicammo = "greenmag_ammo_45ACP_basic_1Rnd";
		greenmag_canSpeedload = 1;
		greenmag_needBelt = 0;
	};
};