class CfgPatches {
  class mjb_ace_ax_cup_tweak {
		ammo[] = {};
		magazines[] = {};
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Alien314";
		name = "ACE AX Cup tweak";
		requiredAddons[]=
		{
			"aceax_compat_cup","aceax_acebi_compat"
		};
		skipWhenMissingDependencies = 1;
	};
};

class XtdGearInfos {
	class CfgWeapons {
		class CUP_U_B_GER_Crye {
			camo = "TRPTRN";
		};
		class CUP_U_B_GER_Crye2 {
			camo = "TRPTRN";
		};
	};
};

class XtdGearModels {
	class CfgVehicles {
		class acebi_carryall {
			class camo {
				values[] += {"CBR"};
			};
		};
	};
	class CfgWeapons {
		class cup_crye {
			class camo {
				values[] += {"TRPTRN"};
			};
		};
	};
};