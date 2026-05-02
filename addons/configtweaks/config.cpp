class CfgPatches {
  class ConfigTweaks {
    ammo[] = {"mjb_338_NM_trc_gr","mjb_338_NM_trc_ylw","mjb_93x64_trc_gr","mjb_93x64_trc_ylw","mjb_580x42_Ball_trc_red","mjb_65x25_CBJ"};
    magazines[] = {"mjb_150Rnd_93x64_Mag_tracer","mjb_150Rnd_93x64_Mag_trc_red","mjb_150Rnd_93x64_Mag_trc_ylw", "mjb_130Rnd_338_Mag_tracer","mjb_130Rnd_338_Mag_trc_gr","mjb_130Rnd_338_Mag_trc_ylw","mjb_13Rnd_65x25_Browning_HP","mjb_15Rnd_65x25_M9","mjb_16Rnd_65x25_cz75","mjb_17Rnd_65x25_M17","mjb_17Rnd_65x25_glock17","mjb_30Rnd_65x25_Vityaz","mjb_30Rnd_65x25_MP5","mjb_150Rnd_93x64_Mag_trc_rbw_full","mjb_30Rnd_580x42_Mag_Tracer_Red","mjb_100Rnd_580x42_Mag_Tracer_Red","mjb_100Rnd_580x42_hex_Mag_Tracer_Red","mjb_100Rnd_580x42_ghex_Mag_Tracer_Red","mjb_M72A10_M"/*, "CUP_64Rnd_9x18_Bizon_M","CUP_64Rnd_Green_Tracer_9x18_Bizon_M","CUP_64Rnd_Red_Tracer_9x18_Bizon_M","CUP_64Rnd_White_Tracer_9x18_Bizon_M","CUP_64Rnd_Yellow_Tracer_9x18_Bizon_M"*/};
    units[] = {"Box_Rats_Ammo","mjb_O_customSoldier","mjb_O_customSoldier_mg"}; //
    weapons[] = {"mjb_launch_M72A10_Loaded","mjb_launch_M72A10","mjb_launch_M72A10_Used"};
    requiredVersion = 0.1;
    author = "SuperJam, Camelith, Alien314";
    name = "Config Tweaks";
	requiredAddons[]=
        {
            "ace_ballistics",
            "CUP_Creatures_People_LoadOrder",
            "CUP_Weapons_Ammunition",
            "CUP_AirVehicles_LoadOrder",
            "CUP_TrackedVehicles_LoadOrder",
            "CUP_WaterVehicles_LoadOrder",
            "CUP_WheeledVehicles_LoadOrder",
			"PMC_Vest",
			"ace_recoil",
			"ace_laserpointer",
			"asdg_jointmuzzles"
        };
    };
};

#define QUOTE(VAR) #VAR
// AI Turrets Dispersion Config Tweaks (Built on nkenny's @LAMBS_Turrets)

class CfgBrains {
  class DefaultSoldierBrain {
    class Components {
      class AIBrainAimingErrorComponent {
        maxAngularErrorTurrets =
            0.1308;  // half of the error cone in radians, used for turrets
      };
    };
  };
};

// No greenmag spaghetti tweak
class CfgInventoryGlobalVariable { maxSoldierLoad = 9001; };

class CfgRecoils {
  class recoil_default;
  class recoil_mk200 : recoil_default {
	muzzleOuter[] = {"0.4*0.2","0.6*1", "0.4*1" ,"0.2*1"};
  };
  class recoil_zafir : recoil_default {
	muzzleOuter[] = {"0.5*0.2","1*1", "0.5*1" ,"0.3*1"};
  };
};

// zero collapse damage
class CfgDamageAround {

	//*/
	class CUP_OPX_DamageAroundHousePart_01 {
		indirectHit = 3; // 3
		radiusRatio = 0.15; // 0.15
	};
	class DamageAroundHouse {
		indirectHit = 7;   // 11
		radiusRatio = 1.0; // 1.0
	};
	class DamageAroundHousePart {
		indirectHit = 7; // 100
		radiusRatio = 0.15; // 0.15
	};
	class DamageAroundPole {
		indirectHit = 7;   // 900
		radiusRatio = 0.3; // 0.3
	};//*/
	class MJB_DamageAroundCUP {
		indirectHit = 7;   // 9?
		radiusRatio = 0.25; // 0.2
	};
};

class Mode_SemiAuto;
class Mode_FullAuto;



/*class CfgSounds {
  class 3den_notificationWarning {
    sound[] = {"\a3\3DEN\Data\Sound\CfgSound\notificationWarning",0.85,1};
  };
};*/

#include "CfgCloudlets.hpp" // 

#include "CfgAmmo.hpp" // MMG Tracer ammo, (commented Ammo config)
#include "CfgMagazines.hpp" // GreenMag simple compatibility, MMG Tracer boxes

class CBA_Extended_EventHandlers_base; // apply to vehicle classes missing it
#include "CfgVehicles.hpp"  // BRH for all units/uniforms

class Extended_InitPost_EventHandlers {
	class CUP_AH6_BASE {
		class mjb_configTweaks {
			init = "params ['_unit']; if !(local _unit) exitWith {}; _unit setMass mjb_cupLBMass;"; //1821
		};
	};
	class CUP_CH47F_base {
		class mjb_configTweaks {
			init = "params ['_unit']; if !(local _unit) exitWith {}; _unit setMass mjb_cupCHMass;"; //10001
		};
	};
	class CUP_CH47E_base {
		class mjb_configTweaks {
			init = "params ['_unit']; if !(local _unit) exitWith {}; _unit setMass mjb_cupCHMass;"; //10001
		};
	};
};

class CfgUnitInsignia {
	class Spetsnaz223rdDetachment {
		scope = 1;
	};

	class CUP_insignia_ua_kraken {
		scope = 1;
	};
	class CUP_insignia_ua_krakenlowvis {
		scope = 1;
	};
	class CUP_insignia_3rd_ab {
		scope = 1;
	};
	class CUP_insignia_3rd_ablowvis {
		scope = 1;
	};
};

#include "muzzleSlots.hpp" // Enable muzzle devices on different weapons
#include "CfgWeapons.hpp" // AIDispersion, Weapon, Greenmag items, Accessory, Helmet, and Vest tweaks