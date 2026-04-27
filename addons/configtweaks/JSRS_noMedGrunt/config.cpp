class CfgPatches {
  class mjb_jsrs_noMedGrunt {
    ammo[] = {};
    magazines[] = {};
    units[] = {};
    weapons[] = {};
    requiredVersion = 0.1;
    author = "Alien314";
    name = "JSRS No Med Grunt";
	requiredAddons[]=
        {
            
        "jsrs2025_config_c","jsrs2025_sounds_character","jsrs2025_sounds_explosions","CUP_Vehicles_LoadOrder"
	};
    skipWhenMissingDependencies = 1;
  };
};

// dragon must roar
class CfgAmmo {
  class ShellBase;
  class ace_dragon_serviceCharge : ShellBase {
//"jsrs_2025_explosion_shock_small_soundset","jsrs_2025_explosion_stereo_small_soundset",
    soundsetexplosion[] = {"jsrs_2025_explosion_shock_small_soundset","jsrs_2025_small_explosion_tails_soundset"}; // gooood
    //soundsetexplosion[] = {"jsrs_2025_explosion_shock_medium_soundset","jsrs_2025_explosion_stereo_generic_soundset","jsrs_2025_small_explosion_tails_soundset"};
    //soundsetexplosion[] = {"jsrs_2025_rocket_epl_soundset","jsrs_2025_explosion_stereo_generic_soundset","jsrs_2025_rockets_explosion_tails_soundset"};
    //soundsetexplosion[] = {"jsrs_2025_rockets_explosion_tails_soundset"}; //not as rumbly
    //soundsetexplosion[] = {"jsrs_2025_explosion_stereo_big_soundset","jsrs_2025_explosion_stereo_generic_soundset","jsrs_2025_cannon_tails_soundset"};
    //soundsetexplosion[] = {"jsrs_2025_cannon_tails_soundset"}; // stuttery
    //soundsetexplosion[] = {"jsrs_2025_shell_epl_soundset","jsrs_2025_explosion_stereo_small_soundset","jsrs_2025_small_explosion_tails_soundset"};
    //soundsetexplosion[] = {"jsrs_2025_missile_epl_soundset","jsrs_shell_explosion_stereo_soundset","jsrs_2025_small_explosion_tails_soundset"};
    //soundsetexplosion[] = {"jsrs_shell_explosion_soundset","jsrs_shell_explosion_stereo_soundset","jsrs_shell_explosion_reverb_soundset"}; // old JSRS
  };
};

/*class CfgDistanceFilters {
  class jsrs_2025_footstep_distancefilter {
	//powerFactor = 5;
  };
};*/

class Extended_PreInit_EventHandlers
{
	class mjb_jsrs_noMedGrunt {
#if __has_include("\z\mjb\addons\configtweaks\cfgMagazines.hpp")
		init="call compileScript ['z\mjb\addons\configtweaks\JSRS_noMedGrunt\settings.sqf']";
#else
		init="call compileScript ['z\mjb\addons\noGrunt\settings.sqf']";
#endif
	};
};

class JSRS_BaseFunction;
class CfgFunctions {
	class JSRS {
		class sys {
			class onFiredMagazineEmpty: JSRS_BaseFunction {
				//file = "z\jsrs2025\addons\functions\functions";
				
#if __has_include("\z\mjb\addons\configtweaks\cfgMagazines.hpp")
				file = "z\mjb\addons\configtweaks\JSRS_noMedGrunt\fn_onFiredMagazineEmpty.sqf";
#else
				file = "z\mjb\addons\noGrunt\fn_onFiredMagazineEmpty.sqf";
#endif
			};
		};
	};
};


class CfgSoundSets {
#define CRAWL(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.35; \
	occlusionFactor = 0.7; \
  }
#define CRAWLIN(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.35; \
	occlusionFactor = 0.0; \
  }
#define SPRINT(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.8; \
	occlusionFactor = 0.3; \
  }
#define SPRINTIN(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.8; \
	occlusionFactor = 0.0; \
  }
#define RUN(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.7; \
	occlusionFactor = 0.4; \
  }
#define RUNIN(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.7; \
	occlusionFactor = 0.0; \
  }
#define TACT(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.5; \
	occlusionFactor = 0.6; \
  }
#define WALKIN(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.45; \
	occlusionFactor = 0.0; \
  }
#define WALK(NAME,PARENT) \
  class ##NAME## : ##PARENT## { \
	volumeFactor = 0.45; \
	occlusionFactor = 0.7; \
  }

  class jsrs_2025_basic_movement_soundset;
  TACT(jsrs_2025_basic_gear_tactical_SoundSet,jsrs_2025_basic_movement_SoundSet);
  RUN(jsrs_2025_basic_gear_run_SoundSet,jsrs_2025_basic_movement_SoundSet);
  SPRINT(jsrs_2025_basic_gear_sprint_SoundSet,jsrs_2025_basic_movement_SoundSet);
  //CRAWL(jsrs_2025_basic_movement_crawl_SoundSet,jsrs_2025_basic_movement_SoundSet);
  //CRAWLIN(jsrs_2025_basic_movement_int_rev_crawl_SoundSet,jsrs_2025_basic_movement_SoundSet);
  //WALK(jsrs_2025_basic_movement_walk_SoundSet,jsrs_2025_basic_movement_SoundSet);
  //WALKIN(jsrs_2025_basic_movemen_int_revt_walk_SoundSet,jsrs_2025_basic_movement_SoundSet);
  TACT(jsrs_2025_basic_movement_tactical_SoundSet,jsrs_2025_basic_movement_SoundSet);
  RUN(jsrs_2025_basic_movement_run_SoundSet,jsrs_2025_basic_movement_SoundSet);
  RUNIN(jsrs_2025_basic_movement_int_run_SoundSet,jsrs_2025_basic_movement_SoundSet);
  SPRINT(jsrs_2025_basic_movement_sprint_SoundSet,jsrs_2025_basic_movement_SoundSet);
  SPRINTIN(jsrs_2025_basic_movement_int_sprint_SoundSet,jsrs_2025_basic_movement_SoundSet);
};

// Louden Vehicles
class CfgSoundCurves {
		// old jsrs
		//points[] = {{0,1},{0.1,0.95},{0.2,0.66},{0.3,0.42},{0.4,0.22},{0.5,0.15},{0.6,0.1},{0.7,0.08},{0.8,0.05},{0.9,0.005},{1,0}};
		// jsrs25 default
		// points[] = {[0,1],[0.1,0.55],[0.2,0.35],[0.3,0.2],[0.4,0.1],[0.5,0.05],[0.7,0.02],[1,0]};
#define CURVE(var1) class var1 { \
		points[] = {{0,1},{0.1,0.85},{0.2,0.69},{0.3,0.60},{0.4,0.52},{0.5,0.43},{0.6,0.27},{0.7,0.10},{0.8,0.05},{0.9,0.01},{1,0}}; \
	}
	//
	CURVE(jsrs_2025_tank_tracks_volumecurve);
	CURVE(jsrs_2025_vehicle_apcs_volumecurve);
	//CURVE(jsrs_2025_vehicle_cars_volumecurve);
	CURVE(jsrs_2025_vehicle_drones_volumecurve);
	//CURVE(jsrs_2025_vehicle_helicopters_volumecurve);
	CURVE(jsrs_2025_vehicle_mraps_volumecurve);
	CURVE(jsrs_2025_vehicle_planes_volumecurve);
	CURVE(jsrs_2025_vehicle_tanks_volumecurve);
	CURVE(jsrs_2025_vehicle_trucks_volumecurve);
	//*/

	class jsrs_2025_vehicle_cars_volumecurve { 
		points[] = {{0,1},{0.1,0.85},{0.1,0.8},{0.2,0.75},{0.3,0.7},{0.4,0.65},{0.5,0.6},{0.6,0.5},{0.7,0.4},{0.8,0.2},{0.9,0.01},{1,0}}; 
	};

	class jsrs_2025_vehicle_helicopters_volumecurve { 
		points[] = {{0,1},{0.05,0.85},{0.1,0.75},{0.2,0.67},{0.3,0.62},{0.4,0.55},{0.5,0.47},{0.6,0.37},{0.7,0.25},{0.8,0.15},{0.9,0.01},{1,0}};
	};
};

class CfgVehicles {
	//vehicle sounds
	class Car;
	class Car_F : Car { class Sounds; };

	class CUP_SUV_Base : Car_F {
		class Sounds : Sounds {
			soundSetsExt[] = {"jsrs_2025_car_01_engine_ext_idle_soundset","jsrs_2025_car_01_engine_ext_drive_soundset","jsrs_2025_base_cars_engine_rev_petrol_soundset","jsrs_2025_car_01_engine_evr_soundset","jsrs_2025_car_01_engine_ext_release_soundset","jsrs_2025_car_01_engine_ext_distance_soundset","jsrs_2025_tires_asphalt_slow_ext_soundset","jsrs_2025_tires_asphalt_fast_ext_soundset","jsrs_2025_tires_asphalt_fast_far_soundset","jsrs_2025_tires_offroad_slow_ext_soundset","jsrs_2025_tires_offroad_fast_ext_soundset","jsrs_2025_tires_grass_ext_soundset","jsrs_2025_base_cars_engine_ext_turbo_soundset","jsrs_2025_base_cars_rattle_ext_soundset","jsrs_2025_base_cars_stress_ext_soundset","hatchback_01_rain_ext_soundset","hatchback_01_tires_water_slow_ext_soundset","hatchback_01_tires_turn_hard_ext_soundset","hatchback_01_tires_turn_soft_ext_soundset","hatchback_01_tires_brake_hard_ext_soundset","hatchback_01_tires_brake_soft_ext_soundset"};
			soundSetsInt[] = {"jsrs_2025_car_01_engine_int_idle_soundset","jsrs_2025_car_01_engine_int_drive_soundset","jsrs_2025_base_cars_engine_int_rev_petrol_soundset","jsrs_2025_car_01_engine_int_release_soundset","jsrs_2025_tires_asphalt_slow_int_soundset","jsrs_2025_tires_asphalt_fast_int_soundset","jsrs_2025_tires_offroad_slow_int_soundset","jsrs_2025_tires_offroad_fast_int_soundset","jsrs_2025_tires_grass_int_soundset","jsrs_2025_wheeled_driving_noises_int_car_1_soundset","jsrs_2025_wheeled_offroad_driving_noises_int_car_1_soundset","jsrs_2025_base_cars_engine_int_turbo_soundset","jsrs_2025_base_cars_rattle_int_soundset","jsrs_2025_base_cars_stress_int_soundset","jsrs_2025_base_cars_rain_int_soundset","hatchback_01_tires_water_slow_int_soundset","hatchback_01_tires_turn_hard_int_soundset","hatchback_01_tires_turn_soft_int_soundset","hatchback_01_tires_brake_hard_int_soundset","hatchback_01_tires_brake_soft_int_soundset"};
		};
	};

	class Wheeled_APC_F : Car_F {
		class Sounds : Sounds {
			soundsetsext[] = {"jsrs_2025_apc_w_02_engine_ext_idle_soundset","jsrs_2025_apc_w_02_engine_ext_drive_soundset","jsrs_2025_base_apcs_engine_rev_old_soundset","jsrs_2025_apc_w_02_engine_evr_soundset","jsrs_2025_apc_w_02_engine_ext_release_soundset","jsrs_2025_apc_w_02_engine_ext_distance_soundset","jsrs_2025_tires_asphalt_slow_ext_soundset","jsrs_2025_tires_asphalt_fast_ext_soundset","jsrs_2025_tires_asphalt_fast_far_soundset","jsrs_2025_tires_offroad_slow_ext_soundset","jsrs_2025_tires_offroad_fast_ext_soundset","jsrs_2025_tires_grass_ext_soundset","jsrs_2025_base_apcs_rattle_ext_soundset","jsrs_2025_base_apcs_stress_ext_soundset","truck_01_rain_ext_soundset","truck_01_tires_water_fast_ext_soundset","truck_01_tires_water_slow_ext_soundset","truck_01_tires_turn_hard_ext_soundset","truck_01_tires_turn_soft_ext_soundset","truck_01_tires_brake_hard_ext_soundset","truck_01_tires_brake_soft_ext_soundset"};
			soundsetsint[] = {"jsrs_2025_apc_w_02_engine_int_idle_soundset","jsrs_2025_apc_w_02_engine_int_drive_soundset","jsrs_2025_base_apcs_engine_int_rev_old_soundset","jsrs_2025_apc_w_02_engine_int_release_soundset","jsrs_2025_tires_asphalt_slow_int_soundset","jsrs_2025_tires_asphalt_fast_int_soundset","jsrs_2025_tires_offroad_slow_int_soundset","jsrs_2025_tires_offroad_fast_int_soundset","jsrs_2025_tires_grass_int_soundset","jsrs_2025_wheeled_driving_noises_int_car_1_soundset","jsrs_2025_wheeled_offroad_driving_noises_int_car_1_soundset","jsrs_2025_base_apcs_rattle_int_soundset","jsrs_2025_base_apcs_stress_int_soundset","jsrs_2025_base_mraps_Rain_INT_SoundSet","truck_01_tires_water_fast_int_soundset","truck_01_tires_water_slow_int_soundset","truck_01_tires_turn_hard_int_soundset","truck_01_tires_turn_soft_int_soundset","truck_01_tires_brake_hard_int_soundset","truck_01_tires_brake_soft_int_soundset"};
		};
	};
	class CUP_BTR80_Common_Base : Wheeled_APC_F {
		class Sounds {
			soundsetsext[] = {"jsrs_2025_apc_w_02_engine_ext_idle_soundset","jsrs_2025_apc_w_02_engine_ext_drive_soundset","jsrs_2025_base_apcs_engine_rev_old_soundset","jsrs_2025_apc_w_02_engine_evr_soundset","jsrs_2025_apc_w_02_engine_ext_release_soundset","jsrs_2025_apc_w_02_engine_ext_distance_soundset","jsrs_2025_tires_asphalt_slow_ext_soundset","jsrs_2025_tires_asphalt_fast_ext_soundset","jsrs_2025_tires_asphalt_fast_far_soundset","jsrs_2025_tires_offroad_slow_ext_soundset","jsrs_2025_tires_offroad_fast_ext_soundset","jsrs_2025_tires_grass_ext_soundset","jsrs_2025_base_apcs_rattle_ext_soundset","jsrs_2025_base_apcs_stress_ext_soundset","truck_01_rain_ext_soundset","truck_01_tires_water_fast_ext_soundset","truck_01_tires_water_slow_ext_soundset","truck_01_tires_turn_hard_ext_soundset","truck_01_tires_turn_soft_ext_soundset","truck_01_tires_brake_hard_ext_soundset","truck_01_tires_brake_soft_ext_soundset"};
			soundsetsint[] = {"jsrs_2025_apc_w_02_engine_int_idle_soundset","jsrs_2025_apc_w_02_engine_int_drive_soundset","jsrs_2025_base_apcs_engine_int_rev_old_soundset","jsrs_2025_apc_w_02_engine_int_release_soundset","jsrs_2025_tires_asphalt_slow_int_soundset","jsrs_2025_tires_asphalt_fast_int_soundset","jsrs_2025_tires_offroad_slow_int_soundset","jsrs_2025_tires_offroad_fast_int_soundset","jsrs_2025_tires_grass_int_soundset","jsrs_2025_wheeled_driving_noises_int_car_1_soundset","jsrs_2025_wheeled_offroad_driving_noises_int_car_1_soundset","jsrs_2025_base_apcs_rattle_int_soundset","jsrs_2025_base_apcs_stress_int_soundset","jsrs_2025_base_mraps_Rain_INT_SoundSet","truck_01_tires_water_fast_int_soundset","truck_01_tires_water_slow_int_soundset","truck_01_tires_turn_hard_int_soundset","truck_01_tires_turn_soft_int_soundset","truck_01_tires_brake_hard_int_soundset","truck_01_tires_brake_soft_int_soundset"};
		};
	};
	class APC_Wheeled_01_base_F;
	// textures[] = {"CDF_Ext_BTR80\data\textures\body_camo_co.paa","CDF_Ext_BMP2\data\textures\2m3\bmp3_body2_camo_co.paa"};
#if __has_include("CDF_Ext_BTR80\data\textures\body_camo_co.paa")
	class CDF_Ext_BTR80_Base : APC_Wheeled_01_base_F {
		class Sounds {
			soundsetsext[] = {"jsrs_2025_apc_w_02_engine_ext_idle_soundset","jsrs_2025_apc_w_02_engine_ext_drive_soundset","jsrs_2025_base_apcs_engine_rev_old_soundset","jsrs_2025_apc_w_02_engine_evr_soundset","jsrs_2025_apc_w_02_engine_ext_release_soundset","jsrs_2025_apc_w_02_engine_ext_distance_soundset","jsrs_2025_tires_asphalt_slow_ext_soundset","jsrs_2025_tires_asphalt_fast_ext_soundset","jsrs_2025_tires_asphalt_fast_far_soundset","jsrs_2025_tires_offroad_slow_ext_soundset","jsrs_2025_tires_offroad_fast_ext_soundset","jsrs_2025_tires_grass_ext_soundset","jsrs_2025_base_apcs_rattle_ext_soundset","jsrs_2025_base_apcs_stress_ext_soundset","truck_01_rain_ext_soundset","truck_01_tires_water_fast_ext_soundset","truck_01_tires_water_slow_ext_soundset","truck_01_tires_turn_hard_ext_soundset","truck_01_tires_turn_soft_ext_soundset","truck_01_tires_brake_hard_ext_soundset","truck_01_tires_brake_soft_ext_soundset"};
			soundsetsint[] = {"jsrs_2025_apc_w_02_engine_int_idle_soundset","jsrs_2025_apc_w_02_engine_int_drive_soundset","jsrs_2025_base_apcs_engine_int_rev_old_soundset","jsrs_2025_apc_w_02_engine_int_release_soundset","jsrs_2025_tires_asphalt_slow_int_soundset","jsrs_2025_tires_asphalt_fast_int_soundset","jsrs_2025_tires_offroad_slow_int_soundset","jsrs_2025_tires_offroad_fast_int_soundset","jsrs_2025_tires_grass_int_soundset","jsrs_2025_wheeled_driving_noises_int_car_1_soundset","jsrs_2025_wheeled_offroad_driving_noises_int_car_1_soundset","jsrs_2025_base_apcs_rattle_int_soundset","jsrs_2025_base_apcs_stress_int_soundset","jsrs_2025_base_mraps_Rain_INT_SoundSet","truck_01_tires_water_fast_int_soundset","truck_01_tires_water_slow_int_soundset","truck_01_tires_turn_hard_int_soundset","truck_01_tires_turn_soft_int_soundset","truck_01_tires_brake_hard_int_soundset","truck_01_tires_brake_soft_int_soundset"};
		};
	};
#endif
	class Tank_F;
	class CUP_leopard_1A3_base : Tank_F {
		class Sounds {
			soundSetsExt[] = {"jsrs_2025_apc_t_01_engine_ext_idle_soundset","jsrs_2025_apc_t_01_engine_ext_drive_soundset","jsrs_2025_apc_t_01_engine_evr_soundset","jsrs_2025_apc_t_01_engine_ext_release_soundset","jsrs_2025_apc_t_01_engine_ext_distance_soundset","jsrs_2025_tracks_modern_light_soundset","jsrs_2025_tracks_modern_light_distance_soundset","jsrs_2025_base_tanks_rattle_ext_soundset","jsrs_2025_base_tanks_stress_ext_soundset","apc_tracked_01_rain_ext_soundset","apc_tracked_01_tracks_brake_hard_ext_soundset","apc_tracked_01_tracks_brake_soft_ext_soundset","apc_tracked_01_tracks_turn_hard_ext_soundset","apc_tracked_01_tracks_turn_soft_ext_soundset","apc_tracked_01_drive_water_ext_soundset","apc_tracked_01_drive_dirt_ext_soundset","tracks_movement_dirt_ext_01_soundset","tracks_surface_soft_ext_soundset","tracks_surface_hard_ext_soundset","tracks_surface_sand_ext_soundset"};
			soundSetsInt[] = {"jsrs_2025_apc_t_01_engine_int_idle_soundset","jsrs_2025_apc_t_01_engine_int_drive_soundset","jsrs_2025_apc_t_01_engine_int_release_soundset","jsrs_2025_tracks_interior_modern_light_soundset","jsrs_2025_base_tanks_rattle_int_soundset","jsrs_2025_base_tanks_stress_int_soundset","jsrs_2025_base_apcs_Rain_INT_SoundSet","apc_tracked_01_tracks_brake_hard_int_soundset","apc_tracked_01_tracks_brake_soft_int_soundset","apc_tracked_01_tracks_turn_hard_int_soundset","apc_tracked_01_tracks_turn_soft_int_soundset","apc_tracked_01_drive_water_int_soundset","apc_tracked_01_drive_dirt_int_soundset","tracks_movement_dirt_int_01_soundset","tracks_surface_soft_int_soundset","tracks_surface_hard_int_soundset","tracks_surface_sand_int_soundset"};
		};
	};


	// no grunting
	class Man;
	class CAManBase : Man {
		class SoundEnvironExt {
			generic[] = {{"healself",{"\A3\Sounds_F\characters\ingame\AinvPknlMstpSlayWrflDnon_medic",0.891251,1,20}},{"healselfprone",{"\A3\Sounds_F\characters\ingame\AinvPpneMstpSlayWrflDnon_medic",0.891251,1,20}},{"healselfpistolkneelin",{"\A3\Sounds_F\characters\ingame\AinvPknlMstpSlayWpstDnon_medicIn",0.891251,1,20}},{"healselfpistolkneel",{"\A3\Sounds_F\characters\ingame\AinvPknlMstpSlayWpstDnon_medic",0.891251,1,20}},{"healselfpistolkneelout",{"\A3\Sounds_F\characters\ingame\AinvPknlMstpSlayWpstDnon_medicOut",0.891251,1,20}},{"healselfpistolpromein",{"\A3\Sounds_F\characters\ingame\AinvPpneMstpSlayWpstDnon_medicin",0.891251,1,20}},{"healselfpistolprone",{"\A3\Sounds_F\characters\ingame\AinvPpneMstpSlayWpstDnon_medic",0.891251,1,20}},{"healselfpistolpromeout",{"\A3\Sounds_F\characters\ingame\AinvPpneMstpSlayWpstDnon_medicOut",0.891251,1,20}},{"roll",{"a3\sounds_f\characters\movements\roll\concrete_roll_1",1,1,20}},{"roll",{"a3\sounds_f\characters\movements\roll\concrete_roll_2",1,1,20}},{"roll",{"a3\sounds_f\characters\movements\roll\concrete_roll_3",1,1,20}},{"roll_unarmed",{"a3\sounds_f\characters\movements\roll\unarmed_concrete_roll_1",1,1,20}},{"roll_unarmed",{"a3\sounds_f\characters\movements\roll\unarmed_concrete_roll_2",1,1,20}},{"roll_unarmed",{"a3\sounds_f\characters\movements\roll\unarmed_concrete_roll_3",1,1,20}},{"adjust_short",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short1.wss",1,1,20}},{"adjust_short",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short2.wss",1,1,20}},{"adjust_short",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short3.wss",1,1,20}},{"adjust_short",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short4.wss",1,1,20}},{"adjust_short",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short5.wss",1,1,20}},{"adjust_stand_to_left_prone",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short1.wss",1,1,20}},{"adjust_stand_to_right_prone",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short1.wss",1,1,20}},{"adjust_kneelhigh_to_standlow",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short3.wss",1,1,20}},{"adjust_standlow_to_kneelhigh",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short1.wss",1,1,20}},{"over_the_obstacle_slow",{"z\jsrs2025\addons\sounds_character\sounds\stances\over_the_obstacle_slow.wss",1,1,20}},{"over_the_obstacle_fast",{"z\jsrs2025\addons\sounds_character\sounds\stances\over_the_obstacle_fast.wss",1,1,20}},{"overstep",{"z\jsrs2025\addons\sounds_character\sounds\stances\over_the_obstacle_fast.wss",1,1,20}},{"overstep",{"z\jsrs2025\addons\sounds_character\sounds\stances\over_the_obstacle_fast.wss",1,1,20}},{"grenade_throw",{"z\jsrs2025\addons\sounds_character\sounds\stances\grenade_throw1.wss",1.5,1,30}},{"grenade_throw",{"z\jsrs2025\addons\sounds_character\sounds\stances\grenade_throw2.wss",1.5,1,30}},{"grenade_throw",{"z\jsrs2025\addons\sounds_character\sounds\stances\grenade_throw3.wss",1.5,1,30}},{"grenade_throw",{"z\jsrs2025\addons\sounds_character\sounds\stances\grenade_throw4.wss",1.5,1,30}},{"grenade_throw",{"z\jsrs2025\addons\sounds_character\sounds\stances\grenade_throw5.wss",1.5,1,30}},{"grenade_throw",{"z\jsrs2025\addons\sounds_character\sounds\stances\grenade_throw6.wss",1.5,1,30}},{"inventory_in",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short1.wss",1,1,20}},{"inventory_out",{"z\jsrs2025\addons\sounds_character\sounds\stances\adjust_short2.wss",1,1,20}},{"handgun_to_rifle",{"z\jsrs2025\addons\sounds_character\sounds\stances\handgun_to_rifle.wss",1,1,20}},{"handgun_to_launcher",{"z\jsrs2025\addons\sounds_character\sounds\stances\handgun_to_launcher.wss",1,1,20}},{"launcher_to_rifle",{"z\jsrs2025\addons\sounds_character\sounds\stances\launcher_to_rifle.wss",1,1,20}},{"launcher_to_handgun",{"z\jsrs2025\addons\sounds_character\sounds\stances\launcher_to_handgun.wss",1,1,20}},{"rifle_to_handgun",{"z\jsrs2025\addons\sounds_character\sounds\stances\rifle_to_handgun.wss",1,1,20}},{"rifle_to_handgun_prn",{"z\jsrs2025\addons\sounds_character\sounds\stances\rifle_to_handgun_prn.wss",1,1,20}},{"rifle_to_launcher",{"z\jsrs2025\addons\sounds_character\sounds\stances\rifle_to_launcher.wss",1,1,20}},{"rifle_to_binoc",{"z\jsrs2025\addons\sounds_character\sounds\stances\rifle_to_binoculars.wss",1,1,20}},{"handgun_to_binoc",{"z\jsrs2025\addons\sounds_character\sounds\stances\handgun_to_binoculars.wss",1,1,20}},{"launcher_to_binoc",{"z\jsrs2025\addons\sounds_character\sounds\stances\launcher_to_binoculars.wss",1,1,20}},{"launcher_to_binoc_knl",{"z\jsrs2025\addons\sounds_character\sounds\stances\launcher_to_binoculars_knl.wss",1,1,20}},{"unarmed_to_binoc",{"z\jsrs2025\addons\sounds_character\sounds\stances\unarmed_to_binoculars.wss",1,1,20}},{"binoc_to_rifle",{"z\jsrs2025\addons\sounds_character\sounds\stances\binoculars_to_rifle.wss",1,1,20}},{"binoc_to_rifle_2",{"z\jsrs2025\addons\sounds_character\sounds\stances\binoculars_to_rifle_2.wss",1,1,20}},{"binoc_to_handgun",{"z\jsrs2025\addons\sounds_character\sounds\stances\binoculars_to_handgun.wss",1,1,20}},{"binoc_to_launcher",{"z\jsrs2025\addons\sounds_character\sounds\stances\binoculars_to_launcher.wss",1,1,20}},{"binoc_to_unarmed",{"z\jsrs2025\addons\sounds_character\sounds\stances\binoculars_to_unarmed.wss",1,1,20}},{"low_rifle",{"z\jsrs2025\addons\sounds_character\sounds\stances\low_rifle.wss",1,1,20}},{"lift_rifle",{"z\jsrs2025\addons\sounds_character\sounds\stances\lift_rifle.wss",1,1,20}},{"low_handgun",{"z\jsrs2025\addons\sounds_character\sounds\stances\low_handgun.wss",1,1,20}},{"lift_handgun",{"z\jsrs2025\addons\sounds_character\sounds\stances\lift_handgun.wss",1,1,20}},{"ladder",{"\a3\sounds_f\characters\movements\ladder\ladder_01",1,1,20}},{"ladder",{"\a3\sounds_f\characters\movements\ladder\ladder_02",1,1,20}},{"ladder",{"\a3\sounds_f\characters\movements\ladder\ladder_03",1,1,20}},{"ladder",{"\a3\sounds_f\characters\movements\ladder\ladder_04",1,1,20}},{"ladder",{"\a3\sounds_f\characters\movements\ladder\ladder_05",1,1,20}},{"ladder",{"\a3\sounds_f\characters\movements\ladder\ladder_06",1,1,20}},{"swim",{"soundset","movement_swim_soundset"}},{"heli_get_in_init",{"soundset","heli_get_in_init_soundset"}},{"acts_crouchgetlowgesture",{"\a3\sounds_f\characters\cutscenes\acts_crouchgetlowgesture",1,1,20}},{"acts_listeningtoradio_in",{"a3\sounds_f\characters\cutscenes\acts_listeningtoradio_in",1,1,20}},{"acts_listeningtoradio_loop",{"\a3\sounds_f\dummysound",1,1,20}},{"acts_listeningtoradio_out",{"\a3\sounds_f\characters\cutscenes\acts_listeningtoradio_out",1,1,20}},{"acts_lyingwounded_loop1",{"\a3\sounds_f\characters\cutscenes\acts_lyingwounded_loop1",1,1,20}},{"acts_lyingwounded_loop2",{"\a3\sounds_f\characters\cutscenes\acts_lyingwounded_loop2",1,1,20}},{"acts_lyingwounded_loop3",{"\a3\sounds_f\characters\cutscenes\acts_lyingwounded_loop3",1,1,20}},{"acts_navigatingchopper_in",{"\a3\sounds_f\characters\cutscenes\acts_navigatingchopper_in",1,1,20}},{"acts_navigatingchopper_loop",{"\a3\sounds_f\characters\cutscenes\acts_navigatingchopper_loop",1,1,20}},{"acts_navigatingchopper_out",{"\a3\sounds_f\characters\cutscenes\acts_navigatingchopper_out",1,1,20}},{"acts_percmstpslowwrfldnon_handup1",{"\a3\sounds_f\characters\cutscenes\acts_percmstpslowwrfldnon_handup1",1,1,20}},{"acts_percmstpslowwrfldnon_handup1b",{"\a3\sounds_f\characters\cutscenes\acts_percmstpslowwrfldnon_handup1b",1,1,20}},{"acts_percmstpslowwrfldnon_handup1c",{"\a3\sounds_f\characters\cutscenes\acts_percmstpslowwrfldnon_handup1c",1,1,20}},{"acts_percmstpslowwrfldnon_handup2",{"\a3\sounds_f\characters\cutscenes\acts_percmstpslowwrfldnon_handup2",1,1,20}},{"acts_percmstpslowwrfldnon_handup2b",{"\a3\sounds_f\characters\cutscenes\acts_percmstpslowwrfldnon_handup2b",1,1,20}},{"acts_percmstpslowwrfldnon_handup2c",{"\a3\sounds_f\characters\cutscenes\acts_percmstpslowwrfldnon_handup2c",1,1,20}},{"acts_signaltocheck",{"\a3\sounds_f\characters\cutscenes\acts_signaltocheck",1,1,20}},{"acts_showingtherightway_in",{"\a3\sounds_f\characters\cutscenes\acts_showingtherightway_in",1,1,20}},{"acts_showingtherightway_loop",{"\a3\sounds_f\characters\cutscenes\acts_showingtherightway_loop",1,1,20}},{"acts_showingtherightway_out",{"\a3\sounds_f\characters\cutscenes\acts_showingtherightway_out",1,1,20}},{"acts_shieldfromsun_loop",{"\a3\sounds_f\dummysound",1,1,20}},{"acts_shieldfromsun_out",{"\a3\sounds_f\characters\cutscenes\acts_shieldfromsun_out",1,1,20}},{"acts_treatingwounded01",{"\a3\sounds_f\characters\cutscenes\acts_treatingwounded01",1,1,20}},{"acts_treatingwounded02",{"\a3\sounds_f\characters\cutscenes\acts_treatingwounded02",1,1,20}},{"acts_treatingwounded03",{"\a3\sounds_f\characters\cutscenes\acts_treatingwounded03",1,1,20}},{"acts_treatingwounded04",{"\a3\sounds_f\characters\cutscenes\acts_treatingwounded04",1,1,20}},{"acts_treatingwounded05",{"\a3\sounds_f\characters\cutscenes\acts_treatingwounded05",1,1,20}},{"acts_treatingwounded06",{"\a3\sounds_f\characters\cutscenes\acts_treatingwounded06",1,1,20}},{"acts_aidlpercmstpslowwrfldnon_pissing",{"\a3\sounds_f\characters\cutscenes\acts_aidlpercmstpslowwrfldnon_pissing",1,1,20}},{"acts_boatattacked01",{"\a3\sounds_f\characters\cutscenes\acts_boatattacked01",1,1,20}},{"acts_boatattacked02",{"\a3\sounds_f\characters\cutscenes\acts_boatattacked02",1,1,20}},{"acts_boatattacked03",{"\a3\sounds_f\characters\cutscenes\acts_boatattacked03",1,1,20}},{"acts_boatattacked04",{"\a3\sounds_f\characters\cutscenes\acts_boatattacked04",1,1,20}},{"acts_boatattacked05",{"\a3\sounds_f\characters\cutscenes\acts_boatattacked05",1,1,20}},{"acts_crouchingcoveringrifle01",{"\a3\sounds_f\characters\cutscenes\acts_crouchingcoveringrifle01",1,1,20}},{"acts_crouchingidlerifle01",{"\a3\sounds_f\characters\cutscenes\acts_crouchingidlerifle01",1,1,20}},{"acts_crouchingreloadingrifle01",{"\a3\sounds_f\characters\cutscenes\acts_crouchingreloadingrifle01",1,1,20}},{"acts_crouchingwatchingrifle01",{"\a3\sounds_f\characters\cutscenes\acts_crouchingwatchingrifle01",1,1,20}},{"acts_injuredangryrifle01",{"\a3\sounds_f\characters\cutscenes\acts_injuredangryrifle01",1,1,20}},{"acts_injuredcoughrifle02",{"\a3\sounds_f\characters\cutscenes\acts_injuredcoughrifle02",1,1,20}},{"acts_injuredlookingrifle01",{"\a3\sounds_f\characters\cutscenes\acts_injuredlookingrifle01",1,1,20}},{"acts_injuredlookingrifle02",{"\a3\sounds_f\characters\cutscenes\acts_injuredlookingrifle02",1,1,20}},{"acts_injuredlookingrifle03",{"\a3\sounds_f\characters\cutscenes\acts_injuredlookingrifle03",1,1,20}},{"acts_injuredlookingrifle04",{"\a3\sounds_f\characters\cutscenes\acts_injuredlookingrifle04",1,1,20}},{"acts_injuredlookingrifle05",{"\a3\sounds_f\characters\cutscenes\acts_injuredlookingrifle05",1,1,20}},{"acts_injuredlyingrifle01",{"\a3\sounds_f\characters\cutscenes\acts_injuredlyingrifle01",1,1,20}},{"acts_injuredspeakingrifle01",{"\a3\sounds_f\characters\cutscenes\acts_injuredspeakingrifle01",1,1,20}},{"acts_pknlmstpslowwrfldnon",{"\a3\sounds_f\characters\cutscenes\acts_pknlmstpslowwrfldnon",1,1,20}},{"acts_sittingjumpingsaluting_loop1",{"\a3\sounds_f\characters\cutscenes\acts_sittingjumpingsaluting_loop1",1,1,20}},{"acts_sittingjumpingsaluting_loop2",{"\a3\sounds_f\characters\cutscenes\acts_sittingjumpingsaluting_loop2",1,1,20}},{"acts_sittingjumpingsaluting_loop3",{"\a3\sounds_f\characters\cutscenes\acts_sittingjumpingsaluting_loop3",1,1,20}},{"amovpercmstpsnonwnondnon_exercisekneebenda",{"\a3\sounds_f\characters\cutscenes\amovpercmstpsnonwnondnon_exercisekneebenda",1,1,20}}};
		};
	};
	//*/
};