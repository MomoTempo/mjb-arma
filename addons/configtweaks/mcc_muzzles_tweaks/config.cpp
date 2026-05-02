class CfgPatches {
  class mjb_mcc_muzzles_tweaks {
    ammo[] = {};
    magazines[] = {};
    units[] = {};
    weapons[] = {};
    requiredVersion = 0.1;
    author = "Alien314";
    name = "MCC Muzzles tweaks";
	requiredAddons[]=
        {
            "MCC_Muzzle" // weapons[] = {"MCC_HuxWrx_Flow_556K","MCC_HuxWrx_Flow_556K_FDE","MCC_HuxWrx_FHQD","MCC_HuxWrx_Flow_762TI","MCC_HuxWrx_Flow_762TI_FDE","MCC_QDCCRS_PRT_556_BLK","MCC_QDCCRS_PRT_556_FDE","MCC_QDCCRS_PRT_556_TAN","MCC_QDCCRS_PRT_Shroud_556_BLK","MCC_QDCCRS_PRT_Shroud_556_FDE","MCC_QDCCRS_PRT_Shroud_556_TAN","MCC_MCQ1_556_BLK","MCC_MCQ1_556_FDE","MCC_MCQ1_556_TAN","MCC_MCQ1_Shroud_556_BLK","MCC_MCQ1_Shroud_556_FDE","MCC_MCQ1_Shroud_556_TAN","MCC_KAC_3PFDE","MCC_RotexV_556","MCC_RotexV_556_FDE","MCC_RotexV_556_GRY","MCC_RotexV_C_556","MCC_RotexV_C_556_FDE","MCC_RotexV_C_556_GRY","MCC_RotexV_D_556","MCC_RotexV_D_556_FDE","MCC_RotexV_D_556_GRY","MCC_RBS_762","MCC_DD_SG556","MCC_DD_SG30","MCC_DD_SG30TI","MCC_DD_SG30TIL","MCC_Polo_556","MCC_Polo_556_FDE","MCC_Polo_556_Mix","MCC_PoloK_556","MCC_PoloK_556_FDE","MCC_PoloK_556_Mix","MCC_Polo_762","MCC_Polo_762_FDE","MCC_Polo_762_Mix","MCC_CGS6_BLK","MCC_CGS6_GRY","MCC_CGS6_FDE","MCC_CGS6_FH","MCC_JK_Goat_L","MCC_JK_Goat_M","MCC_JK_Goat_S","MCC_JK_WarEagle","MCC_RC2_556","MCC_RC2_556_FDE","MCC_RC3_556","MCC_RC3_556_FDE","MCC_SOCOM_Mini2_556","MCC_SOCOM_Mini2_556_FDE","MCC_SOCOM_RC4","MCC_SOCOM_RC4_FDE","MCC_SOCOM_Mini4","MCC_SOCOM_Mini4_FDE","MCC_WARCOMP_556","MCC_SF4P_556","MCC_Warden","MCC_Warden_FDE","MCC_SUREFIRE_RBC","MCC_RC2_762","MCC_RC2_762_FDE","MCC_SOCOM_Mini2_762","MCC_SOCOM_Mini2_762_FDE","MCC_Ti2_762","MCC_Ti2_762_FDE","MCC_Millbrook_MFMD_Blk","MCC_Millbrook_MFMD_FDE","MCC_Hesychia_SIXK_BLK","MCC_Hesychia_SIXK_FDE","MCC_Hesychia_SIXK_OD","MCC_Hesychia_SIXK_RAW","MCC_Hesychia_HFH","MCC_DeadAir_Wolverine_DT","MCC_DeadAir_Wolverine_HUB"};
        };
    skipWhenMissingDependencies = 1;
  };
};

class CfgWeapons {
	// Base classes
	class ItemCore;
	class InventoryMuzzleItem_Base_F;
	
	// speed fix
	class MCC_RotexV_556 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_DD_SG556 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_DeadAir_Wolverine_HUB : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_JK_Goat_L : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.05;
			};
		};
	};
	class MCC_Millbrook_MFMD_Blk : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_Polo_556 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_PoloK_556 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_RC2_556 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_RC3_556 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_SOCOM_RC4 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};


	class MCC_Polo_762 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_RC2_762 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_Ti2_762 : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};

   // flash fix
	class MCC_CGS6_FH : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			alternativeFire = "Zasleh2";
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_Hesychia_HFH : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			alternativeFire = "Zasleh2";
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_HuxWrx_FHQD : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			alternativeFire = "Zasleh2";
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_JK_WarEagle : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			alternativeFire = "CUP_muzzleFlash_muzzleBreak";
			class MuzzleCoef {
				fireLightCoef = "0.8f";
			};
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_KAC_3PFDE : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			alternativeFire = "Zasleh2";
			class MagazineCoef {
				initSpeed = 1.0;
			};
		};
	};
	class MCC_SUREFIRE_RBC : ItemCore {
		class ItemInfo : InventoryMuzzleItem_Base_F {
			alternativeFire = "CUP_muzzleFlash_muzzleBreak";
			class MuzzleCoef {
				fireLightCoef = "0.8f";
			};
		};
	};
};
